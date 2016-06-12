package sixtyfour.parser.logic;

import sixtyfour.system.Machine;


public interface LogicOp {

	boolean eval(Machine machine, boolean state, LogicBlock block);

	boolean isAnd();
}
