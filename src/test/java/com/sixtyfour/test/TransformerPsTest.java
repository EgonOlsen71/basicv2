package com.sixtyfour.test;

import java.io.PrintWriter;
import java.util.List;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.powerscript.PlatformPs;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.config.LoopMode;
import com.sixtyfour.config.MemoryConfig;

public class TransformerPsTest {

    private static String path = "compiled/";

    public static void main(String[] args) throws Exception {
	// test2();
	testPrime();
	testBeer();
	testLevenshtein();
	testCharFractal();
    }

    private static void testCharFractal() throws Exception {
	String[] vary = Loader.loadProgram("src/test/resources/transform/charfractal.bas");
	List<String> js = initTestEnvironment(vary);
	write(js, path + "++charfractal.ps1");
    }

    private static void testLevenshtein() throws Exception {
	String[] vary = Loader.loadProgram("src/test/resources/transform/levenshtein.bas");
	List<String> js = initTestEnvironment(vary);
	write(js, path + "++levenshtein.ps1");
    }

    private static void test2() throws Exception {
	String[] vary = Loader.loadProgram("src/test/resources/transform/test2.bas");
	List<String> js = initTestEnvironment(vary);
	write(js, path + "++test2.ps1");
    }

    private static void testPrime() throws Exception {
	String[] vary = Loader.loadProgram("src/test/resources/transform/prime_transform.bas");
	List<String> js = initTestEnvironment(vary);
	write(js, path + "++prime.ps1");
    }

    private static void testBeer() throws Exception {
	String[] vary = Loader.loadProgram("src/test/resources/transform/beer_transform.bas");
	List<String> js = initTestEnvironment(vary);
	write(js, path + "++beer.ps1");
    }

    private static List<String> initTestEnvironment(String[] vary) {
	CompilerConfig conf = new CompilerConfig();
	boolean opt = true;
	conf.setConstantFolding(opt);
	conf.setConstantPropagation(opt);
	conf.setDeadStoreElimination(false);
	conf.setDeadStoreEliminationOfStrings(false);
	conf.setIntermediateLanguageOptimizations(opt);
	conf.setNativeLanguageOptimizations(opt);
	conf.setOptimizedLinker(opt);
	conf.setLoopMode(LoopMode.REMOVE);

	// Disable these for JS-Target
	conf.setLoopOptimizations(false);
	conf.setIntOptimizations(false);
	conf.setShiftOptimizations(false);

	final Basic basic = new Basic(vary);
	basic.compile(conf);

	List<String> mCode = NativeCompiler.getCompiler().compileToPseudeCode(conf, basic);
	System.out.println("------------------------------");
	for (String line : mCode) {
	    System.out.println(line);
	}
	System.out.println("------------------------------");

	MemoryConfig memConfig = new MemoryConfig();
	List<String> nCode = NativeCompiler.getCompiler().compile(conf, basic, memConfig, new PlatformPs());
	for (String line : nCode) {
	    System.out.println(line);
	}

	return nCode;
    }

    private static void write(List<String> code, String file) {
	System.out.println("Writing file: " + file);
	try (PrintWriter pw = new PrintWriter(file)) {
	    for (String line : code) {
		pw.println(line);
	    }
	} catch (Exception e) {
	    System.out.println("Failed to write file '" + file + "': " + e.getMessage());
	}
    }

}
