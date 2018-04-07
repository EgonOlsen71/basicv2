package com.sixtyfour.parser.optimize;

import com.sixtyfour.elements.Constant;
import com.sixtyfour.elements.Type;
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
	public static Term foldConstants(Term finalTerm, Machine machine) {
		Atom left = finalTerm.getLeft();
		Atom right = finalTerm.getRight();

		if (finalTerm.getOperator().isNop()) {
			return finalTerm;
		}

		if (left.isConstant() && right.isConstant() && left.getType().equals(right.getType())) {
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
				finalTerm.setLeft(foldConstants((Term) left, machine));
			}
			if ((right.isTerm())) {
				finalTerm.setRight(foldConstants((Term) right, machine));
			}
		}

		return finalTerm;
	}
}
