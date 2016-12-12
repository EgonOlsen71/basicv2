package com.sixtyfour.elements.mnemonics;

/**
 * The Class Sbc.
 */
public class Sbc extends AbstractMnemonic {
	
	/**
   * Instantiates a new sbc.
   */
	public Sbc() {
		super("SBC", new int[] { 0,0xE9, 0xED, 0xFD, 0xF9, 0xE5, 0xF5,0,0, 0xE1, 0xF1,0 });
	}
}
