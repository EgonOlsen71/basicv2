package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public class Or extends Calculation {

	public Or() {
		super("OR", "; FAC = ARG | FAC", "JSR FACOR");
	}
}
