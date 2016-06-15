package sixtyfour.plugins.impl;

import sixtyfour.plugins.MemoryListener;

public class NullMemoryListener implements MemoryListener {

	@Override
	public void poke(int addr, int value) {
		// No nothing
	}

	@Override
	public boolean wait(int addr, int value, int inverse) {
		// Don't wait for anything
		return false;
	}

}
