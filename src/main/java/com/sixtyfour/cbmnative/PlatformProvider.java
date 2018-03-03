package com.sixtyfour.cbmnative;

/**
 * @author EgonOlsen
 * 
 */
public interface PlatformProvider {

	/**
	 * @return
	 */
	int getStartAddress();

	/**
	 * @return
	 */
	int getStackSize();

	/**
	 * @return
	 */
	int getForStackSize();

	/**
	 * @return
	 */
	Optimizer getOptimizer();

	/**
	 * @return
	 */
	Transformer getTransformer();

	/**
	 * @return
	 */
	boolean useLooseTypes();

	/**
	 * @return
	 */
	int getStringMemoryEnd();

	/**
	 * @return
	 */
	int getMemoryStackSize();

}
