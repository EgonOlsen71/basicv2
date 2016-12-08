package com.sixtyfour.elements.mnemonics;

public class Cld extends AbstractMnemonic {
	public Cld() {
		super("CLD", new int[] { 0xD8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
