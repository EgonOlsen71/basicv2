package com.sixtyfour.elements.mnemonics;

public class Bpl extends AbstractMnemonic {
	public Bpl() {
		super("BPL", new int[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x10 });
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
