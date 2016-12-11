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
public class MixedTest {

	public static void main(String[] args) {
		testMixed();
	}

	private static void testMixed() {
		String[] basicCode = Loader.loadProgram("src/test/resources/mixed/basicasm.bas");
		String[] asmCode = Loader.loadProgram("src/test/resources/asm/example3.asm");
		Basic basic = new Basic(basicCode);
		Machine machine=basic.getMachine();
		
		Assembler asm = new Assembler(asmCode, machine);
		asm.compile();

		basic.setSystemCallListener(new RamSystemCallListener(machine));
		basic.compile();
		machine.getCpu().setExitOnBreak(false);
		machine.putProgram(asm.getProgram());
		basic.run();
	}

}
