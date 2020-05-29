package com.sixtyfour.util;

import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.logic.Comparison;

/**
 * Some check methods for type mismatches.
 * 
 * @author EgonOlsen
 *
 */
public class Checker {

	/**
	 * Checks for a potential type mismatch. This is not 100% fail safe, i.e. some
	 * mismatches might not get caught. That's because mixing Strings with logic
	 * OR/AND is fine but could be detected as a mismatch if we just compare
	 * Type.STRING with TYPE.INTEGER. So this comparison is looser than it actually
	 * should be. It should be possible to cover this case as well, but I somehow
	 * lost track on even why this doesn't work...
	 * 
	 * @param t
	 * @return
	 */
	public static boolean isTypeMismatch(Term t) {
		Type t1 = t.getLeft().getType(true);
		Type t2 = t.getRight().getType(true);
		if ((t1 == Type.STRING && t2 == Type.REAL) || (t1 == Type.REAL && t2 == Type.STRING)) {
			return true;
		}
		if ((t1 == Type.STRING && t2 == Type.INTEGER)) {
			if (t.getRight().isConstant()) {
				return true;
			}
		}
		if ((t2 == Type.STRING && t1 == Type.INTEGER)) {
			if (t.getLeft().isConstant()) {
				return true;
			}
		}
		return false;
	}

	/**
	 * Checks for a potential type mismatch. This is not 100% fail safe, i.e. some
	 * mismatches might not get caught. That's because mixing Strings with logic
	 * OR/AND is fine but could be detected as a mismatch if we just compare
	 * Type.STRING with TYPE.INTEGER. So this comparison is looser than it actually
	 * should be. It should be possible to cover this case as well, but I somehow
	 * lost track on even why this doesn't work...
	 * 
	 * @param t
	 * @return
	 */
	public static boolean isTypeMismatch(Comparison t) {
		Type t1 = t.getLeft().getType(true);
		Type t2 = t.getRight().getType(true);
		if ((t1 == Type.STRING && t2 == Type.REAL) || (t1 == Type.REAL && t2 == Type.STRING)) {
			return true;
		}
		if ((t1 == Type.STRING && t2 == Type.INTEGER)) {
			if (t.getRight().isConstant()) {
				return true;
			}
		}
		if ((t2 == Type.STRING && t1 == Type.INTEGER)) {
			if (t.getLeft().isConstant()) {
				return true;
			}
		}
		return false;
	}

}
