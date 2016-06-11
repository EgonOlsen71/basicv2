package sixtyfour.parser.logic;

import sixtyfour.system.Machine;

public class LogicAnd implements LogicOp {

	@Override
	public boolean eval(Machine machine, boolean state, LogicBlock block) {
		return state && block.eval(machine);
	}
	
	@Override
	public String toString() {
		return "AND";
	}

}
