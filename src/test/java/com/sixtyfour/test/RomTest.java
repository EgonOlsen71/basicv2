package com.sixtyfour.test;

import com.sixtyfour.Assembler;
import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.plugins.impl.RamSystemCallListener;
import com.sixtyfour.system.Machine;

/**
 * @author EgonOlsen
 * 
 */
public class RomTest {
	public static void main(String[] args) {
		testRomAccess();
		testRomCalc();
	}

	private static void testRomAccess() {
		String[] vary = Loader.loadProgram("src/test/resources/rom/romtest.bas");
		Basic inty = new Basic(vary);
		inty.getMachine().addRoms();
		inty.setSystemCallListener(new RamSystemCallListener(inty.getMachine()));
		inty.run();
	}

	private static void testRomCalc() {
		String[] code = Loader.loadProgram("src/test/resources/rom/math.asm");
		Assembler asm = new Assembler(code);
		asm.compile();
		Machine machine = asm.getMachine();
		machine.addRoms();
		asm.run();
		System.out.println(machine.getCpu().convertFloat(8192));
		System.out.println(machine.getCpu().convertFloat(0x61) + " ~ " + Math.sqrt(machine.getCpu().convertFloat(8192)));
	}
}
