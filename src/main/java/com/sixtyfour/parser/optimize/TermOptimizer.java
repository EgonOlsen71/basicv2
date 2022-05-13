package com.sixtyfour.parser.optimize;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import com.sixtyfour.Basic;
import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.PCode;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Constant;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.If;
import com.sixtyfour.elements.commands.Rem;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.elements.functions.Peek;
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
	
	
	private final static Set<Double> ADDED_POWERS_OF_TWO = new HashSet<Double>() {
		private static final long serialVersionUID = 1L;
		{
			this.add(3d);
			this.add(5d);
			this.add(6d);
			this.add(9d);
			this.add(10d);
			this.add(12d);
			this.add(17d);
			this.add(18d);
			this.add(20d);
			this.add(24d);
			this.add(33d);
			this.add(34d);
			this.add(36d);
			this.add(40d);
			this.add(48d);
			this.add(65d);
			this.add(66d);
			this.add(68d);
			this.add(72d);
			this.add(80d);
			this.add(96d);
			this.add(129d);
			this.add(130d);
			this.add(132d);
			this.add(136d);
			this.add(144d);
			this.add(160d);
			this.add(192d);
			this.add(257d);
			this.add(258d);
			this.add(260d);
			this.add(264d);
			this.add(272d);
			this.add(288d);
			this.add(320d);
		}
	};
	

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
							double res = VarUtils.getDouble(((If) cmd).getLogicTerm().eval(machine));
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
	 * Optimizes the calculations in a term if possible.
	 * 
	 * @param config
	 * @param machine
	 * @param t
	 */
	public static void optimizeCalculations(CompilerConfig config, Machine machine, Term t) {
		if (t.getType(true) == Type.STRING) {
			return;
		}

		double thresHold = 1000;

		Atom left = t.getLeft();
		Atom right = t.getRight();

		// System.out.println(t.getInitial() + "/" + left.isTerm() + "/" +
		// right.isTerm());

		// Replace i+i by 2*i. While the former is faster in BASIC, the latter is faster
		// here, because it will be replaced by a shift operation later on.
		if (t.getOperator().isPlus()) {
			if (right instanceof Variable && right == left) {
				t.setOperator(new Operator("*"));
				t.setLeft(new Constant<Integer>(2));
				left = t.getLeft();
			}
		}

		// While we are at it: Optimize some divisions to multiplications by
		// 1/... or shifts...
		if (t.getOperator().isDivision()) {
			double val = 0;
			if (right.isConstant() && (val = ((Number) right.eval(machine)).doubleValue()) < thresHold
					&& val > -thresHold) {
				if (val != (int) val || !POWERS_OF_TWO.contains((int) val)) {
					// Disabled for now.
					if (config.isFloatOptimizations()) {
						t.setOperator(new Operator('*'));
						right = new Constant<Double>((double) (1d / val));
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

		// Convert 1+X to X+1...
		if (t.getOperator().isPlus() && t.getType(true) != Type.STRING) {
			if (left.isConstant() && ((Number) left.eval(machine)).doubleValue() == 1d) {
				t.setLeft(right);
				t.setRight(left);
				left = t.getLeft();
				right = t.getRight();
			}
		}

		// Swap (...)*40 to 40*(...) to allow for a special optimization later in...
		// Actually, it's faster to do this anyway for some combinations...but sadly not
		// for others, so it's impossible to decide which
		// variant is generally better...so we leave it untouched...
		if (t.getOperator().isMultiplication()) {
			if (right.isConstant() && ADDED_POWERS_OF_TWO.contains(((Number) right.eval(machine)).doubleValue())) {
				t.setLeft(right);
				t.setRight(left);
				left = t.getLeft();
				right = t.getRight();
			}
		}

		// Swap <CONST> and/or PEEK(X) for later PEEKBYTEAND/OR optimization
		if (t.getOperator().isAnd() || t.getOperator().isOr()) {
			if (left.isConstant() && right.isTerm()) {
				Term tr = (Term) right;
				if (tr.getLeft() instanceof Peek) {
					t.setLeft(right);
					t.setRight(left);
					left = t.getLeft();
					right = t.getRight();
				}
			}
		}

		// Replace x*1 or 1*x by simply x...
		if (t.getOperator().isMultiplication()) {
			if (right.isConstant() && ((Number) right.eval(machine)).doubleValue() == 1) {
				t.setOperator(Operator.NOP);
			} else {
				if (left.isConstant() && ((Number) left.eval(machine)).doubleValue() == 1) {
					t.setLeft(right);
					t.setRight(left);
					left = t.getLeft();
					right = t.getRight();
					t.setOperator(Operator.NOP);
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

		if (left.isTerm()) {
			optimizeCalculations(config, machine, (Term) left);
		} else if (left instanceof Function) {
			Function func = (Function) left;
			if (!func.isExcluded()) {
				optimizeCalculations(config, machine, func.getTerm());
			}
		}
		if (right.isTerm()) {
			optimizeCalculations(config, machine, (Term) right);

		} else if (right instanceof Function) {
			Function func = (Function) right;
			if (!func.isExcluded()) {
				optimizeCalculations(config, machine, func.getTerm());
			}
		}
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
