package com.sixtyfour.elements.mnemonics;

/**
 * The Class Jmp.
 */
public class Jmp extends AbstractMnemonic {

	/**
	 * Instantiates a new jmp.
	 */
	public Jmp() {
		super("JMP", new int[] { 0, 0, 0x4C, 0, 0, 0, 0, 0, 0x6C, 0, 0, 0 });
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.mnemonics.AbstractMnemonic#isJump()
	 */
	@Override
	public boolean isJump() {
		return true;
	}
}
