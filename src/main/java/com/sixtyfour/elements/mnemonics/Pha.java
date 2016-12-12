package com.sixtyfour.elements.mnemonics;

/**
 * The Class Pha.
 */
public class Pha extends AbstractMnemonic {
	
	/**
   * Instantiates a new pha.
   */
	public Pha() {
		super("PHA", new int[] { 0x48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	/* (non-Javadoc)
	 * @see com.sixtyfour.elements.mnemonics.AbstractMnemonic#isSingle()
	 */
	@Override
	public boolean isSingle() {
		return true;
	}

}
