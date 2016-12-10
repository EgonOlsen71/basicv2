package com.sixtyfour.system;

public interface CpuTracer {

	void commandExecuted(Cpu cpu, int opcode, int opcodePc, int newPc);

}
