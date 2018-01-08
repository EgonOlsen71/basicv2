package com.sixtyfour.cbmnative.mos6502.generators;


/**
 * @author EgonOlsen
 * 
 */
public class Jne extends JumpBase {

	public Jne() {
		super("BNE", "BEQ");
	}
	
	@Override
	public String getMnemonic() {
		return "JNE";
	}
}
