package com.sixtyfour.elements.mnemonics;

public class Rts extends AbstractMnemonic {
	public Rts() {
		super("RTS", new int[] { 0x60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
