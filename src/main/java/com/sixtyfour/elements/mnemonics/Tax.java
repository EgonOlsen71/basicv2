package com.sixtyfour.elements.mnemonics;

public class Tax extends AbstractMnemonic {
	public Tax() {
		super("TAX", new int[] { 0xAA, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
