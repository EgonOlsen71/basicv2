package com.sixtyfour.elements.mnemonics;

/**
 * The Class Tsx.
 */
public class Tsx extends AbstractMnemonic {

	/**
	 * Instantiates a new tsx.
	 */
	public Tsx() {
		super("TSX", new int[] { 0xBA, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
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
