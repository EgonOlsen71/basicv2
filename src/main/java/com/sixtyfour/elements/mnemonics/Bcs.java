package com.sixtyfour.elements.mnemonics;

public class Bcs extends AbstractMnemonic {
	public Bcs() {
		super("BCS", new int[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0xB0 });
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
