package com.sixtyfour.elements.mnemonics;

/**
 * The Class Dey.
 */
public class Dey extends AbstractMnemonic {
	
	/**
   * Instantiates a new dey.
   */
	public Dey() {
		super("DEY", new int[] { 0x88, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	/* (non-Javadoc)
	 * @see com.sixtyfour.elements.mnemonics.AbstractMnemonic#isSingle()
	 */
	@Override
	public boolean isSingle() {
		return true;
	}

}
