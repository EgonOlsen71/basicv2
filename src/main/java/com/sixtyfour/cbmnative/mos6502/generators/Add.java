package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public class Add extends Calculation {

	public Add() {
		super("ADD", "; FAC = ARG + FAC", "JSR $B86A");
	}
}
