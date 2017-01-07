package com.sixtyfour.plugins.impl;

import com.sixtyfour.plugins.MemoryListener;

/**
 * Default implementation that does nothing.
 */
public class NullMemoryListener implements MemoryListener {

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.MemoryListener#poke(int, int)
	 */
	@Override
	public void poke(int addr, int value) {
		// No nothing
	}

	/* (non-Javadoc)
	 * @see com.sixtyfour.plugins.MemoryListener#peek(int)
	 */
	@Override
	public Integer peek(int addr) {
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.MemoryListener#wait(int, int, int)
	 */
	@Override
	public boolean wait(int addr, int value, int inverse) {
		// Don't wait for anything
		return false;
	}

}
