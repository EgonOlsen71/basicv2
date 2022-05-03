package com.sixtyfour.elements.mnemonics;

/**
 * The Class Clv.
 */
public class Clv extends AbstractMnemonic {

	/**
	 * Instantiates a new clv.
	 */
	public Clv() {
		super("CLV", new int[] { 0xB8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
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
