package com.sixtyfour.cbmnative.mos6502.generators;

/**
 * @author EgonOlsen
 *
 */
public class Int extends MathFunction {

    public Int() {
	super("INT", "; FAC = INT(FAC)", "JSR $BCCC");
    }
}
