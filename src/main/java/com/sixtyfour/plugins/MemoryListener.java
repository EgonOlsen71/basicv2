package com.sixtyfour.plugins;

/**
 * A listener for memory releated command calls like POKE and WAIT.
 */
public interface MemoryListener {

	/**
	 * POKE has been called.
	 * 
	 * @param address
	 *            the address to poke into
	 * @param value
	 *            the value to be poked
	 */
	void poke(int addr, int value);

	/**
	 * WAIT has been called.
	 * 
	 * @param address
	 *            the address to wait for
	 * @param value
	 *            the value with which the memory's content will be ANDed
	 * @param inverse
	 *             the value with which the memory's content will be EORed
	 * @return true, if the conditions are met. False otherwise.
	 */
	boolean wait(int addr, int value, int inverse);
}
