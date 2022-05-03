package com.sixtyfour.cbmnative.javascript.generators;

/**
 * @author EgonOlsen
 * 
 */
public class OrJs extends CalculationJs {

	public OrJs() {
		super("OR", "Math.floor({to}) | Math.floor({from})");
	}

}
