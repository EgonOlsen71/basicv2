package com.sixtyfour.cbmnative;

import com.sixtyfour.config.CompilerConfig;

/**
 * Interface for implementing a target platform.
 * 
 * @author EgonOlsen
 * 
 */
public interface PlatformProvider {

	/**
	 * Returns the stack size that should be used on the target platform.
	 * 
	 * @return the size
	 */
	int getStackSize();

	/**
	 * Returns the stack size of the for-next stack that should be used on the
	 * target platform.
	 * 
	 * @return the size
	 */
	int getForStackSize();

	/**
	 * Returns the optimizer that should be used on the target platform.
	 * 
	 * @return the optimizer or null, if none should be used
	 */
	Optimizer getOptimizer();

	/**
	 * Returns the transformer that should be used for the target platform.
	 * 
	 * @return the transformer
	 */
	Transformer getTransformer();

	/**
	 * Returns the unlinker that should be used on the target platform.
	 * 
	 * @return the unlinker or null, if none should be used
	 */
	Unlinker getUnlinker();

	/**
	 * Returns true, if loose types are allowed. False if not.
	 * 
	 * @return Are they allowed?
	 */
	boolean useLooseTypes();

	/**
	 * Address, up to which it's feasible to add a BASIC header to the compiled code
	 * 
	 * @return the address
	 */
	int getMaxHeaderAddress();

	/**
	 * Default base address at which the BASIC ram usually starts on a platform.
	 * 
	 * @return the address
	 */
	int getBaseAddress();

	/**
	 * Returns the end address of BASIC memory for this platform.
	 * 
	 * @return the address
	 */
	int getBasicMemoryEndAddress();

	/**
	 * Can be implemented to override some config settings for a specific platform
	 * 
	 * @param conf the config
	 */
	void overrideConfig(CompilerConfig conf);

	/**
	 * Can be implemented to override a specific generator
	 * 
	 * @param orgLine
	 * @return
	 */
	Generator getGenerator(String orgLine);

	/**
	 * Returns the address used for the buffer when executing SYS commands with
	 * parameters
	 * 
	 * @return
	 */
	int getBasicBufferAddress();

	/**
	 * If true, the option to compress the compiled code is available on this
	 * platform
	 * 
	 * @return
	 */
	boolean supportsCompression();

	/**
	 * If true, this platform supports the BigRam option.
	 * 
	 * @return
	 */
	boolean supportsBigRam();

}
