package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public class Mul extends Calculation {

	public Mul() {
		super("MUL", "; FAC = ARG * FAC", "JSR MEMMUL", true);
		// super("MUL", "; FAC = ARG * FAC", "JSR FACMUL", false);
	}
}
