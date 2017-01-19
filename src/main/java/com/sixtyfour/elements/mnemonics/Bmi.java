package com.sixtyfour.elements.mnemonics;

/**
 * The Class Bmi.
 */
public class Bmi extends AbstractMnemonic {

	/**
	 * Instantiates a new bmi.
	 */
	public Bmi() {
		super("BMI", new int[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x30 });
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.mnemonics.AbstractMnemonic#isRelative()
	 */
	@Override
	public boolean isRelative() {
		return true;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.mnemonics.AbstractMnemonic#isJump()
	 */
	@Override
	public boolean isJump() {
		return true;
	}

}
