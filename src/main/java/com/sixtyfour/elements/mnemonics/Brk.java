package com.sixtyfour.elements.mnemonics;

/**
 * The Class Brk.
 */
public class Brk extends AbstractMnemonic {
	
	/**
   * Instantiates a new brk.
   */
	public Brk() {
		super("BRK", new int[] { -9999, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	/* (non-Javadoc)
	 * @see com.sixtyfour.elements.mnemonics.AbstractMnemonic#isSingle()
	 */
	@Override
	public boolean isSingle() {
		return true;
	}

}
