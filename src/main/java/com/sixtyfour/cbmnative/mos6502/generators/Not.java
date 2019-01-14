package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public class Not extends MathFunction {

	public Not() {
		super("NOT", "; FAC = NOT(FAC)", "JSR FACNOT");
	}
}
