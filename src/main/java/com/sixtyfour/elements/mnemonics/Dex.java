package com.sixtyfour.elements.mnemonics;

public class Dex extends AbstractMnemonic {
	public Dex() {
		super("DEX", new int[] { 0xCA, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
