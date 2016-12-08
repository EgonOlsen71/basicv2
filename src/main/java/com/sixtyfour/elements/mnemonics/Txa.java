package com.sixtyfour.elements.mnemonics;


public class Txa extends AbstractMnemonic {
	public Txa() {
		super("TXA", new int[] { 0x8A, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
