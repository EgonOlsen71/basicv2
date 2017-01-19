package com.sixtyfour.elements.mnemonics;

/**
 * The Class Sld.
 */
public class Sld extends AbstractMnemonic {

	/**
	 * Instantiates a new sld.
	 */
	public Sld() {
		super("SLD", new int[] { 0xF8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
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
