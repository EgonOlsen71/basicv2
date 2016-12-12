package com.sixtyfour.elements.mnemonics;

/**
 * The Class Plp.
 */
public class Plp extends AbstractMnemonic {
	
	/**
   * Instantiates a new plp.
   */
	public Plp() {
		super("PLP", new int[] { 0x28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	/* (non-Javadoc)
	 * @see com.sixtyfour.elements.mnemonics.AbstractMnemonic#isSingle()
	 */
	@Override
	public boolean isSingle() {
		return true;
	}

}
