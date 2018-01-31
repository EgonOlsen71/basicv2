package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public class Pow extends Calculation {

	public Pow() {
		super("POW", "; FAC = ARG^FAC", "JSR $BF7B");
	}
}
