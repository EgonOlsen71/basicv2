package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public class Sin extends MathFunction {

	public Sin() {
		super("SIN", "; FAC = SIN(FAC)", "JSR FACSIN");
	}
}
