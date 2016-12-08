package com.sixtyfour.elements.mnemonics;

public class Plp extends AbstractMnemonic {
	public Plp() {
		super("PLP", new int[] { 0x28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
