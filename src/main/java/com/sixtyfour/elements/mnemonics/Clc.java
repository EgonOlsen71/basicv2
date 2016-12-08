package com.sixtyfour.elements.mnemonics;

public class Clc extends AbstractMnemonic {
	public Clc() {
		super("CLC", new int[] { 0x18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
