package com.sixtyfour.cbmnative.powerscript.generators;

/**
 * @author EgonOlsen
 * 
 */
public class OrPs extends CalculationPs {

    public OrPs() {
	super("OR", "(([math]::floor({to})) -bor ([math]::floor({from})))");
    }

}
