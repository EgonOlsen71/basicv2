package com.sixtyfour.system;

/**
 * An interface for implementing tracing.
 * 
 * @author EgonOlsen
 */
public interface CpuTracer {

	/**
	 * This method will be called after each command (i.e. opcode).
	 * 
	 * @param cpu
	 *            the cpu that executed the opcode
	 * @param opcode
	 *            the actual opcode
	 * @param opcodePc
	 *            the position of the opcode in the cpu's memory
	 * @param newPc
	 *            the position of the program counter after the execution
	 */
	void commandExecuted(Cpu cpu, int opcode, int opcodePc, int newPc);

}
