package com.sixtyfour.plugins;

import com.sixtyfour.system.Cpu;

/**
 * Similar to SystemCallListener, but for the Cpu implementation. This can be
 * used to intercept ROM calls by a machine language program. There is no
 * default implementation for this interface.
 * 
 * @author EgonOlsen
 * 
 */
public interface CpuCallListener {

	/**
	 * Called whenever the Cpu executes a JSR command.
	 * 
	 * @param cpu  the cpu that has executed the command
	 * @param addr the target address of the call
	 * @return if true, the actual JSR call won't be made by the CPU. If false, it
	 *         will be done anyway.
	 */
	boolean jsr(Cpu cpu, int addr);

}
