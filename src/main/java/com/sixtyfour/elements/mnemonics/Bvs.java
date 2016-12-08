package com.sixtyfour.elements.mnemonics;

public class Bvs extends AbstractMnemonic {
	public Bvs() {
		super("BVS", new int[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x70 });
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
