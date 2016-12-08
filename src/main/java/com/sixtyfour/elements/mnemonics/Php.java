package com.sixtyfour.elements.mnemonics;

public class Php extends AbstractMnemonic {
	public Php() {
		super("PHP", new int[] { 0x08, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
