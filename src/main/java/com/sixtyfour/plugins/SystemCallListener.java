package com.sixtyfour.plugins;

/**
 * A listener for calls of the SYS command.
 */
public interface SystemCallListener {

	/**
	 * SYS has been called.
	 * 
	 * @param addr
	 *            the address for which SYS has been called
	 * @param params
	 *            optional parameters
	 */
	void sys(int addr, Object... params);
}
