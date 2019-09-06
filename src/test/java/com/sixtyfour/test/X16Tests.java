package com.sixtyfour.test;

import java.util.List;

import com.sixtyfour.Assembler;
import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.PseudoCpu;
import com.sixtyfour.cbmnative.mos6502.c64.Platform64;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.config.LoopMode;
import com.sixtyfour.config.MemoryConfig;
import com.sixtyfour.extensions.x16.X16Extensions;
import com.sixtyfour.system.FileWriter;

/**
 * @author Foerster-H
 *
 */
public class X16Tests {

	private static String path = "compiled/";

	public static void main(String[] args) throws Exception {
		testVpoke();
		testVpeek();
		testVpokePeek();
		testColors();
	}

	private static void testColors() throws Exception {
		System.out.println("\n\ntestColors");
		String[] vary = Loader.loadProgram("src/test/resources/x16/colors.bas");
		Assembler assy = initTestEnvironment(vary, true, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++colors.prg", true);
	}
	
	private static void testVpokePeek() throws Exception {
		System.out.println("\n\ntestVpokePeek");
		String[] vary = Loader.loadProgram("src/test/resources/x16/vpokepeek.bas");
		Assembler assy = initTestEnvironment(vary, true, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++vpokepeek.prg", true);
	}

	private static void testVpoke() throws Exception {
		System.out.println("\n\ntestVpoke");
		String[] vary = Loader.loadProgram("src/test/resources/x16/vpoke.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++vpoke.prg", true);
	}

	private static void testVpeek() throws Exception {
		System.out.println("\n\ntestVpeek");
		String[] vary = Loader.loadProgram("src/test/resources/x16/vpeek.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++vpeek.prg", true);
	}

	private static Assembler initTestEnvironment(String[] vary) {
		return initTestEnvironment(vary, false);
	}

	private static Assembler initTestEnvironment(String[] vary, boolean executePseudo) {
		return initTestEnvironment(vary, executePseudo, -1);
	}

	private static Assembler initTestEnvironment(String[] vary, boolean executePseudo, int variableStart) {
		return initTestEnvironment(vary, executePseudo, -1, true);
	}

	private static Assembler initTestEnvironment(String[] vary, boolean executePseudo, int variableStart,
			boolean opti) {
		CompilerConfig conf = new CompilerConfig();
		boolean opt = opti;
		conf.setConstantFolding(opt);
		conf.setConstantPropagation(opt);
		conf.setDeadStoreElimination(opt);
		conf.setDeadStoreEliminationOfStrings(opt);
		conf.setIntermediateLanguageOptimizations(opt);
		conf.setNativeLanguageOptimizations(opt);
		conf.setOptimizedLinker(opt);
		conf.setIntOptimizations(opt);
		conf.setLoopMode(LoopMode.REMOVE);
		conf.setNonDecimalNumbersAware(true);
		// conf.setCompactThreshold(3);

		Basic basic = new Basic(vary);
		Basic.registerExtension(new X16Extensions());
		basic.compile(conf);

		List<String> mCode = NativeCompiler.getCompiler().compileToPseudoCode(conf, basic);
		System.out.println("------------------------------");
		for (String line : mCode) {
			System.out.println(line);
		}
		System.out.println("------------------------------");

		if (executePseudo) {
			System.out.println("Running pseudo code...");
			PseudoCpu pc = new PseudoCpu();
			pc.execute(conf, basic.getMachine(), mCode);
		}
		System.out.println("------------------------------");

		basic = new Basic(vary);
		MemoryConfig memConfig = new MemoryConfig();
		memConfig.setVariableStart(variableStart);
		List<String> nCode = NativeCompiler.getCompiler().compile(conf, basic, memConfig, new Platform64());
		for (String line : nCode) {
			System.out.println(line);
		}

		final Assembler assy = new Assembler(nCode);
		assy.compile(conf);

		return assy;
	}
}
