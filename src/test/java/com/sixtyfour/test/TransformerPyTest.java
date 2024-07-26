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
import com.sixtyfour.extensions.x16.X16Extensions;

public class TransformerPyTest {

	private static String path = "compiled/";

	public static void main(String[] args) throws Exception {
		testData();
	}

	private static void testData() throws Exception {
		String[] vary = Loader.loadProgram("src/test/resources/transform/test23.bas");
		List<String> js = initTestEnvironment(vary);
		write(js, path + "++testdata.py");
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
