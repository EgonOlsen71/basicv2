package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public class Atn extends MathFunction {

	public Atn() {
		super("ATN", "; FAC = ATN(FAC)", "JSR FACATN");
	}
}
