package com.sixtyfour.elements.mnemonics;

/**
 * The Class Sed.
 */
public class Sed extends AbstractMnemonic {

	/**
	 * Instantiates a new sed.
	 */
	public Sed() {
		super("SED", new int[] { 0xF8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.mnemonics.AbstractMnemonic#isSingle()
	 */
	@Override
	public boolean isSingle() {
		return true;
	}

}
