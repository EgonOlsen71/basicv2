package com.sixtyfour.elements.mnemonics;

public class Sld extends AbstractMnemonic {
	public Sld() {
		super("SLD", new int[] { 0xF8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
