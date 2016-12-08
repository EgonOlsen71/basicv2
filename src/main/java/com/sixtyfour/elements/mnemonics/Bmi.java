package com.sixtyfour.elements.mnemonics;

public class Bmi extends AbstractMnemonic {
	public Bmi() {
		super("BMI", new int[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x30 });
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
