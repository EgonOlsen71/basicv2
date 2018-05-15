package com.sixtyfour.parser.optimize;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Constant;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Operator;
import com.sixtyfour.parser.Term;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * @author EgonOlsen
 * 
 */
public class ConstantFolder {
	/**
	 * Optimizes the term tree by folding constants where possible.
	 * 
	 * @param finalTerm
	 *            the final term
	 * @param machine
	 *            the machine
	 * @return the optimized term
	 */
	public static Term foldConstants(CompilerConfig config, Term finalTerm, Machine machine) {
		if (config.isConstantFolding()) {
			Atom left = finalTerm.getLeft();
			Atom right = finalTerm.getRight();

			if (finalTerm.getOperator().isNop()) {
				if (left.isConstant()) {
					setConstant(finalTerm, machine, left);
				}
				return finalTerm;
			}

			if (left.isConstant() && right.isConstant() && Type.isAssignable(left.getType(), right.getType())) {
				setConstant(finalTerm, machine, left);
			} else {
				if (left.isTerm()) {
					finalTerm.setLeft(foldConstants(config, (Term) left, machine));
				}
				if (right.isTerm()) {
					finalTerm.setRight(foldConstants(config, (Term) right, machine));
				}

				if (left instanceof Function) {
					Function fun = (Function) left;
					fun.setTerm(foldConstants(config, fun.getTerm(), machine));
				}

				if (right instanceof Function) {
					Function fun = (Function) right;
					fun.setTerm(foldConstants(config, fun.getTerm(), machine));
				}
			}
		}
		return finalTerm;
	}

	public static void foldConstants(CompilerConfig config, Machine machine) {
		if (config.isConstantFolding()) {
			for (Command cmd : machine.getCommandList()) {
				for (Term cmdTerm : cmd.getAllTerms()) {
					/*
					 * if (cmdTerm != null && cmd.getTerm() != null) {
					 * System.out.println(cmd.getName() + "/" + cmdTerm + "/" +
					 * cmd.getTerm().getInitial() + "/" +
					 * ConstantPropagator.checkForConstant(machine, cmdTerm)); }
					 */
					if (cmdTerm != null) {
						foldConstants(config, cmdTerm, machine);
						// System.out.println("> " + cmdTerm);
					}
				}
			}
		}
	}

	private static void setConstant(Term finalTerm, Machine machine, Atom left) {
		Constant<?> conty = null;
		Object val = finalTerm.eval(machine);
		if (left.getType().equals(Type.STRING)) {
			conty = new Constant<String>(val.toString());
		} else if (VarUtils.isFloat(val)) {
			conty = new Constant<Float>((Float) val);
		} else if (VarUtils.isInteger(val)) {
			conty = new Constant<Integer>((Integer) val);
		}
		if (conty != null) {
			finalTerm.setOperator(Operator.NOP);
			finalTerm.setLeft(conty);
			finalTerm.setRight(new Constant<Integer>(0));
		}
	}
}
