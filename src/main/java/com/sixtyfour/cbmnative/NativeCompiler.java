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

	private Set<String> SINGLES = new HashSet<String>() {
		private static final long serialVersionUID = 1L;

		{
			this.add("!");
			this.add("SIN");
			this.add("COS");
			this.add("TAN");
			this.add("LOG");
			this.add("INT");
			this.add("ABS");
			this.add("SGN");
			this.add("SQR");
			this.add("RND");
		}
	};

	public List<String> compileToPseudoCode(Machine machine, Term term) {
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

			if (!isBreak) {
				if (!isOp) {
					if (!right) {
						code.add("MOV Y," + exp);
						right = true;
					} else if (!left) {
						code.add("MOV X," + exp);
						left = true;
					}
				}
			}

			if (isOp && right && !left) {
				String lc = getLastEntry(code);
				if (lc.startsWith("MOV Y")) {
					yStack.push(lc);
					code.remove(code.size() - 1);
				} else {
					code.add("PUSH Y");
					yStack.push(null);
				}
				right = false;
			}

			if (isBreak) {
				String ex = stack.pop();
				String op = ex.replace(":", "");
				boolean isSingle = isSingle(op);

				if (!left && !isSingle) {
					if (code.size() >= 1 && getLastEntry(code).equals("PUSH X")) {
						code.remove(code.size() - 1);
						yStack.pop();
					} else {
						if (code.size() >= 2 && code.get(code.size() - 2).equals("PUSH X") && getLastEntry(code).startsWith("MOV Y")) {
							code.remove(code.size() - 2);
							yStack.pop();
						} else {
							code.add("POP X");
							yStack.pop();
						}
					}
					left = true;
				}
				if (!right) {
					if (yStack.isEmpty()) {
						popy(code);
					} else {
						String v = yStack.pop();
						if (v == null) {
							popy(code);
						} else {
							code.add(v);
							fromAbove.add(code.size() - 1);
						}
					}
					right = true;
				}

				if (!code.isEmpty() && getLastEntry(code).startsWith("MOV Y") && !getLastEntry(code).equals("MOV Y,X") && !fromAbove.contains(code.size() - 1)) {
					// code.add("SWAP X,Y");
					// Swap register usage is needed
					code.add(code.size() - 1, "MOV Y,X");
					code.set(code.size() - 1, getLastEntry(code).replace("MOV Y,", "MOV X,"));
				} else {
					// Fix wrong register order for single operand function calls
					if (isSingle && !code.isEmpty() && getLastEntry(code).startsWith("MOV X")) {
						code.add(code.size() - 1, "PUSH Y");
						code.set(code.size() - 1, getLastEntry(code).replace("MOV X,", "MOV Y,"));
					}
				}

				switch (op) {
				case "+":
					code.add("ADD X,Y");
					break;
				case "-":
					code.add("SUB X,Y");
					break;
				case "*":
					code.add("MUL X,Y");
					break;
				case "/":
					code.add("DIV X,Y");
					break;
				case "^":
					code.add("POW X,Y");
					break;
				case "|":
					code.add("OR X,Y");
					break;
				case "&":
					code.add("AND X,Y");
					break;
				case "!":
					code.add("NOT X,Y");
					break;
				case "SIN":
					code.add("SIN X,Y");
					break;
				case "COS":
					code.add("COS X,Y");
					break;
				case "LOG":
					code.add("LOG X,Y");
					break;
				case "SQR":
					code.add("SQR X,Y");
					break;
				case "INT":
					code.add("INT X,Y");
					break;
				case "ABS":
					code.add("ABS X,Y");
					break;
				case "SGN":
					code.add("SGN X,Y");
					break;
				case "TAN":
					code.add("TAN X,Y");
					break;
				case "RND":
					code.add("RND X,Y");
					break;
				default:
					throw new RuntimeException("Unknown operator: " + op);
				}
				code.add("PUSH X");
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
		if (!code.isEmpty() && !getLastEntry(code).equals("PUSH X")) {
			String cl = getLastEntry(code);
			if (cl.startsWith("MOV Y")) {
				code.add("PUSH Y");
			} else {
				code.add("PUSH X");
			}
		}

		return code;
	}

	private String getLastEntry(List<String> code) {
		return code.get(code.size() - 1);
	}

	private void popy(List<String> code) {
		if (getLastEntry(code).equals("PUSH X")) {
			code.set(code.size() - 1, "MOV Y,X");
		} else {
			code.add("POP Y");
		}
	}

	private boolean isSingle(String op) {
		return SINGLES.contains(op.toUpperCase(Locale.ENGLISH));
	}

}
