package sixtyfour.parser.logic;

import sixtyfour.system.Machine;

public class LogicOr implements LogicOp {

	@Override
	public boolean eval(Machine machine, boolean state, LogicBlock block) {
		return state || block.evalToBoolean(machine);
	}

	@Override
	public String toString() {
		return "OR";
	}
	
	@Override
	public boolean isAnd() {
		return false;
	}

}
