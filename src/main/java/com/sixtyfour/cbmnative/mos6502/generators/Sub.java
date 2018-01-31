package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 *
 */
public class Sub extends Calculation {

    public Sub() {
	super("SUB", "; FAC = ARG - FAC", "JSR $B853");
    }
}
