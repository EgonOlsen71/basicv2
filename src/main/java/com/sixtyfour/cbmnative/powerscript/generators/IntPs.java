package com.sixtyfour.cbmnative.powerscript.generators;

/**
 * @author EgonOlsen
 * 
 */
public class IntPs extends CalculationPs {

	public IntPs() {
		super("INT", "([math]::floor({from}))");
	}
}
