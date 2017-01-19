package com.sixtyfour.parser;

import com.sixtyfour.elements.Type;
import com.sixtyfour.system.Machine;

/**
 * Interface for atoms. Every part of a BASIC program will be parsed into an
 * Atom, i.e. terms, variables, constants, commands...are all Atoms.
 */
public interface Atom {

	/**
	 * Returns the Type that this Atom is supposed to return when calling the
	 * eval() method.
	 * 
	 * @return the type
	 */
	Type getType();

	/**
	 * Evaluates this Atom in the context of the current machine state.
	 * 
	 * @param machine
	 *            the machine
	 * @return the result of the evaluation. This will be either null, an
	 *         Integer, a Float or a String.
	 */
	Object eval(Machine machine);

	/**
	 * Returns true, if the Atom represents a Term and false otherwise.
	 * 
	 * @return true, if it's a term
	 */
	boolean isTerm();

}
