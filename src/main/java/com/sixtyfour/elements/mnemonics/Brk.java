package com.sixtyfour.elements.mnemonics;

public class Brk extends AbstractMnemonic {
	public Brk() {
		super("BRK", new int[] { -9999, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
