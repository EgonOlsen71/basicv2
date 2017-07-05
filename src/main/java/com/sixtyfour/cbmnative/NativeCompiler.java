package com.sixtyfour.cbmnative;

import java.util.ArrayList;
import java.util.Deque;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Set;

import com.sixtyfour.parser.Term;
import com.sixtyfour.system.Machine;

/**
 * @author Foerster-H
 * 
 */
public class NativeCompiler {

	private final static Set<String> SINGLES = new HashSet<String>() {
		private static final long serialVersionUID = 1L;
		{
			this.add("!");
			this.add("SIN");
			this.add("COS");
			this.add("TAN");
			this.add("ATN");
			this.add("EXP");
			this.add("LOG");
			this.add("INT");
			this.add("ABS");
			this.add("SGN");
			this.add("SQR");
			this.add("RND");
			this.add("CHR");
			this.add("ASC");
			this.add("STR");
			this.add("VAL");
			this.add("LEN");
		}
	};

	private final static Set<String> STRING_OPERATORS = new HashSet<String>() {
		private static final long serialVersionUID = 1L;
		{
			this.add("CHR");
			this.add(".");
			this.add("STR");
		}
	};

	public List<String> compileToPseudoCode(Machine machine, Term term) {
		term = TermHelper.linearize(machine, term);
		String tr = null;
		String sr = null;
		boolean stringMode = false;
		int modeSwitchCnt = 0;

		List<String> code = new ArrayList<String>();
		List<String> expr = term.evalToExpression(machine);

		Deque<String> stack = new LinkedList<String>();
		Deque<String> yStack = new LinkedList<String>();
		boolean left = false;
		boolean right = false;
		Set<Integer> fromAbove = new HashSet<Integer>();

		for (String exp : expr) {
			boolean isOp = exp.startsWith(":");
			boolean isBreak = exp.equals("_");
			if (exp.contains("{")) {
				if (exp.contains("{STRING")) {
					modeSwitchCnt++;
					if (!stringMode) {
						if (modeSwitchCnt > 1 && !code.isEmpty()) {
							code.add("CHGCTX #1");
						}
					}
					stringMode = true;
					tr = "A";
					sr = "B";
				} else {
					modeSwitchCnt++;
					if (stringMode) {
						if (modeSwitchCnt > 1 && !code.isEmpty()) {
							code.add("CHGCTX #0");
						}
					}
					stringMode = false;
					tr = "X";
					sr = "Y";
				}
			}
			if (!isBreak) {
				if (!isOp) {
					if (!right) {
						code.add("MOV " + sr + "," + exp);
						right = true;
					} else if (!left) {
						code.add("MOV " + tr + "," + exp);
						left = true;
					}
				}
			}

			if (isOp && right && !left) {
				String lc = getLastEntry(code);
				if (lc.startsWith("MOV " + sr + "")) {
					yStack.push(lc);
					code.remove(code.size() - 1);
				} else {
					code.add("PUSH " + sr);
					yStack.push(null);
				}
				right = false;
			}

			if (isBreak) {
				String ex = stack.pop();
				String op = ex.replace(":", "");
				boolean isSingle = isSingle(op);

				if (!left && !isSingle) {
					if (code.size() >= 1 && getLastEntry(code).equals("PUSH " + tr)) {
						code.remove(code.size() - 1);
						yStack.pop();
					} else {
						if (code.size() >= 2 && code.get(code.size() - 2).equals("PUSH " + tr) && getLastEntry(code).startsWith("MOV " + sr)) {
							code.remove(code.size() - 2);
							yStack.pop();
						} else {
							popy(code, sr, tr);
							yStack.pop();
						}
					}
					left = true;
				}
				if (!right) {
					if (yStack.isEmpty()) {
						popy(code, tr, sr);
					} else {
						String v = yStack.pop();
						if (v == null) {
							popy(code, tr, sr);
						} else {
							code.add(v);
							fromAbove.add(code.size() - 1);
						}
					}
					right = true;
				}

				if (!code.isEmpty() && getLastEntry(code).startsWith("MOV " + sr) && !getLastEntry(code).equals("MOV " + sr + "," + tr) && !fromAbove.contains(code.size() - 1)) {
					// code.add("SWAP X,Y");
					// Swap register usage if needed
					code.add(code.size() - 1, "MOV " + sr + "," + tr);
					code.set(code.size() - 1, getLastEntry(code).replace("MOV " + sr + ",", "MOV " + tr + ","));
				} else {
					// Fix wrong register order for single operand function
					// calls
					if (isSingle && !code.isEmpty() && getLastEntry(code).startsWith("MOV " + tr)) {
						code.add(code.size() - 1, "PUSH " + getLastMoveTarget(code));
						code.set(code.size() - 1, getLastEntry(code).replace("MOV " + tr + ",", "MOV " + sr + ","));
						yStack.push(null);
					}
				}

				String regs = stringMode ? "A,B" : "X,Y";

				if (STRING_OPERATORS.contains(op)) {
					modeSwitchCnt++;
					if (!stringMode) {
						if (modeSwitchCnt > 1 && !code.isEmpty()) {
							code.add("CHGCTX #1");
						}
					}
					stringMode = true;
					tr = "A";
					sr = "B";
				} else {
					modeSwitchCnt++;
					if (stringMode) {
						if (modeSwitchCnt > 1 && !code.isEmpty()) {
							code.add("CHGCTX #0");
						}
					}
					stringMode = false;
					tr = "X";
					sr = "Y";
				}

				switch (op) {
				case "+":
					code.add("ADD " + regs);
					break;
				case "-":
					code.add("SUB " + regs);
					break;
				case "*":
					code.add("MUL " + regs);
					break;
				case "/":
					code.add("DIV " + regs);
					break;
				case "^":
					code.add("POW " + regs);
					break;
				case "|":
					code.add("OR " + regs);
					break;
				case "&":
					code.add("AND " + regs);
					break;
				case "!":
					code.add("NOT " + regs);
					break;
				case "SIN":
					code.add("SIN " + regs);
					break;
				case "COS":
					code.add("COS " + regs);
					break;
				case "LOG":
					code.add("LOG " + regs);
					break;
				case "SQR":
					code.add("SQR " + regs);
					break;
				case "INT":
					code.add("INT " + regs);
					break;
				case "ABS":
					code.add("ABS " + regs);
					break;
				case "SGN":
					code.add("SGN " + regs);
					break;
				case "TAN":
					code.add("TAN " + regs);
					break;
				case "ATN":
					code.add("ATN " + regs);
					break;
				case "EXP":
					code.add("EXP " + regs);
					break;
				case "RND":
					code.add("RND " + regs);
					break;
				case ".":
					code.add("JSR CONCAT");
					break;
				case "CHR":
					code.add("JSR CHR");
					break;
				case "STR":
					code.add("JSR STR");
					break;
				case "VAL":
					code.add("JSR VAL");
					break;
				case "ASC":
					code.add("JSR ASC");
					break;
				case "LEN":
					code.add("JSR LEN");
					break;
				default:
					throw new RuntimeException("Unknown operator: " + op);
				}
				code.add("PUSH " + tr);
				yStack.push(null);
				left = false;
				right = false;
			}

			if (isOp) {
				stack.push(exp);
			}
		}

		if (!stack.isEmpty()) {
			throw new RuntimeException("Operator stack not empty, " + stack.size() + " elements remaining!");
		}

		// End simple expressions properly
		if (!code.isEmpty() && !getLastEntry(code).equals("PUSH " + tr)) {
			String cl = getLastEntry(code);
			if (cl.startsWith("MOV " + sr)) {
				code.add("PUSH " + sr);
			} else {
				code.add("PUSH " + tr);
			}
		}

		return code;
	}

	private String getLastMoveTarget(List<String> code) {
		for (int i = code.size() - 2; i >= 0; i--) {
			if (code.get(i).startsWith("MOV ")) {
				String reg = code.get(i).substring(4, code.get(i).indexOf(",")).trim();
				if (reg.length() == 1) {
					return reg;
				}
			}
		}
		return null;
	}

	private String getLastEntry(List<String> code) {
		return code.get(code.size() - 1);
	}

	private void popy(List<String> code, String tr, String sr) {
		if (getLastEntry(code).equals("PUSH " + tr)) {
			code.set(code.size() - 1, "MOV " + sr + "," + tr);
		} else {
			if (getLastEntry(code).equals("PUSH " + sr)) {
				code.remove(code.size() - 1);
			} else {
				code.add("POP " + sr);
			}
		}
	}

	private boolean isSingle(String op) {
		return SINGLES.contains(op.toUpperCase(Locale.ENGLISH));
	}

}
