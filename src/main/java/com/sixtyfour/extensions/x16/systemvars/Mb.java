/*
 * 
 */
package com.sixtyfour.extensions.x16.systemvars;

import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.systemvars.SystemVariable;
import com.sixtyfour.system.Machine;

/**
 * A system variable that represents the mouse's button state.
 */
public class Mb extends Variable implements SystemVariable {

	/**
	 * Instantiates a new status.
	 */
	public Mb() {
		super("MB", 0);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.Variable#getValue()
	 */
	@Override
	public Object getValue() {
		return 0;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.Variable#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		return getValue();
	}
	
	@Override
	public boolean isReadOnly() {
		return true;
	}
}
