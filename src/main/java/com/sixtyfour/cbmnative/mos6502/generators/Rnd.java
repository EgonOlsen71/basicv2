package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public class Rnd extends MathFunction {

	public Rnd() {
		super("RND", "; FAC = RND(FAC)", "JSR FACRND");
	}
}
