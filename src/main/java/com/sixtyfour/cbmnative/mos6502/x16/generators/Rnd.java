package com.sixtyfour.cbmnative.mos6502.x16.generators;

import com.sixtyfour.cbmnative.mos6502.generators.MathFunction;

/**
 * @author EgonOlsen
 * 
 */
public class Rnd extends MathFunction {

	public Rnd() {
		super("RND", "; FAC = RND(FAC)", "JSR FACRND_X16");
	}
}
