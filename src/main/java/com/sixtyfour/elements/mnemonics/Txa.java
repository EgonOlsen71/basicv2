package com.sixtyfour.elements.mnemonics;


/**
 * The Class Txa.
 */
public class Txa extends AbstractMnemonic {
	
	/**
   * Instantiates a new txa.
   */
	public Txa() {
		super("TXA", new int[] { 0x8A, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	/* (non-Javadoc)
	 * @see com.sixtyfour.elements.mnemonics.AbstractMnemonic#isSingle()
	 */
	@Override
	public boolean isSingle() {
		return true;
	}

}
