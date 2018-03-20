package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public class Exp extends MathFunction {

	public Exp() {
		super("EXP", "; FAC = EXP(FAC)", "JSR FACEXP");
	}
}
