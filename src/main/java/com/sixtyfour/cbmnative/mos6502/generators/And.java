package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 *
 */
public class And extends Calculation {

    public And() {
	super("AND", "; FAC = ARG & FAC", "JSR $AFE9");
    }
}
