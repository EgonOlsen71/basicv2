package com.sixtyfour.parser.assembly;

import com.sixtyfour.system.Machine;

/**
 * Common interface for constants
 * 
 * @author EgonOlsen
 * 
 */
public interface ConstantValue {
	/**
	 * Returns the name of the constant
	 * 
	 * @return the name
	 */
	String getName();

	/**
	 * Returns the value of the constant
	 * 
	 * @return the value
	 */
	int getValue();

	/**
	 * Applies the constant, i.e. write the constant into ram at the given address.
	 * 
	 * @param machine the current machine
	 * @param address the address
	 * @return the new address after the newly written byte(s)
	 */
	int apply(Machine machine, int address);
}
