package com.sixtyfour.parser.logic;

import com.sixtyfour.parser.Atom;
import com.sixtyfour.system.Machine;

/**
 * The Interface LogicBlock.
 */
public interface LogicBlock extends Atom {

	/**
	 * Eval to boolean.
	 * 
	 * @param machine
	 *            the machine
	 * @return true, if successful
	 */
	boolean evalToBoolean(Machine machine);

	/**
	 * Not.
	 */
	void not();

}
