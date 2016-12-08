package com.sixtyfour.elements.mnemonics;

public class Bvc extends AbstractMnemonic {
	public Bvc() {
		super("BVC", new int[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x50 });
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
