package com.sixtyfour.elements.mnemonics;

public class Clv extends AbstractMnemonic {
	public Clv() {
		super("CLV", new int[] { 0xB8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
