package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 * 
 */
public class Shl extends Shr {

	public Shl() {
		super("SHL", "; FAC = FAC<<A", "JSR SHL");
	}

}
