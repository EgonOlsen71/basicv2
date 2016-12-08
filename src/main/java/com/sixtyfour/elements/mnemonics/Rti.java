package com.sixtyfour.elements.mnemonics;

public class Rti extends AbstractMnemonic {
	public Rti() {
		super("RTI", new int[] { 0x40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
