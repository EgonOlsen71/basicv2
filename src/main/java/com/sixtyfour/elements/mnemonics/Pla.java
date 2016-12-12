package com.sixtyfour.elements.mnemonics;

/**
 * The Class Pla.
 */
public class Pla extends AbstractMnemonic {
	
	/**
   * Instantiates a new pla.
   */
	public Pla() {
		super("PLA", new int[] { 0x68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	/* (non-Javadoc)
	 * @see com.sixtyfour.elements.mnemonics.AbstractMnemonic#isSingle()
	 */
	@Override
	public boolean isSingle() {
		return true;
	}

}
