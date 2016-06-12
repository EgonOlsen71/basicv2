package sixtyfour.parser.logic;

import sixtyfour.parser.Atom;
import sixtyfour.system.Machine;

public interface LogicBlock extends Atom {

	boolean evalToBoolean(Machine machine);
	
	void not();

}
