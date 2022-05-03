package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public class Xor extends Calculation {

	public Xor() {
		super("XOR", "; FAC = ARG ^ FAC", "JSR FACXOR");
	}
}
