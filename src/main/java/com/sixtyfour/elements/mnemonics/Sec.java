package com.sixtyfour.elements.mnemonics;

/**
 * The Class Sec.
 */
public class Sec extends AbstractMnemonic {
	
	/**
   * Instantiates a new sec.
   */
	public Sec() {
		super("SEC", new int[] { 0x38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	/* (non-Javadoc)
	 * @see com.sixtyfour.elements.mnemonics.AbstractMnemonic#isSingle()
	 */
	@Override
	public boolean isSingle() {
		return true;
	}

}
