package com.sixtyfour.elements.mnemonics;

/**
 * The Class Phx.
 */
public class Phx extends AbstractMnemonic {

	/**
	 * Instantiates a new Phx.
	 */
	public Phx() {
		super("PHX", new int[] { 0xDA, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
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
