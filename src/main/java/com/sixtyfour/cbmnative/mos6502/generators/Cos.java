package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public class Cos extends MathFunction {

	public Cos() {
		super("COS", "; FAC = COS(FAC)", "JSR FACCOS");
	}
}
