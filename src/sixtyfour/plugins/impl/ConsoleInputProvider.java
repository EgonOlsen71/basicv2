package sixtyfour.plugins.impl;

import java.util.Scanner;

import sixtyfour.plugins.InputProvider;

public class ConsoleInputProvider implements InputProvider {

	private Scanner scanner = new Scanner(System.in);

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

	@Override
	public String readString() {
		return null;
	}

}
