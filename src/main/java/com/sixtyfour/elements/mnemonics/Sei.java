package com.sixtyfour.elements.mnemonics;

public class Sei extends AbstractMnemonic {
	public Sei() {
		super("SEI", new int[] { 0x78, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
