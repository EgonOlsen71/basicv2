package com.sixtyfour.elements.mnemonics;

/**
 * The Class Iny.
 */
public class Iny extends AbstractMnemonic {

	/**
	 * Instantiates a new iny.
	 */
	public Iny() {
		super("INY", new int[] { 0xC8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
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
