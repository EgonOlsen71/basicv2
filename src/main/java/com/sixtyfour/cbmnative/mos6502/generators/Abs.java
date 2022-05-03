package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public class Abs extends MathFunction {

	public Abs() {
		super("ABS", "; FAC = ABS(FAC)", "JSR FACABS");
	}
}
