package com.sixtyfour.elements.mnemonics;

/**
 * The Class Plx.
 */
public class Plx extends AbstractMnemonic {

	/**
	 * Instantiates a new Plx.
	 */
	public Plx() {
		super("PLX", new int[] { 0xFA, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
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
