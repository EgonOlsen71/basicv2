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
			this.add("POS");
			this.add("TAB");
			this.add("SPC");
			this.add("LEN");
			this.add("PEEK");
			this.add("MID");
			this.add("PAR");
			this.add("LEFT");
			this.add("RIGHT");
		}
	};

	private final static Set<String> STRING_OPERATORS = new HashSet<String>() {
		private static final long serialVersionUID = 1L;
		{
			this.add("CHR");
			this.add(".");
			this.add("STR");
			this.add("MID");
			this.add("LEFT");
			this.add("RIGHT");
			this.add("TAB");
			this.add("SPC");
		}
	};

	public List<String> compileToPseudoCode(Machine machine, Term term) {
		term = TermHelper.linearize(machine, term);
		String tr = null;
		String sr = null;
		boolean pointerMode = false;
		int contextMode = 0;
		int modeSwitchCnt = 0;

		List<String> code = new ArrayList<String>();
		List<String> expr = term.evalToExpression(machine);

		Deque<String> stack = new LinkedList<String>();
		Deque<String> yStack = new LinkedList<String>();
		boolean withStrings=false;
		boolean left = false;
		boolean right = false;
		boolean isArrayAccess = false;
		Set<Integer> fromAbove = new HashSet<Integer>();
		char parReg = 'C';

		for (String exp : expr) {
			boolean isOp = exp.startsWith(":");
			boolean isBreak = exp.equals("_");
			isArrayAccess = false;
			if (exp.contains("{")) {
				if (exp.contains("{STRING") || exp.contains("[]")) {
					modeSwitchCnt++;
					if (!pointerMode) {
						if (modeSwitchCnt > 1 && !code.isEmpty() && exp.contains("{STRING") && contextMode != 1) {
							code.add("CHGCTX #1");
						}
					}
					contextMode = 1;
					pointerMode = true;
					if (!exp.contains("[]")) {
						tr = "A";
						sr = "B";
						withStrings=true;
					} else {
						tr = "C";
						sr = "C";
						isArrayAccess = true;
					}
				} else {
					modeSwitchCnt++;
					if (pointerMode) {
						if (modeSwitchCnt > 1 && !code.isEmpty() && contextMode != 0) {
							code.add("CHGCTX #0");
						}
					}
					contextMode = 0;
					pointerMode = false;
					tr = "X";
					sr = "Y";
				}
			}

			if (!isBreak) {
				if (!isOp) {
					if (!right || isArrayAccess) {
						code.add("MOV " + sr + "," + exp);
						right = true;
					} else if (!left) {
						code.add("MOV " + tr + "," + exp);
						left = true;
					} else {
						// throw new
						// RuntimeException("No free registers left to handle "+exp);
					}

				}
			}

			if (isOp && right && !left) {
				String lc = getLastEntry(code);
				if (lc.startsWith("MOV " + sr + "") && !lc.contains("[]")) {
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
							popy(code, sr, tr, sr, tr, false);
							yStack.pop();
						}
					}
					left = true;
				}

				if (!right) {

					String ntr = tr;
					String nsr = sr;

					if (STRING_OPERATORS.contains(op)) {
						if (!pointerMode) {
							if (modeSwitchCnt > 1 && !code.isEmpty()) {
								ntr = "A";
								nsr = "B";
								withStrings=true;
							}
						}
					} else {
						if (pointerMode) {
							if (modeSwitchCnt > 1 && !code.isEmpty()) {
								ntr = "X";
								nsr = "Y";
							}
						}
					}

					if (yStack.isEmpty()) {
						popy(code, tr, sr, ntr, nsr, true);
					} else {
						String v = yStack.pop();
						if (v == null) {
							popy(code, tr, sr, ntr, nsr, false);
						} else {
							code.add(v);
							fromAbove.add(code.size() - 1);
						}
					}
					right = true;
				}

				if (!tr.equals(sr)) {
					if (!code.isEmpty() && getLastEntry(code).startsWith("MOV " + sr) && !getLastEntry(code).equals("MOV " + sr + "," + tr) && !fromAbove.contains(code.size() - 1)) {
						// code.add("SWAP X,Y");
						// Swap register usage if needed
						code.add(code.size() - 1, "MOV " + sr + "," + tr);
						code.set(code.size() - 1, getLastEntry(code).replace("MOV " + sr + ",", "MOV " + tr + ","));
					} else {
						// Fix wrong register order for single operand function
						// calls
						if (isSingle && !code.isEmpty() && getLastEntry(code).startsWith("MOV " + tr)) {
							String lmt = getLastMoveTarget(code, 2);
							code.add(code.size() - 1, "PUSH " + lmt);
							code.set(code.size() - 1, getLastEntry(code).replace("MOV " + tr + ",", "MOV " + sr + ","));
							yStack.push(null);
						}
					}
				}

				if (STRING_OPERATORS.contains(op)) {
					modeSwitchCnt++;
					if (!pointerMode) {
						if (modeSwitchCnt > 1 && !code.isEmpty() && contextMode != 1) {
							code.add("CHGCTX #1");
						}
					}
					contextMode = 1;
					pointerMode = true;
					tr = "A";
					sr = "B";
					withStrings=true;
				} else {
					modeSwitchCnt++;
					if (pointerMode) {
						if (modeSwitchCnt > 1 && !code.isEmpty() && contextMode != 0) {
							code.add("CHGCTX #0");
						}
					}
					contextMode = 0;
					pointerMode = false;
					tr = "X";
					sr = "Y";
				}
				String regs = pointerMode ? "A,B" : "X,Y";

				boolean dontPush = false;

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
				case "PEEK":
					code.add("MOV " + regs.replace(",", ",(") + ")");
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
				case "TAB":
					code.add("JSR TAB");
					break;
				case "SPC":
					code.add("JSR SPC");
					break;
				case "POS":
					code.add("JSR POS");
					break;
				case "ARRAYACCESS":
					code.add("JSR ARRAYACCESS");
					break;
				case "MID":
					code.add("JSR MID");
					parReg = 'C';
					break;
				case "LEFT":
					code.add("JSR LEFT");
					parReg = 'C';
					break;
				case "RIGHT":
					code.add("JSR RIGHT");
					parReg = 'C';
					break;
				case "PAR":
					if (getLastEntry(code).startsWith("MOV " + sr)) {
						code.add("MOV " + (parReg++) + "," + sr);
					} else {
						code.add("MOV " + (parReg++) + "," + tr);
					}
					// yStack.push(null);
					dontPush = true;
					break;
				default:
					throw new RuntimeException("Unknown operator: " + op);
				}
				if (!dontPush) {
					code.add("PUSH " + tr);
					yStack.push(null);
				}
				dontPush = false;
				left = false;
				right = false;
			}

			if (isOp) {
				stack.push(exp);
			}

			// System.out.println(code.size() + ": " + this.getLastEntry(code) +
			// " / " + exp);
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

		if (withStrings) {
		  code.add(0, "JSR COMPACT");
		}
		
		return optimize(code);
	}

	private List<String> optimize(List<String> code) {
		List<String> ret = new ArrayList<String>();
		for (int i = 0; i < code.size() - 1; i++) {
			String l0 = code.get(i);
			String l1 = code.get(i + 1);
			String l2 = null;
			if (i < code.size() - 2) {
				l2 = code.get(i + 2);
			}

			if (l2 != null && l0.equals("PUSH X") && l1.startsWith("MOV C") && l1.contains("[]") && l2.equals("POP Y")) {
				ret.add(l1);
				i += 2;
				continue;
			}

			boolean rep = false;
			for (char c : new char[] { 'C', 'D' }) {
				if (l1.startsWith("MOV " + c + ",")) {
					if (l0.startsWith("MOV ")) {
						int pos = l0.indexOf(",");
						String r0 = l0.substring(4, pos).trim();
						String r1 = l1.substring(6).trim();
						if (r0.equals(r1)) {
							String right = l0.substring(pos + 1).trim();
							ret.add("MOV " + c + "," + right);
							rep = true;
							break;
						}
					}
				}
			}
			if (!rep) {
				ret.add(l0);
			} else {
				i++;
			}
		}
		ret.add(code.get(code.size() - 1));
		return ret;
	}

	private String getLastMoveTarget(List<String> code, int offset) {
		for (int i = code.size() - offset; i >= 0; i--) {
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
		if (code.size() > 0) {
			return code.get(code.size() - 1);
		}
		return null;
	}

	private void popy(List<String> code, String tr, String sr, String ntr, String nsr, boolean stackEmpty) {
		if (getLastEntry(code).equals("PUSH " + tr)) {
			code.set(code.size() - 1, "MOV " + sr + "," + tr);
		} else {
			if (getLastEntry(code).equals("PUSH " + nsr)) {
				code.remove(code.size() - 1);
			} else {
				if (!stackEmpty) {
					code.add("POP " + nsr);
				}
			}
		}
	}

	private boolean isSingle(String op) {
		return SINGLES.contains(op.toUpperCase(Locale.ENGLISH));
	}

}
