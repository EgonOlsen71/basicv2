package com.sixtyfour.test;

import java.awt.image.BufferedImage;
import java.io.FileOutputStream;
import java.util.Arrays;
import java.util.List;

import com.sixtyfour.Assembler;
import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.parser.Preprocessor;
import com.sixtyfour.system.Conversions;
import com.sixtyfour.system.Cpu;
import com.sixtyfour.system.CpuTracer;
import com.sixtyfour.system.FileWriter;
import com.sixtyfour.system.Graphics;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.Program;
import com.sixtyfour.system.ProgramPart;

/**
 * @author Foerster-H
 * 
 */
public class TransformerTest {

	public static void main(String[] args) throws Exception {
		// testTransformer3();
		// testTransformer1();
		// testTransformer2();
		// testTransformer4();
		// testTransformer5();
		// testTransformerFractal();
		// testTransformer6();
		// testTransformer7();
		//testTransformerPrime();
		// testTransformerSqr();
		//testTransformer8();
		//testTransformer9();
	    testTransformer10();
	}

	private static void testTransformer9() throws Exception {
		System.out.println("\n\ntestTransformer9");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test9.bas");

		final Assembler assy = initTestEnvironment(vary);
		FileWriter.writeAsPrg(assy.getProgram(), "++testarrays.prg", true);
		//assy.getCpu().setCpuTracer(new MyTracer(assy));
		Machine machine = executeTest(assy);
		
		int[] ram=machine.getRam();
		System.out.println();
		System.out.print("[");
		for (int i=0xfff; i<(0xfff)+22; i++) {
		    System.out.print(Integer.toHexString(ram[i])+" ");
		}
		System.out.println("]");

		System.out.println("Ticks: " + machine.getCpu().getClockTicks());
	}
	
	private static void testTransformer10() throws Exception {
		System.out.println("\n\ntestTransformer10");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test10.bas");

		final Assembler assy = initTestEnvironment(vary);
		FileWriter.writeAsPrg(assy.getProgram(), "++testacc.prg", true);
		assy.getCpu().setCpuTracer(new MyTracer(assy));
		Machine machine = executeTest(assy);
		
		int[] ram=machine.getRam();
		System.out.println();

		System.out.println("Ticks: " + machine.getCpu().getClockTicks());
		
		System.out.println();
		System.out.print("[");
		for (int i=0xf00; i<(0xf00)+5; i++) {
		    System.out.print(Integer.toHexString(ram[i])+" ");
		}
		System.out.println("]");
		
		System.out.println("----------------------------------------");
		Basic basy=new Basic(vary);
		basy.run();
		System.out.println("----------------------------------------");
	}
	
	private static void testTransformer8() throws Exception {
		System.out.println("\n\ntestTransformer8");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test8.bas");

		final Assembler assy = initTestEnvironment(vary);
		FileWriter.writeAsPrg(assy.getProgram(), "++teststrings.prg", true);
		//assy.getCpu().setCpuTracer(new MyTracer(assy));
		Machine machine = executeTest(assy);

		System.out.println("Ticks: " + machine.getCpu().getClockTicks());
	}

	private static void testTransformerPrime() throws Exception {
		System.out.println("\n\ntestTransformerPrime");
		String[] vary = Loader.loadProgram("src/test/resources/transform/prime_transform.bas");

		final Assembler assy = initTestEnvironment(vary);
		FileWriter.writeAsPrg(assy.getProgram(), "++prime.prg", true);

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
		FileWriter.writeAsPrg(assy.getProgram(), "++testsqr.prg", true);

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

		assy.run();
		Program prg = assy.getProgram();
		for (ProgramPart pp : prg.getParts()) {
			System.out.println("Size: " + pp.size());
		}

		FileWriter.writeAsPrg(prg, "++fractal.prg", true);

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
			assy.run();
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
		List<String> nCode = NativeCompiler.getCompiler().compile(basic);
		for (String line : nCode) {
			System.out.println(line);
		}

		Assembler assy = new Assembler(nCode);
		assy.compile();
		assy.run();
		Program prg = assy.getProgram();
		for (ProgramPart pp : prg.getParts()) {
			System.out.println("Size: " + pp.size());
		}
	}

