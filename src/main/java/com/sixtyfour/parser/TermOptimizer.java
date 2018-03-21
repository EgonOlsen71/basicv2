package com.sixtyfour.parser;

import java.util.Map;

import com.sixtyfour.elements.Constant;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * Optimizer for terms. It's used to simplify a term tree's structure or the
 * terms themselves.
 * 
 * @author EgonOlsen
 * 
 */
public class TermOptimizer {
	/**
	 * Optimizes the term tree by aggregating constants where possible.
	 * 
	 * @param finalTerm
	 *            the final term
	 * @param machine
	 *            the machine
	 * @return the optimized term
	 */
	public static Term optimizeConstants(Term finalTerm, Machine machine) {
		Atom left = finalTerm.getLeft();
		Atom right = finalTerm.getRight();

		if (finalTerm.getOperator().isNop()) {
			return finalTerm;
		}

		if (left instanceof Constant && right instanceof Constant && left.getType().equals(right.getType())) {
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
		} else {
			if ((left.isTerm())) {
				finalTerm.setLeft(optimizeConstants((Term) left, machine));
			}
			if ((right.isTerm())) {
				finalTerm.setRight(optimizeConstants((Term) right, machine));
			}
		}

		return finalTerm;
	}

	/**
	 * Optimizes the term by removing redundant entries that made it into the
	 * tree during its creation.
	 * 
	 * @param finalTerm
	 *            the final term
	 * @param machine
	 *            the machine
	 * @return the optimized term
	 */
	public static Term optimizeTermTree(Term finalTerm, Machine machine) {
		Atom left = finalTerm.getLeft();
		Atom right = finalTerm.getRight();

		if (!(left.isTerm())) {
			return finalTerm;
		}

		if (!finalTerm.getOperator().isNop()) {
			finalTerm.setLeft(optimizeTermTree((Term) left, machine));
			if ((right.isTerm())) {
				finalTerm.setRight(optimizeTermTree((Term) right, machine));
			}
			return finalTerm;
		} else {
			return (Term) left;
		}
	}

	/**
	 * @param machine
	 * @param ret
	 * @param termMap
	 * @param builder
	 * @return
	 */
	public static Term optimizeTerm(Machine machine, Term ret, Map<String, Term> termMap, TermBuilder builder) {
		if (ret.getType(true) == Type.STRING) {
			return ret;
		}

		if (ret.getOperator().isDelimiter()) {
			return ret;
		}
		if (ret.getLeft() instanceof Constant && ret.getOperator().isNop()) {
			return ret;
		}
		boolean[] isConstant = new boolean[1];
		isConstant[0] = true;
		boolean isConst = checkForConstant(machine, ret, isConstant);
		if (isConst) {
			// System.out.println("To replace: " + ret);
			String ts = ret.eval(machine).toString();
			if (ts.toLowerCase().contains("e")) {
				return ret;
			}
			if (ts.endsWith(".0")) {
				// If it can be an integer...then is should be one
				ts = ts.substring(0, ts.length() - 2);
			}
			// System.out.println("TS: "+ts);
			Term t = new Term(ts, termMap);
			t = builder.build(t, termMap, machine);
			if (!t.isComplete()) {
				t.setOperator(Operator.NOP);
				t.setRight(new Constant<Integer>(0));
			}
			ret = t;
			// System.out.println("Replaced by: " + ret);
		}

		return ret;
	}

	private static boolean checkForConstant(Machine machine, Term t, boolean[] isConstant) {

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
			if (right instanceof Constant && (val = ((Number) right.eval(machine)).doubleValue()) < thresHold && val > -thresHold) {
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
			if (!(left instanceof Constant)) {
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
				if (!(right instanceof Constant)) {
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
