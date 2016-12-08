package com.sixtyfour.elements.mnemonics;

public class Dey extends AbstractMnemonic {
	public Dey() {
		super("DEY", new int[] { 0x88, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
