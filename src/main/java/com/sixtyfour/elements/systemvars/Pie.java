/*
 * 
 */
package com.sixtyfour.elements.systemvars;

import com.sixtyfour.elements.Variable;

/**
 * A system variable that represents PI.
 */
public class Pie extends Variable {

	/**
	 * Instantiates a new pie.
	 */
	public Pie() {
		super("Π", (float) Math.PI);
		setSystem(true);
	}

	@Override
	public boolean isReadOnly() {
		return true;
	}
	
	@Override
	public boolean isConstant() {
		return true;
	}

}
