package com.sixtyfour.elements.mnemonics;

public class Tya extends AbstractMnemonic {
	public Tya() {
		super("TYA", new int[] { 0x98, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
