package com.sixtyfour.elements.mnemonics;

public class Jmp extends AbstractMnemonic {
	public Jmp() {
		super("JMP", new int[] { 0, 0, 0x4C, 0, 0, 0, 0, 0, 0x6C, 0, 0, 0 });
	}
	
	@Override
	public boolean isJump() {
		return true;
	}
}
