package com.sixtyfour.cbmnative.powerscript.generators;

/**
 * @author EgonOlsen
 * 
 */
public class AndPs extends CalculationPs {

	public AndPs() {
		super("AND", "(([math]::floor({to})) -band ([math]::floor({from})))");
	}

}
