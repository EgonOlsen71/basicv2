package com.sixtyfour.test;

import java.util.Arrays;
import java.util.List;

import com.sixtyfour.Assembler;
import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.parser.Preprocessor;
import com.sixtyfour.system.Conversions;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.Program;
import com.sixtyfour.system.ProgramPart;

/**
 * @author Foerster-H
 * 
 */
public class TransformerTest {
	public static void main(String[] args) throws Exception {
		testTransformer3();
		testTransformer1();
		testTransformer2();
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

		Basic basic = new Basic(vary);
		
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
		assy.run();
		Program prg = assy.getProgram();
		for (ProgramPart pp : prg.getParts()) {
			System.out.println("Size: " + pp.size());
		}

		System.out.println("Running compiled program...");
		Machine machine = assy.getMachine();
		machine.addRoms();
		/*
		  assy.getCpu().setCpuTracer(new CpuTracer() {
		  
		  @Override public void commandExecuted(Cpu cpu, int opcode, int
		            opcodePc, int newPc) { System.out.println(opcodePc + " - "
		            + opcode + " -> " + newPc + " / a=" + cpu.getAcc()+ " / x="
		           + cpu.getX()+ " / y=" + cpu.getY() +" / 105="+assy.getMachine().getRam()[105]+" / 106="+assy.getMachine().getRam()[106]); } });
		*/
		System.out.println(assy.toString());

		assy.run();
		System.out.println("...done!");
		System.out.println("A=" + Conversions.convertCompactFloat(machine, 0x976));
		System.out.println("D=" + Conversions.convertCompactFloat(machine, 0x97f));
		System.out.println("VR=" + Conversions.convertCompactFloat(machine, 0x986));
		System.out.println("B%=" + (machine.getRam()[0x97b] + 256 * machine.getRam()[0x97c]));
		System.out.println("C%=" + (machine.getRam()[0x97d] + 256 * machine.getRam()[0x97e]));
		System.out.println("VIDMEM: " + machine.getRam()[1024]);
		System.out.println("VIDMEM2: " + machine.getRam()[1030]);
	}

	private static void testTransformer3() throws Exception {
		System.out.println("\n\ntestTransformer3");
		String[] vary = Loader.loadProgram("src/test/resources/transform/test2.bas");

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
	}
}
