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
	int getGarbageCollectionBufferSize();

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
	Unlinker getUnlinker();

	/**
	 * @return
	 */
	boolean useLooseTypes();

	/**
	 * @return
	 */
	int getStringMemoryEnd();
}
