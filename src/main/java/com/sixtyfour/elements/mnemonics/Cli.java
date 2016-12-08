package com.sixtyfour.elements.mnemonics;

public class Cli extends AbstractMnemonic {
	public Cli() {
		super("CLI", new int[] { 0x58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
