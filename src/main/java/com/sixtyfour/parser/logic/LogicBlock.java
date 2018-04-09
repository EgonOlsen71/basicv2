package com.sixtyfour.parser.logic;

import java.util.List;

import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Term;
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
	 * Not. Negates the block's state.
	 */
	void not();
	
	/**
	 * Returns the terms used to form this logic block in no particular order.
	 * 
	 * @return the terms
	 */
	List<Term> getTerms();

}
