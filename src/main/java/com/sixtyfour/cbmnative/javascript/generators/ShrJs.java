package com.sixtyfour.cbmnative.javascript.generators;

/**
 * @author EgonOlsen
 * 
 */
public class ShrJs extends CalculationJs {

    public ShrJs() {
	super("SHR", "{to}/Math.pow(2,{from})");
    }

}
