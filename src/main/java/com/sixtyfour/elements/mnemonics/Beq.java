package com.sixtyfour.elements.mnemonics;

/**
 * The Class Beq.
 */
public class Beq extends AbstractMnemonic {

	/**
	 * Instantiates a new beq.
	 */
	public Beq() {
		super("BEQ", new int[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0xF0 });
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
