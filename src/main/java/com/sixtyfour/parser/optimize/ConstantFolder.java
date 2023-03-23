package com.sixtyfour.parser.optimize;

import com.sixtyfour.Logger;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Constant;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
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
			
			// System.out.println("1: "+finalTerm+"/"+finalTerm.isConstant()+"/"+finalTerm.getLeft().getClass());

			if (op.isNop()) {
				if (left.isConstant()) {
					setConstant(finalTerm, machine, left);
					//System.out.println("2: "+finalTerm+"/"+finalTerm.isConstant());
				}
				// Make sure that stuff like PEEK(<Constant>+<Constant>) is handled properly
				// If there are actual left AND right functions, this will be handled
				// below...but
				// this case is special and has to be done here...or one has to refactor the
				// part
				// below, but who wants to do that....?
				if (left instanceof Function) {
					Function functy = ((Function) left);
					functy.setTerm(foldConstants(config, ((Function) left).getTerm(), machine));
					
					// This was supposed to fix the missing propagation of stuff like LEFT$("hello",2) and while it does so,
					// it cause things like MID$("hello",i,1) to fail...no idea, why ATM...I'll leave this to future me to figure it out...
					/*
					if (functy.isDeterministic() && !functy.isExcluded() && finalTerm.getRight().isConstant()) {
						System.out.println("1: "+finalTerm+"/"+finalTerm.isConstant()+"/"+finalTerm.getLeft().getClass()+" - "+finalTerm.getRight());
						setConstant(finalTerm, machine, left);
						System.out.println("2: "+finalTerm+"/"+finalTerm.isConstant()+"/"+finalTerm.getLeft().getClass()+" - "+finalTerm.getRight());
					}
					*/
				}
				return finalTerm;
			}

			if (left.isConstant() && right.isConstant() && !op.isDelimiter()
					&& Type.isAssignable(left.getType(), right.getType())) {
				// This mustn't trigger for terms that are actually parameter lists...
				setConstant(finalTerm, machine, left);
			} else {
				//System.out.println(left.getClass()+"/"+left+"/"+left.isConstant());
				
				if (left.isTerm()) {
					finalTerm.setLeft(foldConstants(config, (Term) left, machine));
				}
				if (right.isTerm()) {
					finalTerm.setRight(foldConstants(config, (Term) right, machine));
				}

				// Attention: Doing these operations on the variables actually replaces them.
				// That means that one can't store a Term or a Variable before the optimizer run
				// and still use it afterwards, because it might has been converted into a
				// const.
				// This affects multiple command implementations, which had to be modified to
				// reflect this.
				if (left instanceof Variable && !((Variable) left).isArray() && left.isConstant()) {
					Constant<?> conty = createConstant(left, left.eval(machine));
					finalTerm.setLeft(conty);
				}

				if (right instanceof Variable && !((Variable) right).isArray() && right.isConstant()) {
					Constant<?> conty = createConstant(right, right.eval(machine));
					finalTerm.setRight(conty);
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

		// System.out.println("3: "+finalTerm+"/"+finalTerm.isConstant());

		return finalTerm;
	}

	private static void setConstant(Term finalTerm, Machine machine, Atom left) {
		Object val = finalTerm.eval(machine);
		Constant<?> conty = createConstant(left, val);
		//System.out.println("Conty: "+finalTerm+"/"+conty);
		if (conty != null) {
			finalTerm.setOperator(Operator.NOP);
			finalTerm.setLeft(conty);
			finalTerm.setRight(new Constant<Integer>(0));
			finalTerm.setConstant(true);
		}
	}

	private static Constant<?> createConstant(Atom left, Object val) {
		Constant<?> conty = null;
		if (left.getType().equals(Type.STRING)) {
			conty = new Constant<String>(val.toString());
		} else if (VarUtils.isFloat(val)) {
			conty = new Constant<Float>((Float) val);
		} else if (VarUtils.isDouble(val)) {
			conty = new Constant<Double>((Double) val);
		} else if (VarUtils.isInteger(val)) {
			conty = new Constant<Integer>((Integer) val);
		}
		return conty;
	}
}
