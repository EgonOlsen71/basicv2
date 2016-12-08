package com.sixtyfour.elements.mnemonics;

public class Pha extends AbstractMnemonic {
	public Pha() {
		super("PHA", new int[] { 0x48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
