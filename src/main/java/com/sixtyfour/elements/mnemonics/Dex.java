package com.sixtyfour.elements.mnemonics;

/**
 * The Class Dex.
 */
public class Dex extends AbstractMnemonic {
	
	/**
   * Instantiates a new dex.
   */
	public Dex() {
		super("DEX", new int[] { 0xCA, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	/* (non-Javadoc)
	 * @see com.sixtyfour.elements.mnemonics.AbstractMnemonic#isSingle()
	 */
	@Override
	public boolean isSingle() {
		return true;
	}

}
