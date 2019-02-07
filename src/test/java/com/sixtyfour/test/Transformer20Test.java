package com.sixtyfour.test;

import java.util.List;

import com.sixtyfour.Assembler;
import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.PseudoCpu;
import com.sixtyfour.cbmnative.mos6502.vic20.Platform20;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.config.LoopMode;
import com.sixtyfour.config.MemoryConfig;
import com.sixtyfour.system.Cpu;
import com.sixtyfour.system.CpuTracer;
import com.sixtyfour.system.FileWriter;

/*
 * @author EgonOlsen
 * 
 */
public class Transformer20Test {

	private static String path = "compiled/";

	public static void main(String[] args) throws Exception {
		 testTransformerPrime();
		 testTransformerBeer();
		 testTransformerCharFractal();
	}

	private static void testTransformerPrime() throws Exception {
		System.out.println("\n\ntestTransformerPrime");
		String[] vary = Loader.loadProgram("src/test/resources/transform/prime_transform.bas");

		final Assembler assy = initTestEnvironment(vary);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++prime20.prg", true, 4609);
	}

	private static void testTransformerBeer() throws Exception {
		System.out.println("\n\ntestTransformerBeer");
		String[] vary = Loader.loadProgram("src/test/resources/transform/beer_transform20.bas");

		final Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++testbeer20.prg", true, 4609);
	}
	
	private static void testTransformerCharFractal() throws Exception {
		System.out.println("\n\ntestTransformerCharFractal");
		String[] vary = Loader.loadProgram("src/test/resources/transform/charfractal20.bas");

		final Assembler assy = initTestEnvironment(vary, false);
		FileWriter.writeAsPrg(assy.getProgram(), path + "++charfractal20.prg", true, 4609);
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
		conf.setCompactThreshold(4);

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
		List<String> nCode = NativeCompiler.getCompiler().compile(conf, basic, memConfig, new Platform20());
		for (String line : nCode) {
			System.out.println(line);
		}

		final Assembler assy = new Assembler(nCode);
		assy.compile(conf);

		return assy;
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
