package com.sixtyfour.elements.mnemonics;

/**
 * The Class Bvs.
 */
public class Bvs extends AbstractMnemonic {
	
	/**
   * Instantiates a new bvs.
   */
	public Bvs() {
		super("BVS", new int[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x70 });
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
