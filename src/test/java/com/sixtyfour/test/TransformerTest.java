package com.sixtyfour.test;

import java.awt.image.BufferedImage;
import java.io.FileOutputStream;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sixtyfour.Assembler;
import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.PseudoCpu;
import com.sixtyfour.cbmnative.mos6502.c64.Platform64;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.config.LoopMode;
import com.sixtyfour.config.MemoryConfig;
import com.sixtyfour.parser.Preprocessor;
import com.sixtyfour.parser.assembly.AssemblyParser;
import com.sixtyfour.system.Conversions;
import com.sixtyfour.system.Cpu;
import com.sixtyfour.system.CpuTracer;
import com.sixtyfour.system.FileWriter;
import com.sixtyfour.system.Graphics;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.Program;
import com.sixtyfour.system.ProgramPart;
import com.sixtyfour.test.helper.JsrProfiler;
import com.sixtyfour.test.helper.ProfilerData;

/*
 * @author EgonOlsen
 * 
 */
public class TransformerTest {

	private static CompilerConfig config = new CompilerConfig();
	private static String path = "compiled/";

	public static void main(String[] args) throws Exception {
		// testTransformer3();
		// testTransformer1();
		// testTransformer2();
		// testTransformer4();
		// testTransformer5();
//		 testTransformerFractal();
		// testTransformer6();
		// testTransformer7();
		 testTransformerPrime();
		// testTransformerSqr();
		// testTransformer8();
		// testTransformer9();
		// testTransformer10();
		// testTransformer11();
		// testTransformer12();
		// testTransformer13();
		// testTransformer14();
		// testTransformerBeer();
		// testTransformer15();
		// testTransformerSqr();
		// testTransformer16();
		// testTransformer17();
		// testTransformer18();
		// testTransformer20();
		// testTransformer22();
		// testTransformer23();
//		 testTransformerFrog();
//		 testTransformerAffine();
		// testTransformer24();
		// testTransformer25();
		// testTransformer26();
//		 testHilbert();
//		 testLines();
		// testTransformer27();
		// testConditions();
		// testTransformer28();
		// testTransformer29();
		// testTransformer30();
		// testBenchmark();
		// testBreakout();
		// testBbDemo();
		// testOpenPrint();
		// testScroll();
		// testOpen();
		// testCmd();
		// testTab();
		// testArrays();
		// testLoad();
		// testFn2();
		// testTwoFor();
		// testBrackets();
		// testQuicksort();
		// testInx();
		// testLabyrinth();
		// testFrosch();
//		testIfTest();
	    	//testRunner();
	    	//testIfNotTest();
	    	//testGcTest();
	    	//testSprites();
	    	testHidden();
	}

	private static void testHidden() throws Exception {
		System.out.println("\n\ntestHidden");
		String[] vary = Loader.loadProgram("src/test/resources/transform/hidden.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++hidden.prg", true);
		
		vary = Loader.loadProgram("src/test/resources/transform/hidden_asm.bas");
		assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++hidden_asm.prg", true);
	}
	
	private static void testSprites() throws Exception {
		System.out.println("\n\ntestSprites");
		String[] vary = Loader.loadProgram("src/test/resources/transform/sprites.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++sprites.prg", true);
	}
	
	private static void testGcTest() throws Exception {
		System.out.println("\n\ntestGcTest");
		String[] vary = Loader.loadProgram("src/test/resources/transform/gctest.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++gctest.prg", true);
	}
	
	private static void testRunner() throws Exception {
		System.out.println("\n\ntestRunner");
		String[] vary = Loader.loadProgram("src/test/resources/transform/basicrunner.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++basicrunner.prg", true);
	}
	
	private static void testFrosch() throws Exception {
		System.out.println("\n\ntestFrosch");
		String[] vary = Loader.loadProgram("src/test/resources/transform/frosch.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++frosch.prg", true);
		assy.getCpu().setCpuTracer(new MyTracer(assy));
		executeTest(assy);
	}

	private static void testQuicksort() throws Exception {
		System.out.println("\n\ntestQuicksort");
		String[] vary = Loader.loadProgram("src/test/resources/transform/quicksort.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++quicksort.prg", true);
		JsrProfiler profiler = new JsrProfiler(assy);
		assy.getCpu().setCpuTracer(profiler);
		Machine machine = executeTest(assy);
		printStats(profiler, machine);
	}

	private static void testLabyrinth() throws Exception {
		System.out.println("\n\ntestLabyrinth");
		String[] vary = Loader.loadProgram("src/test/resources/transform/irrgarten.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++irrgarten.prg", true);
	}

