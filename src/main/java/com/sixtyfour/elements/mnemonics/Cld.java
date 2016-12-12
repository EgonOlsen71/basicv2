package com.sixtyfour.elements.mnemonics;

/**
 * The Class Cld.
 */
public class Cld extends AbstractMnemonic {
	
	/**
   * Instantiates a new cld.
   */
	public Cld() {
		super("CLD", new int[] { 0xD8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	/* (non-Javadoc)
	 * @see com.sixtyfour.elements.mnemonics.AbstractMnemonic#isSingle()
	 */
	@Override
	public boolean isSingle() {
		return true;
	}

}
