package com.sixtyfour.parser.logic;

import com.sixtyfour.parser.Atom;
import com.sixtyfour.system.Machine;

/**
 * An interface for logic atoms.
 */
public interface LogicBlock extends Atom {

	/**
	 * Evaluates the block to boolean.
	 * 
	 * @param machine
	 *            the machine
	 * @return the result
	 */
	boolean evalToBoolean(Machine machine);

	/**
	 * Not.
	 */
	void not();

}
