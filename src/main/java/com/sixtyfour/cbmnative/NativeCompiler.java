package com.sixtyfour.cbmnative;

import java.util.ArrayList;
import java.util.Deque;
import java.util.LinkedList;
import java.util.List;

import com.sixtyfour.parser.Term;
import com.sixtyfour.system.Machine;

/**
 * @author Foerster-H
 * 
 */
public class NativeCompiler {

	public List<String> compileToPseudoCode(Machine machine, Term term) {
		List<String> code = new ArrayList<String>();
		List<String> expr = term.evalToExpression(machine);
		Deque<String> stack = new LinkedList<String>();
		Deque<String> yStack = new LinkedList<String>();
		boolean left = false;
		boolean right = false;

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
				String lc = code.get(code.size() - 1);
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
					if (code.size() >= 1 && code.get(code.size() - 1).equals("PUSH X")) {
						code.remove(code.size() - 1);
						yStack.pop();
					} else {
						if (code.size() >= 2 && code.get(code.size() - 2).equals("PUSH X") && code.get(code.size() - 1).startsWith("MOV Y")) {
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
						code.add("POP Y");
					} else {
						String v = yStack.pop();
						if (v == null) {
							code.add("POP Y");
						} else {
							code.add(v);
						}
					}
					right = true;
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
		return code;
	}

	private boolean isSingle(String op) {
		return op.equals("!");
	}

}
