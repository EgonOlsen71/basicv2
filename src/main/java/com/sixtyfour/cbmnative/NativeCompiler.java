package com.sixtyfour.cbmnative;

import java.util.ArrayList;
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
		LinkedList<String> stack = new LinkedList<String>();
		String left = null;
		String right = null;
		int stacked = 0;

		for (String exp : expr) {
			boolean isOp = exp.startsWith(":");
			boolean isBreak = exp.equals("_");

			if (!isBreak) {
				if (!isOp) {
					if (right == null) {
						code.add("MOV Y," + exp);
						right = exp;
					} else if (left == null) {
						code.add("MOV X," + exp);
						left = exp;
					}
				}
			}
			if (isOp && right != null && left == null) {
				code.add("PUSH Y");
				stacked++;
				right = null;
			}

			if (isBreak) {
				if (left == null) {
					code.add("POP X");
					left = "";
					stacked--;
				}
				if (right == null) {
					code.add("POP Y");
					right = "";
					stacked--;
				}

				String ex = stack.pop();
				String op = ex.replace(":", "");
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
					code.add("NOT Y");
					break;
				default:
					throw new RuntimeException("Unknown operator: " + op);
				}

				stacked++;
				code.add("PUSH Y");
				left = null;
				right = null;
			}

			if (isOp) {
				stack.push(exp);
			}
		}
		System.out.println("Elements remaining: " + stack.size() + "/" + stacked);

		if (!stack.isEmpty()) {
			// throw new
			// RuntimeException("Operator stack not empty, "+stack.size()+" elements remaining!");
		}
		return code;
	}

}
