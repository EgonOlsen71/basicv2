package com.sixtyfour.elements.mnemonics;

public class Bcc extends AbstractMnemonic {
	public Bcc() {
		super("BCC", new int[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x90 });
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
