package com.sixtyfour.test;

import java.io.PrintWriter;
import java.util.List;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.javascript.PlatformJs;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.config.LoopMode;
import com.sixtyfour.config.MemoryConfig;

public class TransformerJsText {

    private static String path = "compiled/";

    public static void main(String[] args) throws Exception {
	test2();
	testPrime();
	testBeer();
	test9();
    }

    private static void test2() throws Exception {
	String[] vary = Loader.loadProgram("src/test/resources/transform/test2.bas");
	List<String> js = initTestEnvironment(vary);
	write(js, path + "++test2.html");
    }
    
    private static void test9() throws Exception {
   	String[] vary = Loader.loadProgram("src/test/resources/transform/test9.bas");
   	List<String> js = initTestEnvironment(vary);
   	write(js, path + "++test9.html");
       }
    
    private static void testPrime() throws Exception {
	String[] vary = Loader.loadProgram("src/test/resources/transform/prime_transform.bas");
	List<String> js = initTestEnvironment(vary);
	write(js, path + "++prime.html");
    }
    
    private static void testBeer() throws Exception {
   	String[] vary = Loader.loadProgram("src/test/resources/transform/beer_transform.bas");
   	List<String> js = initTestEnvironment(vary);
   	write(js, path + "++beer.html");
       }

    private static List<String> initTestEnvironment(String[] vary) {
	CompilerConfig conf = new CompilerConfig();
	boolean opt = true;
	conf.setConstantFolding(false);
	conf.setConstantPropagation(false);
	conf.setDeadStoreElimination(false);
	conf.setDeadStoreEliminationOfStrings(false);
	conf.setIntermediateLanguageOptimizations(opt);
	conf.setNativeLanguageOptimizations(opt);
	conf.setOptimizedLinker(opt);
	conf.setIntOptimizations(opt);
	conf.setLoopMode(LoopMode.REMOVE);
	// conf.setCompactThreshold(3);

	final Basic basic = new Basic(vary);
	basic.compile(conf);

	List<String> mCode = NativeCompiler.getCompiler().compileToPseudeCode(conf, basic);
	System.out.println("------------------------------");
	for (String line : mCode) {
	    System.out.println(line);
	}
	System.out.println("------------------------------");

	MemoryConfig memConfig = new MemoryConfig();
	List<String> nCode = NativeCompiler.getCompiler().compile(conf, basic, memConfig, new PlatformJs());
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
