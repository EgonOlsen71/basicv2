package sixtyfour.parser;

import sixtyfour.elements.Type;
import sixtyfour.system.Machine;

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
	 * @param memory
	 *            the memory
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
