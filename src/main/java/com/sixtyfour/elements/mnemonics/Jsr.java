package com.sixtyfour.elements.mnemonics;

/**
 * The Class Jsr.
 */
public class Jsr extends AbstractMnemonic {
	
	/**
   * Instantiates a new jsr.
   */
	public Jsr() {
		super("JSR", new int[] { 0, 0, 0x20, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	/* (non-Javadoc)
	 * @see com.sixtyfour.elements.mnemonics.AbstractMnemonic#isJump()
	 */
	@Override
	public boolean isJump() {
		return true;
	}
}
