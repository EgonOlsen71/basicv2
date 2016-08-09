/*
 * 
 */
package com.sixtyfour.elements.systemvars;

import com.sixtyfour.elements.Variable;
import com.sixtyfour.system.Machine;

/**
 * The Class Status.
 */
public class Status extends Variable {

	/**
	 * Instantiates a new status.
	 */
	public Status() {
		super("ST", 0);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.Variable#getValue()
	 */
	@Override
	public Object getValue() {
		return 128;
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
}
