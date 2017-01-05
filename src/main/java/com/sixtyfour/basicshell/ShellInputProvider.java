package com.sixtyfour.basicshell;

import com.sixtyfour.plugins.InputProvider;

/**
 * @Author nietoperz809
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
		String s = shellFrame.getString();
		s = s.substring(s.indexOf('?') + 1);
		return s;
	}
}
