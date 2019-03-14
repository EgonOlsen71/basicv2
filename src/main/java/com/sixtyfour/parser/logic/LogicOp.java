/*
 * 
 */
package com.sixtyfour.parser.logic;

import com.sixtyfour.system.Machine;

/**
 * An interface for logic operations, which will be implemented by the or and
 * and operations.
 */
public interface LogicOp {

	/**
	 * Evaluates "state" LogicOp LogicBlock, for example "true AND
	 * block.eval(machine)" if state is true and the operation is AND.
	 * 
	 * @param machine the machine
	 * @param state   the current state to apply the operation to
	 * @param block   the logic block to apply the operation to
	 * @return the result of the evaluation
	 */
	boolean eval(Machine machine, boolean state, LogicBlock block);

	/**
	 * Checks if this operation is the and-operation. This can be used for lazy
	 * evaluation optimizations.
	 * 
	 * @return true, if it is the and-operation
	 */
	boolean isAnd();
}
