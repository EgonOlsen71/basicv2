package com.sixtyfour.cbmnative.javascript.generators;

/**
 * @author EgonOlsen
 * 
 */
public class XorJs extends CalculationJs {

    public XorJs() {
	super("XOR", "Math.floor({to}) ^ Math.floor({from})");
    }

}
