package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;

public class Gt extends Compare {

    protected Gt() {
	super("GT", "BCS");
    }
    
    @Override
    protected void doCompare(List<String> nCode) {
	    // Vergleich Konstante (A/Y) mit FAC: A=0 wenn gleich, A=1 wenn FAC größer, A=$FF wenn FAC kleiner
	    nCode.add("ROL");
	    super.doCompare(nCode);
    }
    
}
