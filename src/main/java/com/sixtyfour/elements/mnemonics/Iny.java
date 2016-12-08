package com.sixtyfour.elements.mnemonics;

public class Iny extends AbstractMnemonic {
	public Iny() {
		super("INY", new int[] { 0xC8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
