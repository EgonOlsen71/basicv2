package com.sixtyfour.elements.mnemonics;

/**
 * The Class Tay.
 */
public class Tay extends AbstractMnemonic {

	/**
	 * Instantiates a new tay.
	 */
	public Tay() {
		super("TAY", new int[] { 0xA8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
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