	private static void testInx() throws Exception {
		System.out.println("\n\ntestInx");
		String[] vary = Loader.loadProgram("src/test/resources/transform/testinx.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testinx.prg", true);
	}

	private static void testBrackets() throws Exception {
		System.out.println("\n\ntestBrackets");
		String[] vary = Loader.loadProgram("src/test/resources/transform/testbrackets.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testbrackets.prg", true);
	}

	private static void testTwoFor() throws Exception {
		System.out.println("\n\ntestTwoFor");
		String[] vary = Loader.loadProgram("src/test/resources/transform/twofor.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++twofor.prg", true);
	}

	private static void testFn2() throws Exception {
		System.out.println("\n\ntestLoad");
		String[] vary = Loader.loadProgram("src/test/resources/transform/testfn2.bas");
		Assembler assy = initTestEnvironment(vary, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testfn2.prg", true);
	}

	private static void testLoad() throws Exception {
		System.out.println("\n\ntestLoad");
		String[] vary = Loader.loadProgram("src/test/resources/transform/testload.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testload.prg", true);
	}

	private static void testArrays() throws Exception {
		System.out.println("\n\ntestArrays");
		String[] vary = Loader.loadProgram("src/test/resources/transform/testarrays.bas");
		Assembler assy = initTestEnvironment(vary, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testarrays.prg", true);
		// JsrProfiler profiler = new JsrProfiler(assy);
		// assy.getCpu().setCpuTracer(profiler);
		// Machine machine = executeTest(assy);
		// printStats(profiler, machine);
	}

	private static void testTab() throws Exception {
		System.out.println("\n\ntestTab");
		String[] vary = Loader.loadProgram("src/test/resources/transform/testtab.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testtab.prg", true);
	}

	private static void testCmd() throws Exception {
		System.out.println("\n\ntestCmd");
		String[] vary = Loader.loadProgram("src/test/resources/transform/testcmd.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testcmd.prg", true);
	}

	private static void testOpen() throws Exception {
		System.out.println("\n\ntestOpen");
		String[] vary = Loader.loadProgram("src/test/resources/transform/testopen.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testopen.prg", true);
	}

	private static void testScroll() throws Exception {
		System.out.println("\n\ntestScroll");
		String[] vary = Loader.loadProgram("src/test/resources/transform/scroll.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testscroll.prg", true);
	}

	private static void testOpenPrint() throws Exception {
		System.out.println("\n\ntestOpenPrint");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test31.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testopenprint.prg", true);
	}

	private static void testBreakout() throws Exception {
		System.out.println("\n\ntestBreakout");
		String[] vary = Loader.loadProgram("src/test/resources/transform/breakout.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testbreakout.prg", true);
	}

	private static void testBbDemo() throws Exception {
		System.out.println("\n\ntestBbDemo");
		String[] vary = Loader.loadProgram("src/test/resources/transform/bbdemo.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testbbdemo.prg", true);
	}

	private static void testBenchmark() throws Exception {
		System.out.println("\n\ntestBenchmark");
		String[] vary = Loader.loadProgram("src/test/resources/transform/benchmark2.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testbenchmark.prg", true);
	}

	private static void testConditions() throws Exception {
		System.out.println("\n\ntestConditions");
		String[] vary = Loader.loadProgram("src/test/resources/transform/conditions.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testconditions.prg", true);
	}

	private static void testLines() throws Exception {
		System.out.println("\n\ntestLines");
		String[] vary = Loader.loadProgram("src/test/resources/transform/lines.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testlines.prg", true);
	}

	private static void testIfTest() throws Exception {
		System.out.println("\n\ntestIfTest");
		String[] vary = Loader.loadProgram("src/test/resources/transform/iftest.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++iftest.prg", true);
	}
	
	private static void testIfNotTest() throws Exception {
		System.out.println("\n\ntestIfNotTest");
		String[] vary = Loader.loadProgram("src/test/resources/basic/ifnot.bas");
		Assembler assy = initTestEnvironment(vary, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++ifnot.prg", true);
	}

	private static void testHilbert() throws Exception {
		System.out.println("\n\ntestHilbert");
		String[] vary = Loader.loadProgram("src/test/resources/transform/hilbert.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testhilbert.prg", true);
	}

	private static void testTransformer27() throws Exception {
		System.out.println("\n\ntestTransformer27");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test27.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testlogic.prg", true);
		JsrProfiler profiler = new JsrProfiler(assy);
		assy.getCpu().setCpuTracer(profiler);
		Machine machine = executeTest(assy);

		printStats(profiler, machine);
	}

	private static void testTransformer26() throws Exception {
		System.out.println("\n\ntestTransformer26");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test26.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testshift.prg", true);
		JsrProfiler profiler = new JsrProfiler(assy);
		assy.getCpu().setCpuTracer(profiler);
		Machine machine = executeTest(assy);

		printStats(profiler, machine);
	}

	private static void testTransformerAffine() throws Exception {
		System.out.println("\n\ntestTransformerAffine");
		String[] vary = Preprocessor.convertToLineNumbers(Loader.loadProgram("src/test/resources/transform/affine_transform.bas"));

		for (String line : vary) {
			System.out.println(line);
		}
		final Assembler assy = initTestEnvironment(vary, false, 26000);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++affine.prg", true);
		Machine machine = executeTest(assy);
		System.out.println("Ticks: " + machine.getCpu().getClockTicks());
	}

	private static void testTransformerFrog() throws Exception {
		System.out.println("\n\ntestTransformerFrog");
		String[] vary = Preprocessor.convertToLineNumbers(Loader.loadProgram("src/test/resources/transform/frog_transform.bas"));

		for (String line : vary) {
			System.out.println(line);
		}
		final Assembler assy = initTestEnvironment(vary);
		// assy.getCpu().setCpuTracer(new MySimpleTracer(assy));
		FileWriter.writeAsPrg(assy.getProgram(), path + "++frog.prg", true);
		Machine machine = executeTest(assy);
		// printZeropage(assy);
		System.out.println("Ticks: " + machine.getCpu().getClockTicks());
	}

	private static void testTransformer30() throws Exception {
		System.out.println("\n\ntestTransformer30");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test30.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++test30.prg", true);
		JsrProfiler profiler = new JsrProfiler(assy);
		assy.getCpu().setCpuTracer(profiler);

		Machine machine = executeTest(assy);

		printStats(profiler, machine);
	}

	private static void testTransformer29() throws Exception {
		System.out.println("\n\ntestTransformer29");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test29.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++test29.prg", true);
		JsrProfiler profiler = new JsrProfiler(assy);
		assy.getCpu().setCpuTracer(profiler);

		Machine machine = executeTest(assy);

		printStats(profiler, machine);
	}

	private static void testTransformer28() throws Exception {
		System.out.println("\n\ntestTransformer28");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test28.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testgc2.prg", true);
		JsrProfiler profiler = new JsrProfiler(assy);
		assy.getCpu().setCpuTracer(profiler);

		assy.getCpu().setCpuTracer(new MySimpleTracer(assy));

		Machine machine = executeTest(assy);

		// printStats(profiler, machine);
	}

	private static void testTransformer25() throws Exception {
		System.out.println("\n\ntestTransformer25");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test25.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testgc.prg", true);
		JsrProfiler profiler = new JsrProfiler(assy);
		assy.getCpu().setCpuTracer(profiler);

		// assy.getCpu().setCpuTracer(new MySimpleTracer(assy));

		// Machine machine = executeTest(assy);

		// System.out.println("Ticks: " + assy.getCpu().getClockTicks());
		// printStats(profiler, machine);
	}

	private static void testTransformer24() throws Exception {
		System.out.println("\n\ntestTransformer24");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test24.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testconsts.prg", true);
	}

	private static void printZeropage(final Assembler assy) {
		System.out.println("Zeropage:");
		for (int i = 0; i < 256; i++) {
			System.out.println(i + ": " + assy.getMachine().getRam()[i]);
		}
	}

	private static void testTransformer23() throws Exception {
		System.out.println("\n\ntestTransformer23");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test23.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testdata.prg", true);
	}

	private static void testTransformer22() throws Exception {
		System.out.println("\n\ntestTransformer22");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test22.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testinput.prg", true);
	}

	private static void testTransformer20() throws Exception {
		System.out.println("\n\ntestTransformer20");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test20.bas");

		final Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testor.prg", true);
		JsrProfiler profiler = new JsrProfiler(assy);
		assy.getCpu().setCpuTracer(profiler);
		Machine machine = executeTest(assy);

		printStats(profiler, machine);
	}

	private static void testTransformer18() throws Exception {
		System.out.println("\n\ntestTransformer18");

		String[] vary = Loader.loadProgram("src/test/resources/transform/test18.bas");
		Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testget.prg", true);
		/*
		 * String[] vary =
		 * Loader.loadProgram("src/test/resources/transform/test19.bas");
		 * Assembler assy = initTestEnvironment(vary, false);
		 * FileWriter.writeAsPrg(assy.getProgram(), path+"++testgetnum.prg",
		 * true);
		 */
		/*
		 * vary = Loader.loadProgram("src/test/resources/transform/game.bas");
		 * assy = initTestEnvironment(vary, false);
		 * FileWriter.writeAsPrg(assy.getProgram(), path+"++testgame.prg",
		 * true); /* JsrProfiler profiler = new JsrProfiler(assy);
		 * assy.getCpu().setCpuTracer(profiler); Machine machine =
		 * executeTest(assy);
		 * 
		 * printStats(profiler, machine);
		 */
		// System.out.println(machine.getRam()[2]);
	}

	private static void testTransformer17() throws Exception {
		System.out.println("\n\ntestTransformer17");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test17.bas");

		final Assembler assy = initTestEnvironment(vary, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testusr.prg", true);
		JsrProfiler profiler = new JsrProfiler(assy);
		assy.getCpu().setCpuTracer(profiler);
		Machine machine = executeTest(assy);

		printStats(profiler, machine);
	}

	private static void testTransformer16() throws Exception {
		System.out.println("\n\ntestTransformer16");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test16.bas");

		final Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testmath.prg", true);
		JsrProfiler profiler = new JsrProfiler(assy);
		// assy.getCpu().setCpuTracer(new MyTracer(assy));
		assy.getCpu().setCpuTracer(profiler);
		Machine machine = executeTest(assy);

		printStats(profiler, machine);
	}

	private static void testTransformer15() throws Exception {
		System.out.println("\n\ntestTransformer15");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test15.bas");

		final Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++teststrconc.prg", true);
		JsrProfiler profiler = new JsrProfiler(assy);
		// assy.getCpu().setCpuTracer(new MyTracer(assy));
		assy.getCpu().setCpuTracer(profiler);
		Machine machine = executeTest(assy);

		printStats(profiler, machine);
	}

	private static void testTransformerBeer() throws Exception {
		System.out.println("\n\ntestTransformerBeer");
		String[] vary = Loader.loadProgram("src/test/resources/transform/beer_transform.bas");

		final Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testbeer.prg", true);
		JsrProfiler profiler = new JsrProfiler(assy);
		// assy.getCpu().setCpuTracer(new MyTracer(assy));
		assy.getCpu().setCpuTracer(profiler);
		Machine machine = executeTest(assy);

		printStats(profiler, machine);
	}

	private static void testTransformer11() throws Exception {
		System.out.println("\n\ntestTransformer11");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test11.bas");

		final Assembler assy = initTestEnvironment(vary);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++teststrcmp.prg", true);
		JsrProfiler profiler = new JsrProfiler(assy);
		assy.getCpu().setCpuTracer(profiler /* new MyTracer(assy) */);
		Machine machine = executeTest(assy);

		printStats(profiler, machine);
	}

	private static void testTransformer14() throws Exception {
		System.out.println("\n\ntestTransformer14");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test14.bas");

		final Assembler assy = initTestEnvironment(vary, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testdivs.prg", true);
		JsrProfiler profiler = new JsrProfiler(assy);
		// assy.getCpu().setCpuTracer(new MyTracer(assy));
		assy.getCpu().setCpuTracer(profiler /* new MyTracer(assy) */);
		Machine machine = executeTest(assy);

		printStats(profiler, machine);
	}

	private static void printStats(JsrProfiler profiler, Machine machine) {
		System.out.println("Ticks: " + machine.getCpu().getClockTicks());

		if (profiler != null) {
			List<ProfilerData> profs = profiler.getCollectedData();
			for (ProfilerData prof : profs) {
				System.out.println(prof);
			}
		}
	}

	private static void testTransformer13() throws Exception {
		System.out.println("\n\ntestTransformer13");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test13.bas");

		final Assembler assy = initTestEnvironment(vary, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testforpoke.prg", true);
		JsrProfiler profiler = new JsrProfiler(assy);
		// assy.getCpu().setCpuTracer(new MyTracer(assy));
		assy.getCpu().setCpuTracer(profiler /* new MyTracer(assy) */);
		Machine machine = executeTest(assy);

		printStats(profiler, machine);
	}

	private static void testTransformer12() throws Exception {
		System.out.println("\n\ntestTransformer12");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test12.bas");

		final Assembler assy = initTestEnvironment(vary);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testoutput.prg", true);
		JsrProfiler profiler = new JsrProfiler(assy);
		assy.getCpu().setCpuTracer(profiler /* new MyTracer(assy) */);
		Machine machine = executeTest(assy);

		printStats(profiler, machine);
	}

	private static void testTransformer9() throws Exception {
		System.out.println("\n\ntestTransformer9");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test9.bas");

		final Assembler assy = initTestEnvironment(vary);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testarrays.prg", true);
		JsrProfiler profiler = new JsrProfiler(assy);
		assy.getCpu().setCpuTracer(profiler);
		Machine machine = executeTest(assy);

		int[] ram = machine.getRam();
		System.out.println();
		System.out.print("[");
		for (int i = 0xfff; i < (0xfff) + 22; i++) {
			System.out.print(Integer.toHexString(ram[i]) + " ");
		}
		System.out.println("]");

		printStats(profiler, machine);
	}

	private static void testTransformer10() throws Exception {
		System.out.println("\n\ntestTransformer10");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test10.bas");

		final Assembler assy = initTestEnvironment(vary);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testacc.prg", true);
		assy.getCpu().setCpuTracer(new MyTracer(assy));
		Machine machine = executeTest(assy);

		int[] ram = machine.getRam();
		System.out.println();

		System.out.println("Ticks: " + machine.getCpu().getClockTicks());

		System.out.println();
		System.out.print("[");
		for (int i = 0xf00; i < (0xf00) + 5; i++) {
			System.out.print(Integer.toHexString(ram[i]) + " ");
		}
		System.out.println("]");

		System.out.println("----------------------------------------");
		Basic basy = new Basic(vary);
		basy.run(config);
		System.out.println("----------------------------------------");
	}

	private static void testTransformer8() throws Exception {
		System.out.println("\n\ntestTransformer8");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test8.bas");

		final Assembler assy = initTestEnvironment(vary);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++teststrings.prg", true);
		// assy.getCpu().setCpuTracer(new MyTracer(assy));
		Machine machine = executeTest(assy);

		System.out.println("Ticks: " + machine.getCpu().getClockTicks());
	}

	private static void testTransformerPrime() throws Exception {
		System.out.println("\n\ntestTransformerPrime");
		String[] vary = Loader.loadProgram("src/test/resources/transform/prime_transform.bas");

		final Assembler assy = initTestEnvironment(vary);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++prime.prg", true);

		// assy.getCpu().setCpuTracer(new MyTracer(assy));

		Machine machine = executeTest(assy);

		System.out.println(machine.getRam()[1024]);
		System.out.println(machine.getRam()[1025]);
		System.out.println(machine.getRam()[1026]);

		System.out.println("Ticks: " + machine.getCpu().getClockTicks());
	}

	private static void testTransformerSqr() throws Exception {
		System.out.println("\n\ntestTransformerPrime");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test_sqr.bas");

		final Assembler assy = initTestEnvironment(vary);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testsqr.prg", true);

		// assy.getCpu().setCpuTracer(new MyTracer(assy));

		Machine machine = executeTest(assy);

		System.out.println("Ticks: " + machine.getCpu().getClockTicks());
	}

	private static void testTransformer7() throws Exception {
		System.out.println("\n\ntestTransformer7");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test7.bas");

		final Assembler assy = initTestEnvironment(vary);

		assy.getCpu().setCpuTracer(new MyTracer(assy));

		Machine machine = executeTest(assy);

		System.out.println(machine.getRam()[1024]);
		System.out.println(machine.getRam()[1025]);
		System.out.println(machine.getRam()[1026]);

		System.out.println("Ticks: " + machine.getCpu().getClockTicks());
	}

	private static void testTransformer6() throws Exception {
		System.out.println("\n\ntestTransformer6");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test6.bas");

		final Assembler assy = initTestEnvironment(vary);

		// assy.getCpu().setCpuTracer(new MyTracer(assy));

		Machine machine = executeTest(assy);

		System.out.println(machine.getRam()[1024]);
		System.out.println(machine.getRam()[1025]);
		System.out.println(machine.getRam()[1026]);
		System.out.println(machine.getRam()[2]);

		System.out.println("Ticks: " + machine.getCpu().getClockTicks());
	}

	private static void testTransformerFractal() throws Exception {
		System.out.println("\n\ntestTransformerFractal");
		String[] vary = Loader.loadProgram("src/test/resources/transform/fractal_transform.bas");

		final Assembler assy = initTestEnvironment(vary);

		// assy.getCpu().setCpuTracer(new MySimpleTracer(assy));

		assy.run(config);
		Program prg = assy.getProgram();
		for (ProgramPart pp : prg.getParts()) {
			System.out.println("Size: " + pp.size());
		}

		FileWriter.writeAsPrg(prg, path + "++fractal.prg", true);

		System.out.println("Running compiled program...");
		Machine machine = assy.getMachine();
		machine.addRoms();

		final boolean[] loop = new boolean[1];
		loop[0] = true;

		Thread monitor = new Thread() {
			@Override
			public void run() {
				while (loop[0]) {
					System.out.println(assy.getRam()[2]);
					try {
						Thread.sleep(1000);
					} catch (InterruptedException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		};

		System.out.println(assy.toString());
		try {
			monitor.start();
			assy.run(config);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("...done!");
		loop[0] = false;

		BufferedImage bi = Graphics.createImage(assy.getMachine(), 16384, 24576, true, true);
		FileOutputStream fos = new FileOutputStream("fractal_multicolor_native.png");
		Graphics.savePng(bi, fos);

		System.out.println("Ticks: " + machine.getCpu().getClockTicks());
	}

	private static void testTransformer5() throws Exception {
		System.out.println("\n\ntestTransformer5");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test5.bas");

		final Assembler assy = initTestEnvironment(vary);

		// assy.getCpu().setCpuTracer(new MyTracer(assy));

		Machine machine = executeTest(assy);

		System.out.println(machine.getRam()[1024]);
		System.out.println(machine.getRam()[1025]);
		System.out.println(machine.getRam()[1026]);
		System.out.println(machine.getRam()[2]);

		System.out.println("Ticks: " + machine.getCpu().getClockTicks());
	}

	private static void testTransformer4() throws Exception {
		System.out.println("\n\ntestTransformer4");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test4.bas");

		final Assembler assy = initTestEnvironment(vary);

		// assy.getCpu().setCpuTracer(new MyTracer(assy));

		Machine machine = executeTest(assy);

		for (int i = 49000; i < 50050; i++) {
			System.out.println(Integer.toHexString(i) + ": " + Integer.toHexString(assy.getRam()[i]));
		}

		System.out.println("Ticks: " + machine.getCpu().getClockTicks());
	}

	private static void testTransformer1() throws Exception {
		System.out.println("\n\ntestTransformer1");
		String[] vary = Loader.loadProgram("src/test/resources/basic/affine.bas");

		vary = Preprocessor.convertToLineNumbers(vary);
		Basic basic = new Basic(vary);
		List<String> nCode = NativeCompiler.getCompiler().compile(basic, new Platform64());
		for (String line : nCode) {
			System.out.println(line);
		}

		Assembler assy = new Assembler(nCode);
		assy.compile(config);
		assy.run(config);
		Program prg = assy.getProgram();
		for (ProgramPart pp : prg.getParts()) {
			System.out.println("Size: " + pp.size());
		}
	}

	private static void testTransformer2() throws Exception {
		System.out.println("\n\ntestTransformer2");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test1.bas");

		final Assembler assy = initTestEnvironment(vary);
		assy.run(config);
		Program prg = assy.getProgram();
		for (ProgramPart pp : prg.getParts()) {
			System.out.println("Size: " + pp.size());
		}

		System.out.println("Running compiled program...");
		Machine machine = assy.getMachine();
		machine.addRoms();
		/*
		 * assy.getCpu().setCpuTracer(new CpuTracer() {
		 * 
		 * @Override public void commandExecuted(Cpu cpu, int opcode, int
		 * opcodePc, int newPc) { System.out.println(opcodePc + " - " + opcode +
		 * " -> " + newPc + " / a=" + cpu.getAcc() + " / x=" + cpu.getX() +
		 * " / y=" + cpu.getY() + "/ z=" + (cpu.getStatus()&0b10) + " / 105=" +
		 * assy.getMachine().getRam()[105] + " / 106=" +
		 * assy.getMachine().getRam()[106]); } });
		 */
		System.out.println(assy.toString());

		assy.run(config);
		System.out.println("...done!");
		System.out.println("A=" + Conversions.convertCompactFloat(machine, 0xa81));
		System.out.println("D=" + Conversions.convertCompactFloat(machine, 0xa8a));
		System.out.println("VR=" + Conversions.convertCompactFloat(machine, 0xa91));
		System.out.println("B%=" + (machine.getRam()[0xa86] + 256 * machine.getRam()[0xa87]));
		System.out.println("C%=" + (machine.getRam()[0xa88] + 256 * machine.getRam()[0xa89]));
		System.out.println("VIDMEM: " + machine.getRam()[1024]);
		System.out.println("VIDMEM2: " + machine.getRam()[1030]);
		System.out.println("VIDMEM4: " + machine.getRam()[1040]);
		System.out.println("Ticks: " + machine.getCpu().getClockTicks());
	}

	private static void testTransformer3() throws Exception {
		System.out.println("\n\ntestTransformer3");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test3.bas");

		Basic basic = new Basic(vary);
		List<String> nCode = NativeCompiler.getCompiler().compile(basic, new Platform64());
		for (String line : nCode) {
			System.out.println(line);
		}

		Assembler assy = new Assembler(nCode);
		assy.compile(config);
		assy.run(config);
		Program prg = assy.getProgram();
		for (ProgramPart pp : prg.getParts()) {
			System.out.println("Size: " + pp.size());
		}

		System.out.println("Running compiled program...");
		Machine machine = assy.getMachine();
		machine.addRoms();
		System.out.println(assy.toString());

		assy.run(config);
		System.out.println("...done!");
		System.out.println("A=" + Conversions.convertCompactFloat(machine, 0x824));
		System.out.println(Arrays.toString(Arrays.copyOfRange(machine.getRam(), 0x824, 0x824 + 5)));
		System.out.println("Ticks: " + machine.getCpu().getClockTicks());
	}

	@SuppressWarnings("unused")
	private static class MyTracer implements CpuTracer {
		int cnt = 0;
		private final Assembler assy;

		private MyTracer(Assembler assy) {
			this.assy = assy;
		}

		@Override
		public void commandExecuted(Cpu cpu, int opcode, int opcodePc, int newPc) {
			String line = assy.getCodeLine(opcodePc);
			float fac = 0;// Conversions.convertFloat(assy.getMachine(), 97);
			float fac2 = 0;// Conversions.convertFloat(assy.getMachine(), 105);
			if (line != null) {
				int addr = 0x1abf;
				int strBufPtr = assy.getRam()[addr] + 256 * assy.getRam()[addr + 1];
				int strBufPtr2 = assy.getRam()[addr + 2] + 256 * assy.getRam()[addr + 3];
				if (assy.getMachine().getRam()[115] != 230) {
					System.out.println(assy.getMachine().getRam()[115]);
					String memChunk = assy.getRam()[addr - 3] + ":" + (assy.getRam()[addr - 2] + 256 * assy.getRam()[addr - 1]);
					System.out.println(opcodePc + " - " + opcode + " -> " + newPc + " / a=" + cpu.getAcc() + " / x=" + cpu.getX() + " / y=" + cpu.getY() + "/ z="
							+ (cpu.getStatus() & 0b10) + " / 105=" + assy.getMachine().getRam()[105] + " / 106=" + assy.getMachine().getRam()[106] + "/" + line + " "
							+ assy.getRam()[opcodePc + 1] + " / FAC=" + fac + " / FAC2=" + fac2 + " / " + strBufPtr + " / " + strBufPtr2 + " # " + memChunk);
					if (cnt++ > 100) {
						System.exit(0);
					}
				}

			} else {
				/*
				 * System.out.println(opcodePc + " - " + opcode + " -> " + newPc
				 * + " / a=" + cpu.getAcc() + " / x=" + cpu.getX() + " / y=" +
				 * cpu.getY() + "/ z=" + (cpu.getStatus() & 0b10) + " / 105=" +
				 * assy.getMachine().getRam()[105] + " / 106=" +
				 * assy.getMachine().getRam()[106] + "/" +
				 * cpu.getInstruction(opcode) + " " + assy.getRam()[opcodePc +
				 * 1] + " / FAC=" + fac);
				 */
			}
		}

		@Override
		public void exception(Cpu cpu, int opcode, int opcodePc, int newPc) {
			// TODO Auto-generated method stub

		}
	}

	private static Assembler initTestEnvironment(String[] vary) {
		return initTestEnvironment(vary, false);
	}

	private static Assembler initTestEnvironment(String[] vary, boolean executePseudo) {
		return initTestEnvironment(vary, executePseudo, -1);
	}

	private static Assembler initTestEnvironment(String[] vary, boolean executePseudo, int variableStart) {
		CompilerConfig conf = new CompilerConfig();
		boolean opt = true;
		conf.setConstantFolding(opt);
		conf.setConstantPropagation(opt);
		conf.setDeadStoreElimination(opt);
		conf.setDeadStoreEliminationOfStrings(opt);
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

		if (executePseudo) {
			System.out.println("Running pseudo code...");
			PseudoCpu pc = new PseudoCpu();
			pc.execute(conf, basic.getMachine(), mCode);
		}
		System.out.println("------------------------------");

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

	private static Machine executeTest(final Assembler assy) {
		Program prg = assy.getProgram();
		for (ProgramPart pp : prg.getParts()) {
			System.out.println("Size: " + pp.size());
		}

		System.out.println("Running compiled program...");
		Machine machine = assy.getMachine();
		machine.addRoms();
		// printZeropage(assy);

		System.out.println(assy.toString());
		try {
			assy.run(config);
		} catch (Exception e) {
			e.printStackTrace();
			printMemory(assy, machine);
		}
		System.out.println("program end: " + prg.getParts().get(prg.getParts().size() - 1).getEndAddress());
		System.out.println("...done!");
		return machine;
	}

	private static void printMemory(Assembler assy, Machine machine) {
		Program prg = assy.getProgram();
		String code = assy.toString();
		String[] lines = code.split("\n");
		System.out.println("Lines: " + lines.length);
		Map<String, String> addr2line = new HashMap<String, String>();
		for (String line : lines) {
			if (line.startsWith(".")) {
				int pos = line.indexOf("\t");
				addr2line.put(line.substring(0, pos), line);
			}
		}
		StringBuilder sb = new StringBuilder();

		for (ProgramPart pp : prg.getParts()) {
			for (int i = pp.getAddress(); i < pp.getEndAddress(); i++) {
				String addr = Integer.toString(i, 16);
				addr = "." + addr;
				if (addr2line.containsKey(addr)) {
					if (sb.length() > 0) {
						sb.append("\n");
					}
					sb.append("> ").append(addr2line.get(addr)).append("\n");
					sb.append("  " + addr).append("\t");
				}
				int val = AssemblyParser.getLowByte(machine.getRam()[i]);
				String num = Integer.toString(val, 16);
				if (num.length() == 1) {
					num = "0" + num;
				}
				sb.append(num).append(" ");
			}
		}
		System.out.println(sb.toString());

		System.out.println("--------------------------------------------------------------");

		lines = sb.toString().split("\n");
		for (int i = 0; i < lines.length; i += 2) {
			String l1 = lines[i];
			String l2 = lines[i + 1];
			if (l1.length() > 0 && l2.length() > 0 && l1.substring(1).equals(l2.substring(1))) {
				continue;
			}
			System.out.println(l1);
			System.out.println(l2);
		}
	}

	@SuppressWarnings("unused")
	private static class MySimpleTracer implements CpuTracer {
		private final Assembler assy;

		private MySimpleTracer(Assembler assy) {
			this.assy = assy;
		}

		private int cnt;

		@Override
		public void commandExecuted(Cpu cpu, int opcode, int opcodePc, int newPc) {

			String line = assy.getCodeLine(opcodePc);
			if (line != null) {
				cnt++;

				System.out.println(Integer.toHexString(opcodePc) + " - " + Integer.toHexString(opcode) + " -> " + Integer.toHexString(newPc) + " / a=" + cpu.getAcc() + " / x="
						+ cpu.getX() + " / y=" + cpu.getY() + "/ z=" + (cpu.getStatus() & 0b10) + "/ c=" + (cpu.getStatus() & 0b00000001) + " / TMP_ZP=" + printReg(105, assy)
						+ " / TMP2_ZP=" + printReg(107, assy) + " / TMP3_ZP=" + printReg(34, assy) + "/" + line + " " + assy.getRam()[opcodePc + 1] + "/" + cnt + " - "
						+ print16Bit(1024, assy) + "/" + print16Bit(1027, assy) + "/" + print16Bit(1030, assy) + "/" + print16Bit(1033, assy) + "/" + print16Bit(1036, assy)
						+ " @ " + cpu.getClockTicks());

			}

		}

		private String printReg(int i, Assembler assy) {
			int addr = (assy.getRam()[i] + 256 * assy.getRam()[i + 1]);
			return addr + " [" + (assy.getRam()[addr] + 256 * assy.getRam()[addr + 1]) + "] ";
		}

		private String print16Bit(int i, Assembler assy) {
			return (assy.getRam()[i] + 256 * assy.getRam()[i + 1]) + "";
		}

		@Override
		public void exception(Cpu cpu, int opcode, int opcodePc, int newPc) {
			System.out.println("Exception in " + cnt);
		}
	}
}
