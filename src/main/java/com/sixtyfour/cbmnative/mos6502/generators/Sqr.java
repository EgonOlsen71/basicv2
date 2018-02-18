package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public class Sqr extends MathFunction {

	public Sqr() {
		super("SQR", "; FAC = SQR(FAC)", "JSR $BF71");
	}
}
