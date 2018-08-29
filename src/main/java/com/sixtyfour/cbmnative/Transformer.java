package com.sixtyfour.cbmnative;

import java.util.List;

import com.sixtyfour.system.Machine;

/**
 * @author EgonOlsen
 * 
 */
public interface Transformer {
	/**
	 * @param machine
	 * @return
	 */
	List<String> transform(Machine machine, PlatformProvider romProvider, List<String> code);

	List<String> createCaller(String calleeName);
	
	void setVariableStart(int variableStart);

	int getStringMemoryEnd();

	void setStringMemoryEnd(int stringMemoryEnd);

	int getVariableStart();

	int getStartAddress();

	void setStartAddress(int addr);

	int getRuntimeStart();

	void setRuntimeStart(int runtimeStart);

	boolean isOptimizedTempStorage();

	void setOptimizedTempStorage(boolean optimizedTemp);
}
