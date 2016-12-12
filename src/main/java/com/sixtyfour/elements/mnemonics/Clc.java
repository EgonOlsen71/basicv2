package com.sixtyfour.elements.mnemonics;

/**
 * The Class Clc.
 */
public class Clc extends AbstractMnemonic {
	
	/**
   * Instantiates a new clc.
   */
	public Clc() {
		super("CLC", new int[] { 0x18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	/* (non-Javadoc)
	 * @see com.sixtyfour.elements.mnemonics.AbstractMnemonic#isSingle()
	 */
	@Override
	public boolean isSingle() {
		return true;
	}

}
