/*
 * 
 */
package com.sixtyfour.plugins.impl;

import com.sixtyfour.plugins.MemoryListener;

/**
 * The listener interface for receiving nullMemory events. The class that is
 * interested in processing a nullMemory event implements this interface, and
 * the object created with that class is registered with a component using the
 * component's <code>addNullMemoryListener<code> method. When
 * the nullMemory event occurs, that object's appropriate
 * method is invoked.
 * 
 * @see NullMemoryEvent
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
