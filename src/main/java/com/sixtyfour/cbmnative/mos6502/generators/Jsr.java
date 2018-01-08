package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public class Jsr extends JumpBase {

	public Jsr() {
		super("JSR", null);
	}

	@Override
	public String getMnemonic() {
		return "JSR";
	}
}
