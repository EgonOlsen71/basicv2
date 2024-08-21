package com.sixtyfour.test;

import java.util.List;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.PseudoCpu;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.config.LoopMode;

public class ILangTest {

	public static void main(String[] args) {
		testIlangCalc();
	}

	private static void testIlangCalc() {
		System.out.println("\n\testIlangCalc");
		String[] vary = Loader.loadProgram("src/test/resources/transform/calcilang.bas");
		initTestEnvironment(vary);
	}
	
	private static void initTestEnvironment(String[] vary) {
		CompilerConfig conf = new CompilerConfig();
		boolean opt = true;
		conf.setConstantFolding(opt);
		conf.setConstantPropagation(opt);
		conf.setDeadStoreElimination(opt);
		conf.setDeadStoreEliminationOfStrings(opt);
		conf.setIntermediateLanguageOptimizations(true);
		conf.setNativeLanguageOptimizations(opt);
		conf.setOptimizedLinker(opt);
		conf.setIntOptimizations(opt);
		conf.setFloatOptimizations(false);
		conf.setLoopMode(LoopMode.REMOVE);
		
		Basic basic = new Basic(vary);
		basic.compile(conf);

		List<String> mCode = NativeCompiler.getCompiler().compileToPseudoCode(conf, basic);
		System.out.println("------------------------------");
		for (String line : mCode) {
			System.out.println(line);
		}
		System.out.println("------------------------------");

		System.out.println("Running pseudo code...");
		PseudoCpu pc = new PseudoCpu();
		pc.execute(conf, basic.getMachine(), mCode);

	}
	
}
