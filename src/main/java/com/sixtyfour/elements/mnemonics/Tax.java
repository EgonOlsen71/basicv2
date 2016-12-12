package com.sixtyfour.elements.mnemonics;

/**
 * The Class Tax.
 */
public class Tax extends AbstractMnemonic {
	
	/**
   * Instantiates a new tax.
   */
	public Tax() {
		super("TAX", new int[] { 0xAA, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	/* (non-Javadoc)
	 * @see com.sixtyfour.elements.mnemonics.AbstractMnemonic#isSingle()
	 */
	@Override
	public boolean isSingle() {
		return true;
	}

}
