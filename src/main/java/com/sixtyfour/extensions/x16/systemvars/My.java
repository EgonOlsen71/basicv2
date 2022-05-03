/*
 * 
 */
package com.sixtyfour.extensions.x16.systemvars;

import com.sixtyfour.elements.Variable;
import com.sixtyfour.system.Machine;

/**
 * A system variable that represents the mouse's y-coordinate.
 */
public class My extends Variable {

	/**
	 * Instantiates a new status.
	 */
	public My() {
		super("MY", 0);
		setSystem(true);
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
