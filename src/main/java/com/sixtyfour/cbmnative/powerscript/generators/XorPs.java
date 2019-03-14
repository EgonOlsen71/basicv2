package com.sixtyfour.cbmnative.powerscript.generators;

/**
 * @author EgonOlsen
 * 
 */
public class XorPs extends CalculationPs {

	public XorPs() {
		super("XOR", "Math.floor({to}) ^ Math.floor({from})");
	}

}
