/*
 * 
 */
package com.sixtyfour.parser.logic;

import com.sixtyfour.system.Machine;

/**
 * The Interface LogicOp.
 */
public interface LogicOp {

	/**
	 * Eval.
	 * 
	 * @param machine
	 *            the machine
	 * @param state
	 *            the state
	 * @param block
	 *            the block
	 * @return true, if successful
	 */
	boolean eval(Machine machine, boolean state, LogicBlock block);

	/**
	 * Checks if is and.
	 * 
	 * @return true, if is and
	 */
	boolean isAnd();
}
