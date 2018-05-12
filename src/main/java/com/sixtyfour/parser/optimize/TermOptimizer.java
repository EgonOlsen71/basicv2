package com.sixtyfour.parser.optimize;

import java.util.Map;

import com.sixtyfour.elements.Constant;
import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Operator;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.TermBuilder;
import com.sixtyfour.system.Machine;

/**
 * Optimizer for terms. It's used to simplify a term tree's structure or the
 * terms themselves.
 * 
 * @author EgonOlsen
 * 
 */
public class TermOptimizer {

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
		boolean isConst = ConstantPropagator.checkForConstant(machine, ret);
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
		
		// Should swap factors to speed up some multiplication, but somehow gets swapped again later...!?
//		if (ret.getOperator().isPlus() || ret.getOperator().isMultiplication()) {
//			if (ret.getRight().isConstant()) {
//				Object res=ret.getRight().eval(machine);
//				if (res instanceof Number) {
//					float val=((Number)res).floatValue();
//					if (val<10) {
//						Atom r=ret.getRight();
//						ret.setRight(ret.getLeft());
//						ret.setLeft(r);
//					}
//				}
//			}
//		}

		return ret;
	}

}
