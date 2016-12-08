package com.sixtyfour.elements.mnemonics;

public class Pla extends AbstractMnemonic {
	public Pla() {
		super("PLA", new int[] { 0x68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
