/*
 * 
 */
package com.sixtyfour.parser.logic;

import com.sixtyfour.system.Machine;

/**
 * The logic operation of OR.
 */
public class LogicOr implements LogicOp {

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.logic.LogicOp#eval(sixtyfour.system.Machine,
	 * boolean, sixtyfour.parser.logic.LogicBlock)
	 */
	@Override
	public boolean eval(Machine machine, boolean state, LogicBlock block) {
		return state || block.evalToBoolean(machine);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "OR";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.logic.LogicOp#isAnd()
	 */
	@Override
	public boolean isAnd() {
		return false;
	}

}
