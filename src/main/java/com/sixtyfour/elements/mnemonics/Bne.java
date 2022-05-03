package com.sixtyfour.elements.mnemonics;

/**
 * The Class Bne.
 */
public class Bne extends AbstractMnemonic {

	/**
	 * Instantiates a new bne.
	 */
	public Bne() {
		super("BNE", new int[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0xD0 });
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
