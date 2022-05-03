package com.sixtyfour.elements.mnemonics;

/**
 * The Class Nop.
 */
public class Nop extends AbstractMnemonic {

	/**
	 * Instantiates a new nop.
	 */
	public Nop() {
		super("NOP", new int[] { 0xEA, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
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
