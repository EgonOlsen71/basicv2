package com.sixtyfour.test;

import com.sixtyfour.Assembler;
import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.extensions.textmode.ConsoleSupport;
import com.sixtyfour.plugins.impl.RamSystemCallListener;
import com.sixtyfour.system.Conversions;
import com.sixtyfour.system.Machine;

/**
 * @author EgonOlsen
 * 
 */
public class RomTest {
	public static void main(String[] args) {
		testRomAccess();
		testRomCalc();
		testRomAndBasicCalc();
		testRomCalc2();
	}

	private static void testRomAccess() {
		System.out.println("testRomAccess");
		String[] vary = Loader.loadProgram("src/test/resources/rom/romtest.bas");
		Basic inty = new Basic(vary);
		inty.getMachine().addRoms();
		inty.setSystemCallListener(new RamSystemCallListener(inty.getMachine()));
		inty.run();
	}

	private static void testRomCalc() {
		System.out.println("testRomCalc");
		String[] code = Loader.loadProgram("src/test/resources/rom/math.asm");
		Assembler asm = new Assembler(code);
		asm.compile();
		final Machine machine = asm.getMachine();
		machine.addRoms();
		asm.run();
		System.out.println(Conversions.convertCompactFloat(machine, 0x2000));
		System.out.println(Conversions.convertCompactFloat(machine, 0x2010) + " ~ " + Math.sqrt(Conversions.convertCompactFloat(machine, 0x2000)));
	}

	private static void testRomCalc2() {
		System.out.println("testRomCalc2");
		String[] code = Loader.loadProgram("src/test/resources/rom/math2.asm");
		Assembler asm = new Assembler(code);
		asm.compile();
		final Machine machine = asm.getMachine();
		machine.addRoms();
		asm.run();
		System.out.println(Conversions.convertCompactFloat(machine, 0x2000));
		System.out.println(Conversions.convertCompactFloat(machine, 0x2010) + " ~ " + Math.sqrt(Conversions.convertCompactFloat(machine, 0x2000)));
	}

	private static void testRomAndBasicCalc() {
		System.out.println("testRomAndBasicCalc");
		String[] code = Loader.loadProgram("src/test/resources/rom/math.asm");
		Assembler asm = new Assembler(code);
		asm.compile();

		String[] basic = Loader.loadProgram("src/test/resources/rom/math.bas");
		Basic.registerExtension(ConsoleSupport.class);
		Basic inty = new Basic(basic);
		inty.compile();
		inty.setSystemCallListener(new RamSystemCallListener(inty.getMachine()));

		Machine machine = inty.getMachine();
		machine.addRoms();
		machine.putProgram(asm.getProgram());
		inty.run();

		System.out.println(Conversions.convertFloat(machine, 0x2010));
	}
}
