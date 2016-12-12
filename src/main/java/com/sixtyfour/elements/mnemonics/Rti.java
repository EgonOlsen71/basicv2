package com.sixtyfour.elements.mnemonics;

/**
 * The Class Rti.
 */
public class Rti extends AbstractMnemonic {
	
	/**
   * Instantiates a new rti.
   */
	public Rti() {
		super("RTI", new int[] { 0x40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	/* (non-Javadoc)
	 * @see com.sixtyfour.elements.mnemonics.AbstractMnemonic#isSingle()
	 */
	@Override
	public boolean isSingle() {
		return true;
	}

}
