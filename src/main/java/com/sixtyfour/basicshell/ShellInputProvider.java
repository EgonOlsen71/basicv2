package com.sixtyfour.basicshell;

import com.sixtyfour.plugins.InputProvider;

/**
 * @author nietoperz809
 */
public class ShellInputProvider implements InputProvider {
	private BasicShell shellFrame;
	private Character currentKey;

	public ShellInputProvider(BasicShell shellFrame) {
		this.shellFrame = shellFrame;
	}

	@Override
	public Character readKey() {
		Character c = currentKey;
		currentKey = null;
		return c;
	}

	@Override
	public String readString() {
		int l = shellFrame.getPenultimateOutputSize();
		return shellFrame.getString().substring(l + 1);
	}

	public Character getCurrentKey() {
		return currentKey;
	}

	public void setCurrentKey(Character currentKey) {
		this.currentKey = currentKey;
	}
}
