package com.sixtyfour.elements.mnemonics;

/**
 * The Class Phy.
 */
public class Phy extends AbstractMnemonic {

	/**
	 * Instantiates a new Phy.
	 */
	public Phy() {
		super("PHY", new int[] { 0x5A, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
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
