package com.sixtyfour.parser.optimize;

import com.sixtyfour.Logger;
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
 * Folds constants, i.e. it detects if some expression is actually constant and
 * replaces it with a single constant, if it is.
 * 
 * @author EgonOlsen
 * 
 */
public class ConstantFolder {

	/**
	 * Optimizes the term tree by folding constants where possible. The optimized
	 * terms are inserted directly into the term tree.
	 * 
	 * @param config  the compiler configuration
	 * @param machine the machine
	 */
	public static void foldConstants(CompilerConfig config, Machine machine) {
		if (config.isConstantFolding()) {
			Logger.log("Folding constants...");
			for (Command cmd : machine.getCommandList()) {
				for (Term cmdTerm : cmd.getAllTerms()) {
					/*
					 * if (cmdTerm != null && cmd.getTerm() != null) {
					 * System.out.println(cmd.getName() + "/" + cmdTerm + "/" +
					 * cmd.getTerm().getInitial() + "/" +
					 * ConstantPropagator.checkForConstant(machine, cmdTerm)); }
					 */
					if (cmdTerm != null) {
						// System.out.println(cmd + " : " + cmdTerm);
						foldConstants(config, cmdTerm, machine);
						// System.out.println(cmd + " 1: " + cmdTerm);
						// System.out.println("> " + cmdTerm);
					}
				}
			}
		}
	}

	/**
	 * Optimizes the term tree by folding constants where possible.
	 * 
	 * @param finalTerm the final term
	 * @param machine   the machine
	 * @return the optimized term
	 */
	public static Term foldConstants(CompilerConfig config, Term finalTerm, Machine machine) {
		if (config.isConstantFolding()) {
			Atom left = finalTerm.getLeft();
			Atom right = finalTerm.getRight();
			Operator op = finalTerm.getOperator();

			if (op.isNop()) {
				if (left.isConstant()) {
					setConstant(finalTerm, machine, left);
				}
				return finalTerm;
			}

			if (left.isConstant() && right.isConstant() && !op.isDelimiter()
					&& Type.isAssignable(left.getType(), right.getType())) {
				// This mustn't trigger for terms that are actually parameter lists...
				setConstant(finalTerm, machine, left);
			} else {
				if (left.isTerm()) {
					finalTerm.setLeft(foldConstants(config, (Term) left, machine));
				}
				if (right.isTerm()) {
					finalTerm.setRight(foldConstants(config, (Term) right, machine));
				}

				// This should actually handle code like T=198:WAIT T,0...but somehow, T (in
				// this case)
				// is still used in the compiled code albeit it's removed from this term. I
				// can't be bothered
				// to track this down for now. It's not really an issue anyway. WAIT T+1,1 will
				// be optimized
				// just fine, which is the actual purpose of all this.

				/*
				 * if (left instanceof Variable && left.isConstant()) {
				 * finalTerm.setLeft(convert((Variable) left, machine)); } if (right instanceof
				 * Variable && right.isConstant()) { finalTerm.setRight(convert((Variable)
				 * right, machine)); }
				 */

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

	private static void setConstant(Term finalTerm, Machine machine, Atom left) {
		Constant<?> conty = null;
		Object val = finalTerm.eval(machine);
		if (left.getType().equals(Type.STRING)) {
			conty = new Constant<String>(val.toString());
		} else if (VarUtils.isFloat(val)) {
			conty = new Constant<Float>((Float) val);
		}	else if (VarUtils.isDouble(val)) {
			conty = new Constant<Double>((Double) val);
		} else if (VarUtils.isInteger(val)) {
			conty = new Constant<Integer>((Integer) val);
		}
		if (conty != null) {
			finalTerm.setOperator(Operator.NOP);
			finalTerm.setLeft(conty);
			finalTerm.setRight(new Constant<Integer>(0));
			finalTerm.setConstant(true);
		}
	}
}
