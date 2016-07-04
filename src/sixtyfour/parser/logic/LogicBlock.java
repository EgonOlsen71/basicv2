package sixtyfour.parser.logic;

import sixtyfour.parser.Atom;
import sixtyfour.system.Machine;

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
