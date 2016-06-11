package sixtyfour.parser.logic;

import sixtyfour.system.Machine;

public interface LogicBlock {

	boolean eval(Machine machine);

	void not();

}
