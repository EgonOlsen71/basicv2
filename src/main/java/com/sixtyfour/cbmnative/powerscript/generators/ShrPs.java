package com.sixtyfour.cbmnative.powerscript.generators;

/**
 * @author EgonOlsen
 * 
 */
public class ShrPs extends CalculationPs {

    public ShrPs() {
	super("SHR", "({to}/([math]::pow(2,{from})))");
    }

}
