package com.sixtyfour.cbmnative.javascript.generators;

/**
 * @author EgonOlsen
 * 
 */
public class AndJs extends CalculationJs {

    public AndJs() {
	super("OR", "Math.floor({to}) | Math.floor({from})");
    }

}
