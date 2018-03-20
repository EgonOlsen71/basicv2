package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public class Log extends MathFunction {

	public Log() {
		super("LOG", "; FAC = LOG(FAC)", "JSR FACLOG");
	}
}
