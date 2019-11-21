package com.sixtyfour.parser.optimize;

import java.util.Map;

import com.sixtyfour.Basic;
import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.PCode;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Constant;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.If;
import com.sixtyfour.elements.commands.Rem;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Line;
import com.sixtyfour.parser.Operator;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.TermBuilder;
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
	 * Optimizes the term by removing redundant entries that made it into the tree
	 * during its creation.
	 * 
	 * @param finalTerm the final term
	 * @param machine   the machine
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
	 * Evaluates conditional blocks and optimizes their executing if are are either
	 * always true or always false.
	 * 
	 * @param config  the compiler configuration
	 * @param machine the machine
	 * @param basic   the Basic instance
	 */
	public static void handleConstantConditions(CompilerConfig config, Machine machine, Basic basic) {
		if (config.isConstantFolding()) {
			PCode pCode = basic.getPCode();
			for (Integer lineNumber : pCode.getLineNumbers()) {
				Line line = pCode.getLines().get(lineNumber);
				for (int i = 0; i < line.getCommands().size(); i++) {
					Command cmd = line.getCommands().get(i);
					if (cmd.isConditional()) {
						boolean allConst = true;
						for (Term t : cmd.getAllTerms()) {
							allConst &= ConstantPropagator.checkForConstant(config, machine, t);
							if (!allConst) {
								break;
							}
						}
						if (allConst) {
							float res = VarUtils.getFloat(((If) cmd).getLogicTerm().eval(machine));
							if (res == 0) {
								Logger.log("Removed conditional block at line " + lineNumber);
								for (int p = 0; p < line.getCommands().size(); p++) {
									line.getCommands().set(p, new Rem());
								}
								break;
							} else {
								Logger.log("Always execute conditional block at line " + lineNumber);
								line.getCommands().remove(i);
								i--;
							}
						}
					}
				}
			}
		}
	}

	/**
	 * Optimizes a term.
	 * 
	 * @param machine the machine
	 * @param ret     the term to optimize
	 * @param termMap the mapping between placeholders and actual terms
	 * @param builder the term builder instance
	 * @return the optimized term
	 */
	public static Term optimizeTerm(CompilerConfig config, Machine machine, Term ret, Map<String, Term> termMap,
			TermBuilder builder) {
		if (ret.getType(true) == Type.STRING) {
			return ret;
		}

		if (ret.getOperator().isDelimiter()) {
			return ret;
		}
		if (ret.getLeft() instanceof Constant && ret.getOperator().isNop()) {
			return ret;
		}
		boolean isConst = ConstantPropagator.checkForConstant(config, machine, ret);
		if (isConst) {
			// System.out.println("To replace: " + ret);
			String ts = ret.eval(machine).toString();
			//System.out.println(ret+"/"+ts+"/"+ret.getOperator()+"/"+ret.getOperator().isNop());
			if (ts.toLowerCase().contains("e")) {
				return ret;
			}
			if (ts.endsWith(".0")) {
				// If it can be an integer...then is should be one
				ts = ts.substring(0, ts.length() - 2);
			}
			// System.out.println("TS: "+ts);
			Term t = new Term(ts, termMap);
			t = builder.build(config, t, termMap, machine);
			if (!t.isComplete()) {
				t.setOperator(Operator.NOP);
				t.setRight(new Constant<Integer>(0));
			}
			ret = t;
			// System.out.println("Replaced by: " + ret);
		}
		return ret;
	}

}
