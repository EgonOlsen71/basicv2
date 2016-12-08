package com.sixtyfour.elements.mnemonics;


public class Tsx extends AbstractMnemonic {
	public Tsx() {
		super("TSX", new int[] { 0xBA, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}
	
	@Override
	public boolean isSingle() {
		return true;
	}

}
