package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public class Je extends JumpBase {

	public Je() {
		super("BEQ", "BNE");
	}

	@Override
	public String getMnemonic() {
		return "JE";
	}
}
