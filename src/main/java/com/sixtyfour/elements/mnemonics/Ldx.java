package com.sixtyfour.elements.mnemonics;

/**
 * The Class Ldx.
 */
public class Ldx extends AbstractMnemonic {

	/**
	 * Instantiates a new ldx.
	 */
	public Ldx() {
		super("LDX", new int[] { 0, 0xA2, 0xAE, 0, 0xBE, 0xA6, 0, 0xB6, 0, 0, 0, 0 });
	}

	@Override
	public int getMaxLength() {
		return 3;
	}
}
