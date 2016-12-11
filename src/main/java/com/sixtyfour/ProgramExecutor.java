package com.sixtyfour;

import com.sixtyfour.system.Cpu;
import com.sixtyfour.system.Machine;

/**
 * @author EgonOlsen
 */
public interface ProgramExecutor {

	void compile();
	
	void run();
	
	void start();
	
	Machine getMachine();
	
	Cpu getCpu();
	
	int[] getRam();
	
	void runStop();
}
