/*
 * 
 */
package com.sixtyfour.plugins;

/**
 * The listener interface for receiving systemCall events. The class that is
 * interested in processing a systemCall event implements this interface, and
 * the object created with that class is registered with a component using the
 * component's <code>addSystemCallListener<code> method. When
 * the systemCall event occurs, that object's appropriate
 * method is invoked.
 * 
 * @see SystemCallEvent
 */
public interface SystemCallListener {

	/**
	 * Sys.
	 * 
	 * @param addr
	 *            the addr
	 * @param params
	 *            the params
	 */
	void sys(int addr, Object... params);
}
