package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public class Sgn extends MathFunction {

	public Sgn() {
		super("SGN", "; FAC = SGN(FAC)", "JSR FACSIG");
	}
}
