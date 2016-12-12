package com.sixtyfour.elements.mnemonics;

/**
 * The Class Tya.
 */
public class Tya extends AbstractMnemonic {
	
	/**
   * Instantiates a new tya.
   */
	public Tya() {
		super("TYA", new int[] { 0x98, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	/* (non-Javadoc)
	 * @see com.sixtyfour.elements.mnemonics.AbstractMnemonic#isSingle()
	 */
	@Override
	public boolean isSingle() {
		return true;
	}

}
