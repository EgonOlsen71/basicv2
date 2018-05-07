package com.sixtyfour.test;

import java.io.File;
import java.io.FileInputStream;
import java.io.FilenameFilter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sixtyfour.Assembler;
import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.PseudoCpu;
import com.sixtyfour.parser.assembly.AssemblyParser;
import com.sixtyfour.system.CompilerConfig;
import com.sixtyfour.system.Conversions;
import com.sixtyfour.system.Cpu;
import com.sixtyfour.system.CpuTracer;
import com.sixtyfour.system.FileWriter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.Program;
import com.sixtyfour.system.ProgramPart;
import com.sixtyfour.test.helper.JsrProfiler;

/**
 * @author EgonOlsen
 * 
 */
public class GamesCompiler {

	public static void main(String[] args) throws Exception {
		File src = new File("src/test/resources/games");
		File dst = new File("compiled");
		dst.mkdir();
		File[] games = src.listFiles(new FilenameFilter() {
			@Override
			public boolean accept(File dir, String name) {
				return name.endsWith("StarPilot.bas");
			}
		});

		for (File game : games) {
			System.out.println("Compiling " + game);
			String[] vary = Loader.loadProgram(new FileInputStream(game));
			Assembler assy = initTestEnvironment(vary, false, 49152, 53248);
			String target = dst.getPath() + "/+" + game.getName().replace(".bas", ".prg");
			System.out.println("Code ends at: "+assy.getProgram().getParts().get(0).getEndAddress());
			FileWriter.writeAsPrg(assy.getProgram(), target, true);
			
			assy.getCpu().setCpuTracer(new MySimpleTracer(assy));
			//executeTest(assy);
		}
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
			assy.run();
		} catch (Exception e) {
			e.printStackTrace();
			printMemory(assy, machine);
		}
		System.out.println("program end: " + prg.getParts().get(prg.getParts().size() - 1).getEndAddress());
		System.out.println("...done!");
		
		//printMemory(assy, machine);
		
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

	private static Assembler initTestEnvironment(String[] vary, boolean executePseudo, int variableStart, int stringMemoryEnd) {
		CompilerConfig conf = CompilerConfig.getConfig();
		boolean optis=true;
		conf.setConstantFolding(optis);
		conf.setConstantPropagation(optis);
		conf.setDeadStoreElimination(optis);
		conf.setDeadStoreEliminationOfStrings(optis);
		conf.setIntermediateLanguageOptimizations(optis);
		conf.setNativeLanguageOptimizations(optis);
		conf.setOptimizedLinker(optis);
		conf.setCompactThreshold(4);

		final Basic basic = new Basic(vary);
		basic.compile();

		List<String> mCode = NativeCompiler.getCompiler().compileToPseudeCode(basic);
		System.out.println("------------------------------");
		for (String line : mCode) {
			System.out.println(line);
		}
		System.out.println("------------------------------");

		if (executePseudo) {
			System.out.println("Running pseudo code...");
			PseudoCpu pc = new PseudoCpu();
			pc.execute(basic.getMachine(), mCode);
		}
		System.out.println("------------------------------");

		List<String> nCode = NativeCompiler.getCompiler().compile(basic, variableStart, stringMemoryEnd);
		for (String line : nCode) {
			System.out.println(line);
		}

		final Assembler assy = new Assembler(nCode);
		assy.compile();

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

				System.out.println(Integer.toHexString(opcodePc) + " - " + Integer.toHexString(opcode) + " -> "
						+ Integer.toHexString(newPc) + " / a=" + cpu.getAcc() + " / x=" + cpu.getX() + " / y="
						+ cpu.getY() + "/ z=" + (cpu.getStatus() & 0b10) + " / TMP_ZP=" + printReg(105, assy)
						+ " / TMP2_ZP=" + printReg(107, assy) + " / TMP3_ZP=" + printReg(34, assy) + "/" + line + " "
						+ assy.getRam()[opcodePc + 1] + "/" + cnt + " - FAC1:" + Conversions.convertFloat(assy.getMachine(), 0x61) + " @ " + cpu.getClockTicks());

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
