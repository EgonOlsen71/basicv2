package com.sixtyfour.test;

import java.io.PrintWriter;
import java.util.List;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.python.PlatformPy;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.config.LoopMode;
import com.sixtyfour.config.MemoryConfig;

public class TransformerPyTest {

	private static String path = "compiled/";

	public static void main(String[] args) throws Exception {
		testData();
		testLyrix();
		testBenchmark2();
		testCharFractal();
		testLevenshtein();
		testPrime();
		testBeer();
		testTest32();
		testTest33();
		testFiles();
	}

	private static void testFiles() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/filetest.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++filetest.py");
	}
	
	private static void testTest33() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/test33.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++test33.py");
	}
	
	private static void testTest32() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/test32.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++test32.py");
	}
	
	private static void testData() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/test23.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++testdata.py");
	}
	
	private static void testLyrix() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/basic/lyrix_raw.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++lyrix.py");
	}

	private static void testBenchmark2() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/benchmark2.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++benchmark2.py");
	}

	private static void testCharFractal() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/charfractal2.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++charfractal.py");
	}

	private static void testLevenshtein() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/levenshtein.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++levenshtein.py");
	}

	private static void testPrime() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/prime_transform.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++prime.py");
	}

	private static void testBeer() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/beer_transform.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++beer.py");
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

		// Disable these for Py-Target
		conf.setLoopOptimizations(false);
		conf.setIntOptimizations(false);
		conf.setShiftOptimizations(false);
		conf.setAllIntermediateOptimizations(false);
		// conf.setCompactThreshold(3);

		Basic basic = new Basic(vary);
		basic.compile(conf);

		List<String> mCode = NativeCompiler.getCompiler().compileToPseudoCode(conf, basic);
		System.out.println("------------------------------");
		for (String line : mCode) {
			System.out.println(line);
		}
		System.out.println("------------------------------");

		MemoryConfig memConfig = new MemoryConfig();
		basic = new Basic(vary);
		List<String> nCode = NativeCompiler.getCompiler().compile(conf, basic, memConfig, new PlatformPy());
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
