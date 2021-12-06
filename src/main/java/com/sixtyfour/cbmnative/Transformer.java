package com.sixtyfour.cbmnative;

import java.util.List;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.config.MemoryConfig;
import com.sixtyfour.system.Machine;

/**
 * An interface for implementations that take the intermediate code and
 * transform that into code for the given target platform.
 * 
 * @author EgonOlsen
 * 
 */
public interface Transformer {

	/**
	 * Transforms intermediate code into native/assembly code.
	 * 
	 * @param config   the compiler's configuration
	 * @param memConfig the memory configuration
	 * @param machine  the machine
	 * @param platform the target platform
	 * @param code     the intermediate code
	 * @return the native code
	 */
	List<String> transform(CompilerConfig config, MemoryConfig memConfig, Machine machine, PlatformProvider platform, List<String> code);

	/**
	 * Can be implemented to add some additional code that handles the actual
	 * calling of the compiled code. This is used for the Javascript target to wrap
	 * the result into something that can run in a browser.
	 * 
	 * @param calleeName what to call
	 * @return the caller code
	 */
	List<String> createCaller(String calleeName);

	/**
	 * Sets the memory address on which the variables start (if applicable). Default
	 * is -1.
	 * 
	 * @param variableStart the variable start
	 */
	void setVariableStart(int variableStart);

	/**
	 * Returns the variable start address (if applicable). Default is -1.
	 * 
	 * @return the variable start
	 */
	int getVariableStart();

	/**
	 * Returns the memory address on which the string memory ends (if applicable).
	 * 
	 * @return the end address
	 */
	int getStringMemoryEnd();

	/**
	 * Sets the memory address on which the string memory ends (if applicable).
	 * 
	 * @param stringMemoryEnd the end address
	 */
	void setStringMemoryEnd(int stringMemoryEnd);

	/**
	 * Sets the memory address on which the code starts (if applicable).
	 * 
	 * @return the start address
	 */
	int getStartAddress();

	/**
	 * Sets the memory address on which the code starts (if applicable).
	 * 
	 * @param addr the start address
	 */
	void setStartAddress(int addr);

	/**
	 * Returns the memory address on which the runtime code starts (if applicable).
	 * 
	 * @return the runtime start address
	 */
	int getRuntimeStart();

	/**
	 * Sets the memory address on which the runtime code starts (if applicable).
	 * 
	 * @param runtimeStart the runtime start address
	 */
	void setRuntimeStart(int runtimeStart);

	/**
	 * Returns if storing temporary variables on the target platform should be
	 * optimized or not (if applicable).
	 * 
	 * @return should it?
	 */
	boolean isOptimizedTempStorage();

	/**
	 * Sets if storing temporary variables on the target platform should be
	 * optimized or not.
	 * 
	 * @param optimizedTemp should it?
	 */
	void setOptimizedTempStorage(boolean optimizedTemp);

	boolean isOptimizedStringPointers();

	void setOptimizedStringPointers(boolean optimized);
}
