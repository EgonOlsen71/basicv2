package com.sixtyfour.cbmnative.powerscript.generators;

/**
 * @author EgonOlsen
 * 
 */
public class SgnPs extends CalculationPs {

	public SgnPs() {
		super("SGN", "([math]::sign({from}))");
	}
}
