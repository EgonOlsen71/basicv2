package com.sixtyfour.cbmnative.javascript.generators;

/**
 * @author EgonOlsen
 * 
 */
public class AndJs extends CalculationJs {

	public AndJs() {
		super("AND", "Math.floor({to}) & Math.floor({from})");
	}

}
