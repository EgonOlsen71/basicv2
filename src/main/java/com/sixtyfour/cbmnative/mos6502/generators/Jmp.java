package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public class Jmp extends JumpBase {

	public Jmp() {
		super("JMP", null);
	}

	@Override
	public String getMnemonic() {
		return "JMP";
	}
}
