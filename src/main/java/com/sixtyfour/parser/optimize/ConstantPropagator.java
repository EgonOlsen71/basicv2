package com.sixtyfour.parser.optimize;

import com.sixtyfour.Logger;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.Let;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Term;
import com.sixtyfour.system.Machine;

/**
 * Propagates constants so that the constant folder can run more efficiently. It
 * also applies some optimizations to multiplications and divisions while we are
 * at it.
 * 
 * @author EgonOlsen
 * 
 */
public class ConstantPropagator {

	/**
	 * Propagates constants so that the constant folder can run more efficiently.
	 * 
	 * @param config  the compiler configuration
	 * @param machine the machine
	 * @return has something been optimized?
	 */
	public static boolean propagateConstants(CompilerConfig config, Machine machine) {
		boolean found = false;
		boolean doneSomething = false;
		if (config.isConstantPropagation()) {
			Logger.log("Propagating constants...");
			do {
				found = false;
				for (Command cmd : machine.getCommandList()) {
					if (cmd.isCommand("LET")) {
						Let let = (Let) cmd;
						Variable var = let.getVar();

						// This might over-optimize assigments which happen after the variable has been
						// accessed for the first time,
						// So that it's actually not constant but either 0 or the next, then constant
						// value. I can't detect this case,
						// but it should be very rare anyway. I've never encountered it except after a
						// condition, which I do handle in Basic.java.
						if (machine.isAssignedOnce(var)) {
							if (var.isConstant()) {
								continue;
							}
							Term term = let.getTerm();
							boolean termIsConstant = ConstantPropagator.checkForConstant(config, machine, term);
							// System.out.println(termIsConstant+"/"+var+"/"+(var.isSystem()));
							if (termIsConstant && !var.isSystem()) {
								var.setValue(term.eval(machine));
								var.setConstant(true);
								Logger.log(var + " can be considered constant!");
								doneSomething = true;
								found = true;
							}
						}
					}
				}
			} while (found);
		}
		return doneSomething;
	}

	/**
	 * Checks if a term is constant.
	 * 
	 * @param config  the compiler configuration
	 * @param machine the machine
	 * @param t       the term to check
	 * @return is t constant?
	 */
	public static boolean checkForConstant(CompilerConfig config, Machine machine, Term t) {
		if (t == null) {
			return false;
		}
		boolean[] isConstant = new boolean[1];
		isConstant[0] = true;
		boolean val = checkForConstant(config, machine, t, isConstant);
		if (!val) {
			TermOptimizer.optimizeCalculations(config, machine, t);
		}
		return val;
	}

	

	private static boolean checkForConstant(CompilerConfig config, Machine machine, Term t, boolean[] isConstant) {

		if (t.getOperator().isDelimiter()) {
			isConstant[0] = false;
			return false;
		}

		if (!config.isDeadStoreEliminationOfStrings()) {
			if (t.getType(true) == Type.STRING) {
				isConstant[0] = false;
				return false;
			}
		}

		Atom left = t.getLeft();
		Atom right = t.getRight();

		// ****

		if (!isConstant[0]) {
			return false;
		}

		if (left.isTerm()) {
			Term lt = (Term) left;
			isConstant[0] &= checkForConstant(config, machine, lt, isConstant);
		} else {
			if (!(left.isConstant())) {
				if (left instanceof Function) {
					Function func = (Function) left;
					if (func.isDeterministic() && !func.isExcluded()) {
						isConstant[0] &= checkForConstant(config, machine, func.getTerm(), isConstant);
					} else {
						isConstant[0] = false;
						return false;
					}
				} else {
					isConstant[0] = false;
					return false;
				}
			}
		}
		if (right != null) {
			if (isConstant[0] && right.isTerm()) {
				Term rt = (Term) right;
				isConstant[0] &= checkForConstant(config, machine, rt, isConstant);
			} else {
				if (!(right.isConstant())) {
					if (right instanceof Function) {
						Function func = (Function) right;
						if (func.isDeterministic() && !func.isExcluded()) {
							isConstant[0] &= checkForConstant(config, machine, func.getTerm(), isConstant);
						} else {
							isConstant[0] = false;
							return false;
						}
					} else {
						isConstant[0] = false;
						return false;
					}
				}
			}
		}
		return isConstant[0];
	}
}
