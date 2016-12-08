package com.sixtyfour.elements.mnemonics;

public class Bne extends AbstractMnemonic {
	public Bne() {
		super("BNE", new int[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0xD0 });
	}

	@Override
	public boolean isRelative() {
		return true;
	}

	@Override
	public boolean isJump() {
		return true;
	}
	
}
