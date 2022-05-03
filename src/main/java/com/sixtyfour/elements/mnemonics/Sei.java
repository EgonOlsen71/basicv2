package com.sixtyfour.elements.mnemonics;

/**
 * The Class Sei.
 */
public class Sei extends AbstractMnemonic {

	/**
	 * Instantiates a new sei.
	 */
	public Sei() {
		super("SEI", new int[] { 0x78, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
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
