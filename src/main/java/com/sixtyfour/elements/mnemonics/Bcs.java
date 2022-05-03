package com.sixtyfour.elements.mnemonics;

/**
 * The Class Bcs.
 */
public class Bcs extends AbstractMnemonic {

	/**
	 * Instantiates a new bcs.
	 */
	public Bcs() {
		super("BCS", new int[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0xB0 });
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

	@Override
	public int getMaxLength() {
		return 2;
	}

}
