package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public class Div extends Calculation {

	public Div() {
		super("DIV", "; FAC = ARG / FAC", "JSR ARGDIV");
	}
}
