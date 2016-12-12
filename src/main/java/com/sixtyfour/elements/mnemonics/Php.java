package com.sixtyfour.elements.mnemonics;

/**
 * The Class Php.
 */
public class Php extends AbstractMnemonic {
	
	/**
   * Instantiates a new php.
   */
	public Php() {
		super("PHP", new int[] { 0x08, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	/* (non-Javadoc)
	 * @see com.sixtyfour.elements.mnemonics.AbstractMnemonic#isSingle()
	 */
	@Override
	public boolean isSingle() {
		return true;
	}

}
