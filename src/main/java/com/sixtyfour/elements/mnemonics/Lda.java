package com.sixtyfour.elements.mnemonics;

/**
 * The Class Lda.
 */
public class Lda extends AbstractMnemonic {

	/**
	 * Instantiates a new lda.
	 */
	public Lda() {
		super("LDA", new int[] { 0, 0xA9, 0xAD, 0xBD, 0xB9, 0xA5, 0xB5, 0, 0, 0xA1, 0xB1, 0 });
	}

	@Override
	public int getMaxLength() {
		return 3;
	}
}
