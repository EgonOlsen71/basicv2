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
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.TermBuilder;
import com.sixtyfour.parser.TermEnhancer;
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
	 * Tries to optimize terms used in print by detection cases like a$
	 * 
	 * @param line the term
	 * @return the possibly optimized version
	 */
	public static String optimizePrintTerm(String line) {
		line = TermEnhancer.removeWhiteSpace(line);
		StringBuilder sb = new StringBuilder();
		boolean inString = false;
		int brackets = 0;
		boolean modify = false;
		for (int i = 0; i < line.length(); i++) {
			char c = line.charAt(i);
			modify = false;
			if (c == '"') {
				inString = !inString;
			}
			if (!inString) {
				if (c == '(') {
					brackets++;
				}
				if (c == ')') {
					brackets--;
				}
				if (brackets == 0 && (c == '$' || c == '"' || c == ')') && i < line.length() - 2) {
					char nc = line.charAt(i + 1);
					char nnc = line.charAt(i + 2);
					if (nc == '+' && (nnc == '"' || Character.isAlphabetic(nnc))) {
						modify = true;
					}
				}
			}
			sb.append(c);
			if (modify) {
				sb.append(';');
				i++;
			}
		}
		return sb.toString();
	}

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
			// System.out.println(ret+"/"+ts+"/"+ret.getOperator()+"/"+ret.getOperator().isNop());
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

	/**
	 * Optimizes the index term for multidimensional arrays if possible. Don't call
	 * this method on other terms or it will break your term. This method operates
	 * on the string representation of the term. It would have been nicer to apply
	 * these optimizations either on the term tree or while creating the term...but
	 * anyway...
	 * 
	 * @param term the index term
	 * @return the optimized term
	 */
	public static String optimizeLinearIndexTerm(String term) {
		int pos = 0;
		do {
			int lenTerm = term.length();
			pos = term.indexOf("int(", pos);
			if (pos != -1) {
				int sp = pos + 4;
				int ep = term.indexOf(")", sp);
				if (ep != -1) {
					String ns = term.substring(sp, ep);
					if (Parser.isInteger(ns) && ep < term.length() - 2 && term.charAt(ep + 1) == '*') {
						// Actually, this could be extended to handle floating point constants as well,
						// but
						// who uses those into constant array indices anyway?
						int fv = Integer.parseInt(ns);
						int sp1 = term.indexOf("+", ep);
						if (sp1 != -1) {
							ns = term.substring(ep + 2, sp1);
						} else {
							ns = term.substring(ep + 2);
						}
						ns = ns.substring(1, ns.length() - 1);
						if (Parser.isInteger(ns)) {
							int sv = Integer.parseInt(ns);
							int tv = fv * sv;
							if (tv == 0) {
								term = term.substring(0, pos > 0 ? pos - 1 : pos)
										+ (sp1 != -1 ? term.substring(sp1) : "");
							} else {
								term = term.substring(0, pos) + tv + (sp1 != -1 ? term.substring(sp1) : "");
							}
							pos = pos - (lenTerm - term.length());
						}
					} else {
						pos = ep;
					}
				} else {
					pos = sp;
				}
			}
		} while (pos != -1);
		return term;
	}

}
