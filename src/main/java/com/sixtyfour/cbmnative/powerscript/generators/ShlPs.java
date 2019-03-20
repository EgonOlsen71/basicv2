package com.sixtyfour.cbmnative.powerscript.generators;

/**
 * @author EgonOlsen
 * 
 */
public class ShlPs extends CalculationPs {

	public ShlPs() {
		super("SHL", "({to}*([math]::pow(2,{from})))");
	}

}
