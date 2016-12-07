package com.sixtyfour.plugins.impl;

import com.sixtyfour.plugins.SystemCallListener;

/**
 * Default implementation that does nothing.
 */
public class NullSystemCallListener implements SystemCallListener {

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.SystemCallListener#sys(int, java.lang.Object[])
	 */
	@Override
	public void sys(int addr, Object... params) {
		//
	}

}
