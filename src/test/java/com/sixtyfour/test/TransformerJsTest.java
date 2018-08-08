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

public class TransformerJsTest {

    private static String path = "compiled/";

    public static void main(String[] args) throws Exception {
	test2();
	testPrime();
	testBeer();
	test9();
	test4();
	test16();
	testFractal();
	test22();
    }

    private static void test2() throws Exception {
	String[] vary = Loader.loadProgram("src/test/resources/transform/test2.bas");
	List<String> js = initTestEnvironment(vary);
	write(js, path + "++test2.html");
    }
    
    private static void test4() throws Exception {
   	String[] vary = Loader.loadProgram("src/test/resources/transform/test4.bas");
   	List<String> js = initTestEnvironment(vary);
   	write(js, path + "++test4.html");
    }
    
    private static void test9() throws Exception {
   	String[] vary = Loader.loadProgram("src/test/resources/transform/test9.bas");
   	List<String> js = initTestEnvironment(vary);
   	write(js, path + "++test9.html");
    }
    
    private static void test16() throws Exception {
   	String[] vary = Loader.loadProgram("src/test/resources/transform/test16.bas");
   	List<String> js = initTestEnvironment(vary);
   	write(js, path + "++test16.html");
    }
    
    private static void test22() throws Exception {
   	String[] vary = Loader.loadProgram("src/test/resources/transform/test22.bas");
   	List<String> js = initTestEnvironment(vary);
   	write(js, path + "++test22.html");
    }
    
    private static void testFractal() throws Exception {
   	String[] vary = Loader.loadProgram("src/test/resources/transform/js/fractal.bas");
   	List<String> js = initTestEnvironment(vary);
   	write(js, path + "++fractal.html");
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
