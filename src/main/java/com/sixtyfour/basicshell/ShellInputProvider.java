package com.sixtyfour.basicshell;

import com.sixtyfour.plugins.InputProvider;

/**
 * @author nietoperz809
 */
public class ShellInputProvider implements InputProvider {
	private BasicShell shellFrame;

	public ShellInputProvider(BasicShell shellFrame) {
		this.shellFrame = shellFrame;
	}

	@Override
	public Character readKey() {
		if (shellFrame.peek()) {
			String s = shellFrame.getString();
			if (s.length() > 0) {
				return s.charAt(0);
			}
		}
		return null;
	}

	@Override
	public String readString() {
		 int l = shellFrame.getPenultimateOutputSize();
	     return shellFrame.getString().substring(l+1);
	}
}
