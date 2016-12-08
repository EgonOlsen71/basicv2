package com.sixtyfour.elements.mnemonics;

public class Jsr extends AbstractMnemonic {
	public Jsr() {
		super("JSR", new int[] { 0, 0, 0x20, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isJump() {
		return true;
	}
}
