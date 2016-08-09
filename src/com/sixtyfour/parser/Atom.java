package com.sixtyfour.parser;

import com.sixtyfour.elements.Type;
import com.sixtyfour.system.Machine;

/**
 * The Interface Atom.
 */
public interface Atom {
	
	/**
	 * Gets the type.
	 * 
	 * @return the type
	 */
	Type getType();

	/**
	 * Eval.
	 * 
	 * @param machine
	 *            the machine
	 * @return the object
	 */
	Object eval(Machine machine);

	/**
	 * Checks if is term.
	 * 
	 * @return true, if is term
	 */
	boolean isTerm();

}