	private static void testTransformer2() throws Exception {
		System.out.println("\n\ntestTransformer2");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test1.bas");

		final Assembler assy = initTestEnvironment(vary);
		assy.run();
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

		assy.run();
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
		List<String> nCode = NativeCompiler.getCompiler().compile(basic);
		for (String line : nCode) {
			System.out.println(line);
		}

		Assembler assy = new Assembler(nCode);
		assy.compile();
		assy.run();
		Program prg = assy.getProgram();
		for (ProgramPart pp : prg.getParts()) {
			System.out.println("Size: " + pp.size());
		}

		System.out.println("Running compiled program...");
		Machine machine = assy.getMachine();
		machine.addRoms();
		System.out.println(assy.toString());

		assy.run();
		System.out.println("...done!");
		System.out.println("A=" + Conversions.convertCompactFloat(machine, 0x824));
		System.out.println(Arrays.toString(Arrays.copyOfRange(machine.getRam(), 0x824, 0x824 + 5)));
		System.out.println("Ticks: " + machine.getCpu().getClockTicks());
	}

	@SuppressWarnings("unused")
	private static class MyTracer implements CpuTracer {
		private final Assembler assy;

		private MyTracer(Assembler assy) {
			this.assy = assy;
		}

		@Override
		public void commandExecuted(Cpu cpu, int opcode, int opcodePc, int newPc) {
			String line = assy.getCodeLine(opcodePc);
			float fac = Conversions.convertFloat(assy.getMachine(), 97);
			float fac2 = Conversions.convertFloat(assy.getMachine(), 105);
			if (line != null) {

				System.out.println(opcodePc + " - " + opcode + " -> " + newPc + " / a=" + cpu.getAcc() + " / x=" + cpu.getX() + " / y=" + cpu.getY() + "/ z="
						+ (cpu.getStatus() & 0b10) + " / 105=" + assy.getMachine().getRam()[105] + " / 106=" + assy.getMachine().getRam()[106] + "/" + line + " "
						+ assy.getRam()[opcodePc + 1] + " / FAC=" + fac + " / FAC2=" + fac2 + "/" + assy.getMachine().getRam()[2]);
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
		final Basic basic = new Basic(vary);
		basic.compile();

		List<String> mCode = NativeCompiler.getCompiler().compileToPseudeCode(basic.getMachine(), basic.getPCode());
		System.out.println("------------------------------");
		for (String line : mCode) {
			System.out.println(line);
		}
		System.out.println("------------------------------");

		List<String> nCode = NativeCompiler.getCompiler().compile(basic);
		for (String line : nCode) {
			System.out.println(line);
		}

		final Assembler assy = new Assembler(nCode);
		assy.compile();

		return assy;
	}

	private static Machine executeTest(final Assembler assy) {
		assy.run();
		Program prg = assy.getProgram();
		for (ProgramPart pp : prg.getParts()) {
			System.out.println("Size: " + pp.size());
		}

		System.out.println("Running compiled program...");
		Machine machine = assy.getMachine();
		machine.addRoms();

		System.out.println(assy.toString());
		try {
			assy.run();
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("...done!");
		return machine;
	}

	@SuppressWarnings("unused")
	private static class MySimpleTracer implements CpuTracer {
		private final Assembler assy;
		private int lastVal = 255;

		private MySimpleTracer(Assembler assy) {
			this.assy = assy;
		}

		private int cnt;

		@Override
		public void commandExecuted(Cpu cpu, int opcode, int opcodePc, int newPc) {
			String line = assy.getCodeLine(opcodePc);
			if (line != null) {
				cnt++;
				if (assy.getMachine().getRam()[2] != lastVal || cnt > 400) {
					lastVal = assy.getMachine().getRam()[2];
					System.out.println(Integer.toHexString(opcodePc) + " - " + Integer.toHexString(opcode) + " -> " + Integer.toHexString(newPc) + " / a=" + cpu.getAcc() + " / x="
							+ cpu.getX() + " / y=" + cpu.getY() + "/ z=" + (cpu.getStatus() & 0b10) + " / 105=" + assy.getMachine().getRam()[105] + " / 106="
							+ assy.getMachine().getRam()[106] + "/" + line + " " + assy.getRam()[opcodePc + 1] + "/" + assy.getMachine().getRam()[2] + "/" + cnt);
				}
			}
		}

		@Override
		public void exception(Cpu cpu, int opcode, int opcodePc, int newPc) {
			System.out.println("Exception in " + cnt);
		}
	}
}
