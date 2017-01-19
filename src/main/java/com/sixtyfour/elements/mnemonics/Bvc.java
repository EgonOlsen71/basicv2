package com.sixtyfour.elements.mnemonics;

/**
 * The Class Bvc.
 */
public class Bvc extends AbstractMnemonic {

	/**
	 * Instantiates a new bvc.
	 */
	public Bvc() {
		super("BVC", new int[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x50 });
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
