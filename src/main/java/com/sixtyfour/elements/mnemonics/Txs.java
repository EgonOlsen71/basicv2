package com.sixtyfour.elements.mnemonics;

public class Txs extends AbstractMnemonic {
	public Txs() {
		super("TXS", new int[] { 0x9A, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 });
	}

	@Override
	public boolean isSingle() {
		return true;
	}

}
