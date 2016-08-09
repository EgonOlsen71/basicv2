/*
 * 
 */
package com.sixtyfour.plugins.impl;

import java.util.Scanner;

import com.sixtyfour.plugins.InputProvider;

/**
 * The Class ConsoleInputProvider.
 */
public class ConsoleInputProvider implements InputProvider {

	/** The scanner. */
	private Scanner scanner = new Scanner(System.in);

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.InputProvider#readKey()
	 */
	@Override
	public Character readKey() {
		if (scanner.hasNext()) {
			String val = scanner.next();
			if (val.length() > 0) {
				return val.charAt(0);
			}
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.plugins.InputProvider#readString()
	 */
	@Override
	public String readString() {
		String val = null;
		if (scanner.hasNext()) {
			val = scanner.next();
		} else {
			val = scanner.nextLine();
		}
		if (val != null && val.length() == 0) {
			val = null;
		}
		return val;
	}

}
