package com.sixtyfour.test;

import com.sixtyfour.Assembler;
import com.sixtyfour.Loader;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.plugins.CpuCallListener;
import com.sixtyfour.system.Cpu;
import com.sixtyfour.system.CpuTracer;
import com.sixtyfour.system.Machine;

public class AssemblerBeer {
    
    private static CompilerConfig config=new CompilerConfig();
	public static void main(String[] args) {
		testBeer();
	}

	private static void testBeer() {
		String[] code = Loader.loadProgram("src/test/resources/asm/beer.asm");
		Assembler asm = new Assembler(code);
		asm.compile(config);
		Machine machine = asm.getMachine();

		System.out.println(asm.toString());

		machine.getCpu().setCpuTracer(new CpuTracer() {

			@Override
			public void commandExecuted(Cpu cpu, int opcode, int opcodePc, int newPc) {
				try {
					// Thread.sleep(1);
				} catch (Exception e) {

				}
			}

			@Override
			public void exception(Cpu cpu, int opcode, int opcodePc, int newPc) {
				// TODO Auto-generated method stub

			}

		});

		machine.getCpu().setCpuCallListener(new CpuCallListener() {

			@Override
			public boolean jsr(Cpu cpu, int addr) {
				if (addr == 65490) {
					System.out.print((char) (cpu.getAcc()));
					return true;
				}
				return false;
			}
		});
		asm.run(config);
	}

}
