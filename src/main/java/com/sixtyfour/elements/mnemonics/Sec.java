package com.sixtyfour.elements.mnemonics;

public class Sec extends AbstractMnemonic {
	public Sec() {
		super("SEC", new int[] { 0x38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
