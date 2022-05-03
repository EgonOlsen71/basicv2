package com.sixtyfour.elements.mnemonics;

/**
 * The Class Txs.
 */
public class Txs extends AbstractMnemonic {

	/**
	 * Instantiates a new txs.
	 */
	public Txs() {
		super("TXS", new int[] { 0x9A, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
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
