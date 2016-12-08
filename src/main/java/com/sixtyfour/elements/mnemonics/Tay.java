package com.sixtyfour.elements.mnemonics;

public class Tay extends AbstractMnemonic {
	public Tay() {
		super("TAY", new int[] { 0xA8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
