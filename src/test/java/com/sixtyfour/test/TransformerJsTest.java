package com.sixtyfour.test;

import java.io.PrintWriter;
import java.util.List;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.Transformer;
import com.sixtyfour.cbmnative.javascript.PlatformJs;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.config.LoopMode;
import com.sixtyfour.config.MemoryConfig;
import com.sixtyfour.extensions.x16.X16Extensions;

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
		test18();
		test15();
		testLevenshtein();
		testCmd();
		testOpen();
		testData();
		testLoad();
		test17();
		testRun();
		testBenchmark();
		testCharFractal();
	}


	private static void testCharFractal() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/charfractal.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++charfractal.js");
	}

	private static void testBenchmark() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/js/benchmark2.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++benchmark2.js");
	}

	private static void testRun() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/testrun.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++testrun.js");
	}

	private static void test17() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/test17.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++test17.js");
	}

	private static void testLoad() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/testload.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++testload.js");
	}

	private static void testData() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/test23.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++testdata.js");
	}

	private static void testOpen() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/testopen.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++testopen.js");
	}

	private static void testCmd() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/testcmd.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++testcmd.js");
	}

	private static void testLevenshtein() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/levenshtein.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++levenshtein.js");
	}

	private static void test2() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/test2.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++test2.js");
	}

	private static void test4() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/test4.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++test4.js");
	}

	private static void test9() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/test9.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++test9.js");
	}

	private static void test16() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/test16.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++test16.js");
	}

	private static void test22() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/test22.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++test22.js");
	}

	private static void test18() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/test18.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++test18.js");
	}

	private static void test15() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/test15.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++test15.js");
	}

	private static void testFractal() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/js/fractal.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++fractal.js");
	}

	private static void testPrime() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/prime_transform.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++prime.js");
	}

	private static void testBeer() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/beer_transform.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++beer.js");
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
		List<String> nCode = NativeCompiler.getCompiler().compile(conf, basic, memConfig, new PlatformJs());
		for (String line : nCode) {
			System.out.println(line);
		}

		return nCode;
	}

	private static void write(List<String> code, String file) {
		System.out.println("Writing file: " + file);
		Transformer trsn = new PlatformJs().getTransformer();
		try (PrintWriter pw = new PrintWriter(file); PrintWriter cpw = new PrintWriter(file.replace(".js", ".html"))) {
			for (String line : code) {
				pw.println(line);
			}
			String[] parts = file.replace("\\", "/").split("/");
			for (String line : trsn.createCaller(parts[parts.length - 1])) {
				cpw.println(line);
			}
		} catch (Exception e) {
			System.out.println("Failed to write file '" + file + "': " + e.getMessage());
		}
	}

}
