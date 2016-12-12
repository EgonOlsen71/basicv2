package com.sixtyfour.elements.mnemonics;

/**
 * The Class Inx.
 */
public class Inx extends AbstractMnemonic {
	
	/**
   * Instantiates a new inx.
   */
	public Inx() {
		super("INX", new int[] { 0xE8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	/* (non-Javadoc)
	 * @see com.sixtyfour.elements.mnemonics.AbstractMnemonic#isSingle()
	 */
	@Override
	public boolean isSingle() {
		return true;
	}

}
