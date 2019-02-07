package com.sixtyfour.parser.optimize;

import java.util.Set;
import java.util.HashSet;

import com.sixtyfour.Logger;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Constant;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.Let;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Operator;
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

    private final static Set<Integer> POWERS_OF_TWO = new HashSet<Integer>() {
	private static final long serialVersionUID = 1L;
	{
	    this.add(2);
	    this.add(4);
	    this.add(8);
	    this.add(16);
	    this.add(32);
	    this.add(64);
	    this.add(128);
	    this.add(256);
	    this.add(512);
	}
    };

    /**
     * Propagates constants so that the constant folder can run more efficiently.
     * 
     * @param config the compiler configuration
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
			
			// This might over-optimize assigments which happen after the variable has been accessed for the first time,
			// So that it's actually not constant but either 0 or the next, then constant value. I can't detect this case,
			// but it should be very rare anyway. I've never encountered it except after a condition, which I do handle in Basic.java. 
			if (machine.isAssignedOnce(var)) {
			    if (var.isConstant()) {
				continue;
			    }
			    Term term = let.getTerm();
			    boolean termIsConstant = ConstantPropagator.checkForConstant(config, machine, term);
			    if (termIsConstant && !var.getUpperCaseName().equals("TI$")) {
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
     * @param config the compiler configuration
     * @param machine the machine
     * @param t the term to check
     * @return is t constant?
     */
    public static boolean checkForConstant(CompilerConfig config, Machine machine, Term t) {
	if (t == null) {
	    return false;
	}
	boolean[] isConstant = new boolean[1];
	isConstant[0] = true;
	return checkForConstant(config, machine, t, isConstant);
    }

    private static boolean checkForConstant(CompilerConfig config, Machine machine, Term t, boolean[] isConstant) {

	// Value up to which divisions by <value> will be converted into
	// *1/<value>
	double thresHold = 1000;

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

	// While we are at it: Optimize some divisions to multiplications by
	// 1/... or shifts...
	if (t.getOperator().isDivision()) {
	    double val = 0;
	    if (right.isConstant() && (val = ((Number) right.eval(machine)).doubleValue()) < thresHold
		    && val > -thresHold) {
		if (val != (int) val || !POWERS_OF_TWO.contains((int) val)) {
		    if (config.isFloatOptimizations()) {
			t.setOperator(new Operator('*'));
			right = new Constant<Float>((float) (1d / val));
			t.setRight(right);
		    }
		} else {
		    if (POWERS_OF_TWO.contains((int) val)) {
			right = new Constant<Integer>((int) val);
			t.setRight(right);
		    }
		}
	    }
	}

	// Convert 1+X to X+1...
	if (t.getOperator().isPlus() && t.getType(true) != Type.STRING) {
	    if (left.isConstant() && ((Number) left.eval(machine)).doubleValue() == 1d) {
		t.setLeft(right);
		t.setRight(left);
		left = t.getLeft();
		right = t.getRight();
	    }
	}

	// ... and some multiplications by shifts as well
	if (t.getOperator().isMultiplication()) {
	    double val = 0;
	    if (right.isConstant() && (val = ((Number) right.eval(machine)).doubleValue()) < thresHold
		    && val > -thresHold) {
		if (val == (int) val && POWERS_OF_TWO.contains((int) val)) {
		    right = new Constant<Integer>((int) val);
		    t.setRight(right);
		}
	    } else {
		if (left.isConstant() && (val = ((Number) left.eval(machine)).doubleValue()) < thresHold
			&& val > -thresHold) {
		    if (val == (int) val && POWERS_OF_TWO.contains((int) val)) {
			// Swap operators to keep the optimizer simpler.
			left = right;
			right = new Constant<Integer>((int) val);
			t.setLeft(left);
			t.setRight(right);
		    }
		}
	    }
	}

	// Works around the ROM routines a=16777217:print 10*a,a*10 bug...this
	// doesn't cover all cases, but at least the trivial ones.
	if (t.getOperator().isMultiplication()) {
	    if ((left.isConstant() && ((Number) left.eval(machine)).doubleValue() == 10)
		    || ((right.isConstant() && ((Number) right.eval(machine)).doubleValue() == 16777217))) {
		t.setLeft(right);
		t.setRight(left);
		left = t.getLeft();
		right = t.getRight();
	    }
	}

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
		    if (func.isDeterministic()) {
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
			if (func.isDeterministic()) {
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
