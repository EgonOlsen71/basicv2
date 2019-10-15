package com.sixtyfour.test;

import java.util.List;

import com.sixtyfour.Assembler;
import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.PseudoCpu;
import com.sixtyfour.cbmnative.mos6502.x16.PlatformX16;
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
		testData();
		testCharfractal();
		testFrog();
		testTi();
		testBalls();
		testCards();
		testDos();
		testMon();
		testDivide();
		testVload();
		testSave();
		testLoad();
		testGeos();
		testBitmapfill();
		testLine();
		testRaytracer();
		testLine640();
		testFractal256();
		testExpresso();
		testAffine();
		testVloadTest();
		testPeek();
		testRamPeek();
		//testBank();
	}

	@SuppressWarnings("unused")
	private static void testBank() throws Exception {
		System.out.println("\n\ntestBank");
		String[] vary = Loader.loadProgram("src/test/resources/x16/bank.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++bank.prg", true);
	}
	
	private static void testRamPeek() throws Exception {
		System.out.println("\n\ntestRamPeek");
		String[] vary = Loader.loadProgram("src/test/resources/x16/rampeek.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++rampeek.prg", true);
	}

	private static void testPeek() throws Exception {
		System.out.println("\n\ntestPeek");
		String[] vary = Loader.loadProgram("src/test/resources/x16/peek.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++peek_x16.prg", true);
	}

	private static void testVloadTest() throws Exception {
		System.out.println("\n\ntestVloadTest");
		String[] vary = Loader.loadProgram("src/test/resources/x16/vloadtest.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++vloadtest.prg", true);
	}

	private static void testAffine() throws Exception {
		System.out.println("\n\ntestAffine");
		String[] vary = Loader.loadProgram("src/test/resources/x16/affine.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++affine_x16.prg", true);
	}

	private static void testExpresso() throws Exception {
		System.out.println("\n\ntestExpresso");
		String[] vary = Loader.loadProgram("src/test/resources/x16/expresso.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++expresso_x16.prg", true);
	}

	private static void testFractal256() throws Exception {
		System.out.println("\n\ntestFractal256");
		String[] vary = Loader.loadProgram("src/test/resources/x16/fractal256.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++fractal256_x16.prg", true);
	}

	private static void testLine640() throws Exception {
		System.out.println("\n\ntestLine640");
		String[] vary = Loader.loadProgram("src/test/resources/x16/line640.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++line640_x16.prg", true);
	}

	private static void testRaytracer() throws Exception {
		System.out.println("\n\ntestRaytracer");
		String[] vary = Loader.loadProgram("src/test/resources/x16/raytracer.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++raytracer_x16.prg", true);
	}

	private static void testLine() throws Exception {
		System.out.println("\n\ntestLine");
		String[] vary = Loader.loadProgram("src/test/resources/x16/line.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++line_x16.prg", true);
	}

	private static void testBitmapfill() throws Exception {
		System.out.println("\n\ntestBitmapfill");
		String[] vary = Loader.loadProgram("src/test/resources/x16/bitmapfill.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++bitmapfill_x16.prg", true);
	}

	private static void testGeos() throws Exception {
		System.out.println("\n\ntestGeos");
		String[] vary = Loader.loadProgram("src/test/resources/x16/geos.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++geos_x16.prg", true);
	}

	private static void testLoad() throws Exception {
		System.out.println("\n\ntestLoad");
		String[] vary = Loader.loadProgram("src/test/resources/x16/load.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++load_x16.prg", true);
	}

	private static void testSave() throws Exception {
		System.out.println("\n\ntestSave");
		String[] vary = Loader.loadProgram("src/test/resources/x16/save.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++save_x16.prg", true);
	}

	private static void testVload() throws Exception {
		System.out.println("\n\ntestVload");
		String[] vary = Loader.loadProgram("src/test/resources/x16/vload.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++vload_x16.prg", true);
	}

	private static void testDivide() throws Exception {
		System.out.println("\n\ntestDivide");
		String[] vary = Loader.loadProgram("src/test/resources/x16/divide.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++divide_x16.prg", true);
	}

	private static void testMon() throws Exception {
		System.out.println("\n\ntestMon");
		String[] vary = Loader.loadProgram("src/test/resources/x16/mon.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++mon_x16.prg", true);
	}

	private static void testDos() throws Exception {
		System.out.println("\n\ntestDos");
		String[] vary = Loader.loadProgram("src/test/resources/x16/dos.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++dos_x16.prg", true);
	}

	private static void testCards() throws Exception {
		System.out.println("\n\ntestCards");
		String[] vary = Loader.loadProgram("src/test/resources/x16/cards.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++cards_x16.prg", true);
	}

	private static void testBalls() throws Exception {
		System.out.println("\n\ntestBalls");
		String[] vary = Loader.loadProgram("src/test/resources/x16/balls.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++balls_x16.prg", true);
	}

	private static void testTi() throws Exception {
		System.out.println("\n\ntestTi");
		String[] vary = Loader.loadProgram("src/test/resources/x16/ti.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++ti_x16.prg", true);
	}

	private static void testFrog() throws Exception {
		System.out.println("\n\ntestFrog");
		String[] vary = Loader.loadProgram("src/test/resources/x16/frog.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++frog_x16.prg", true);
	}

	private static void testCharfractal() throws Exception {
		System.out.println("\n\ntestCharfractal");
		String[] vary = Loader.loadProgram("src/test/resources/x16/charfractal.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++charfractal_x16.prg", true);
	}

	private static void testData() throws Exception {
		System.out.println("\n\ntestData");
		String[] vary = Loader.loadProgram("src/test/resources/x16/data.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++data_x16.prg", true);
	}

	private static void testColors() throws Exception {
		System.out.println("\n\ntestColors");
		String[] vary = Loader.loadProgram("src/test/resources/x16/colors.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++colors_x16.prg", true);
	}

	private static void testVpokePeek() throws Exception {
		System.out.println("\n\ntestVpokePeek");
		String[] vary = Loader.loadProgram("src/test/resources/x16/vpokepeek.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++vpokepeek_x16.prg", true);
	}

	private static void testVpoke() throws Exception {
		System.out.println("\n\ntestVpoke");
		String[] vary = Loader.loadProgram("src/test/resources/x16/vpoke.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++vpoke_x16.prg", true);
	}

	private static void testVpeek() throws Exception {
		System.out.println("\n\ntestVpeek");
		String[] vary = Loader.loadProgram("src/test/resources/x16/vpeek.bas");
		Assembler assy = initTestEnvironment(vary, false, -1, true);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++vpeek_x16.prg", true);
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
		conf.setConvertStringToLower(true);
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
		List<String> nCode = NativeCompiler.getCompiler().compile(conf, basic, memConfig, new PlatformX16());
		for (String line : nCode) {
			System.out.println(line);
		}

		final Assembler assy = new Assembler(nCode);
		assy.compile(conf);

		return assy;
	}
}
