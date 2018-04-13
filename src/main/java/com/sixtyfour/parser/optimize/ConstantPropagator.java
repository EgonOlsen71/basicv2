package com.sixtyfour.parser.optimize;

import com.sixtyfour.Logger;
import com.sixtyfour.elements.Constant;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.Let;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Operator;
import com.sixtyfour.parser.Term;
import com.sixtyfour.system.CompilerConfig;
import com.sixtyfour.system.Machine;

/**
 * @author EgonOlsen
 * 
 */
public class ConstantPropagator {

	public static boolean propagateConstants(Machine machine) {
		boolean found = false;
		boolean doneSomething = false;
		if (CompilerConfig.getConfig().isConstantPropagation()) {
			do {
				found = false;
				for (Command cmd : machine.getCommandList()) {
					if (cmd.isCommand("LET")) {
						Let let = (Let) cmd;
						Variable var = let.getVar();
						if (machine.isAssignedOnce(var)) {
							if (var.isConstant()) {
								continue;
							}
							Term term = let.getTerm();
							boolean termIsConstant = ConstantPropagator.checkForConstant(machine, term);
							if (termIsConstant) {
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

	public static boolean checkForConstant(Machine machine, Term t) {
		if (t == null) {
			return false;
		}
		boolean[] isConstant = new boolean[1];
		isConstant[0] = true;
		return checkForConstant(machine, t, isConstant);
	}

	public static boolean checkForConstant(Machine machine, Term t, boolean[] isConstant) {

		// Value up to which divisions by <value> will be converted into
		// *1/<value>
		double thresHold = 1000;

		if (t.getOperator().isDelimiter()) {
			isConstant[0] = false;
			return false;
		}
		if (t.getType(true) == Type.STRING) {
			isConstant[0] = false;
			return false;
		}

		Atom left = t.getLeft();
		Atom right = t.getRight();

		// While we are at it: Optimize some divisions to multiplications by
		// 1/...
		if (t.getOperator().isDivision()) {
			double val = 0;
			if (right.isConstant() && (val = ((Number) right.eval(machine)).doubleValue()) < thresHold && val > -thresHold) {
				t.setOperator(new Operator('*'));
				right = new Constant<Float>((float) (1d / val));
				t.setRight(right);
			}
		}

		if (!isConstant[0]) {
			return false;
		}
		if (left.isTerm()) {
			Term lt = (Term) left;
			isConstant[0] &= checkForConstant(machine, lt, isConstant);
		} else {
			if (!(left.isConstant())) {
				if (left instanceof Function) {
					Function func = (Function) left;
					if (func.isDeterministic()) {
						isConstant[0] &= checkForConstant(machine, func.getTerm(), isConstant);
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
				isConstant[0] &= checkForConstant(machine, rt, isConstant);
			} else {
				if (!(right.isConstant())) {
					if (right instanceof Function) {
						Function func = (Function) right;
						if (func.isDeterministic()) {
							isConstant[0] &= checkForConstant(machine, func.getTerm(), isConstant);
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
