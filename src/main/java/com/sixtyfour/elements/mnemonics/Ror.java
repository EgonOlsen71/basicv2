package com.sixtyfour.elements.mnemonics;

/**
 * The Class Ror.
 */
public class Ror extends AbstractMnemonic {

	/**
	 * Instantiates a new ror.
	 */
	public Ror() {
		super("ROR", new int[] { 0x6A, 0, 0x6E, 0x7E, 0, 0x66, 0x76, 0, 0, 0, 0, 0 });
	}

	@Override
	public String getOptionalParameter() {
		return "a";
	}
	
	@Override
	public int getMaxLength() {
		return 3;
	}
}
