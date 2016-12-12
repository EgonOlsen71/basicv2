package com.sixtyfour.elements.mnemonics;

/**
 * The Class Bpl.
 */
public class Bpl extends AbstractMnemonic {
	
	/**
   * Instantiates a new bpl.
   */
	public Bpl() {
		super("BPL", new int[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x10 });
	}

	/* (non-Javadoc)
	 * @see com.sixtyfour.elements.mnemonics.AbstractMnemonic#isRelative()
	 */
	@Override
	public boolean isRelative() {
		return true;
	}
	
	/* (non-Javadoc)
	 * @see com.sixtyfour.elements.mnemonics.AbstractMnemonic#isJump()
	 */
	@Override
	public boolean isJump() {
		return true;
	}

}
