package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public class Neg extends Calculation {

	public Neg() {
		super("NEG", "; FAC = FAC * -1", "JSR NEG");
	}
}
