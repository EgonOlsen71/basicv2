package com.sixtyfour.elements.mnemonics;

public class Beq extends AbstractMnemonic {
	public Beq() {
		super("BEQ", new int[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0xF0 });
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
