package com.sixtyfour.elements.mnemonics;

/**
 * The Class Cli.
 */
public class Cli extends AbstractMnemonic {

	/**
	 * Instantiates a new cli.
	 */
	public Cli() {
		super("CLI", new int[] { 0x58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
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
