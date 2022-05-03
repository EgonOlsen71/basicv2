package com.sixtyfour.elements.mnemonics;

/**
 * The Class Rts.
 */
public class Rts extends AbstractMnemonic {

	/**
	 * Instantiates a new rts.
	 */
	public Rts() {
		super("RTS", new int[] { 0x60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
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
