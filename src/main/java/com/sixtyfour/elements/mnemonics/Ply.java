package com.sixtyfour.elements.mnemonics;

/**
 * The Class Ply.
 */
public class Ply extends AbstractMnemonic {

	/**
	 * Instantiates a new ply.
	 */
	public Ply() {
		super("PLY", new int[] { 0x7A, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
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
