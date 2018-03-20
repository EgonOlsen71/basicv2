package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public class Tan extends MathFunction {

	public Tan() {
		super("TAN", "; FAC = TAN(FAC)", "JSR FACTAN");
	}
}
