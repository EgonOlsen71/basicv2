package com.sixtyfour.elements.mnemonics;

public class Nop extends AbstractMnemonic {
	public Nop() {
		super("NOP", new int[] { 0xEA, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
