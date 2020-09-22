package com.sixtyfour.elements.mnemonics;

/**
 * The Class Bit.
 */
public class Bit extends AbstractMnemonic {

	/**
	 * Instantiates a new bit.
	 */
	public Bit() {
		super("BIT", new int[] { 0, 0, 0x2C, 0, 0, 0x24, 0, 0, 0, 0, 0, 0 });
	}
	
	@Override
	public int getMaxLength() {
		return 3;
	}
}
