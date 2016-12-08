package com.sixtyfour.elements.mnemonics;

public class Inx extends AbstractMnemonic {
	public Inx() {
		super("INX", new int[] { 0xE8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
