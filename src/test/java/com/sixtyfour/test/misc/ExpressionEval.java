package com.sixtyfour.test.misc;

import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Map;
import java.util.Set;

/**
 * @author EgonOlsen
 *
 */
public class ExpressionEval {

	public static void main(String[] args) {
		float a = 23, b = 12, e = 11.23f, r = 2.3f, t = 44;
		float res = (float) (a * (b + -e / -(r + Math.pow(t, 2f)) * -11.2f) + (-12 / t + 3 * 2.1) * e)
				+ (float) (e / (r + Math.sin(t) * Math.sin(a + Math.cos(b + r)) / e) * Math.pow(11.2f, 1.3));
		// float res = (float) (e / (r+2) * 11.2f);
		// float res = a + b * 12.3f + r;
		// float res = a * b + (e*2);
		// float res = (float) Math.sin(t) * (float) Math.sin(a + Math.sin(b +
		// r)) / e;
		res=(float)(a*(b+e/-(r+t)*11.6)+(12/t+3*2.8)*e+(e/(r+Math.sin(t)*Math.sin(a+Math.cos(b+r))/e)*11));
		System.out.println(res);
		//String exp = "a*(b+-e/-(r+t^2)*-11.2)+(-12/t+3*2.1)*e+(e / (r+sin(t)*sin(a+cos(b+r))/e) * 11.2^1.3)";
		 String exp="a*(b+e/-(r+t)*11.6)+(12/t+3*2.8)*e+(e/(r+sin(t)*sin(a+cos(b+r))/e)*11)";
		// String exp = "e / (r+2) * 11.2";
		// String exp = "a+b*12.3+r";
		// String exp = "-a * -(b+-2)";
		// String exp = "sin(t)*sin(a+sin(b+r))/e";
		Map<String, Float> vals = new HashMap<>();
		vals.put("a", a);
		vals.put("b", b);
		vals.put("e", e);
		vals.put("r", r);
		vals.put("t", t);
		float res2 = eval(exp, vals);
		System.out.println(res2);
	}

	private static float eval(String exp, Map<String, Float> vals) {
		LinkedList<String> stack = new LinkedList<>();
		int wm = 1;
		int weight = 0;
		float neg = 1;
		boolean lastOp = true;
		String num = "";
		Set<String> funcs = new HashSet<String>() {
			private static final long serialVersionUID = 1L;
			{
				this.add("sin");
				this.add("cos");
				this.add("tan");
			}
		};

		exp = exp.replace(" ", "").toLowerCase();

		for (int i = 0; i < exp.length(); i++) {
			char c = exp.charAt(i);
			if (c >= 'a' && c <= 'z') {
				// Variable or function call
				String fn = null;
				if (i + 3 < exp.length()) {
					fn = exp.substring(i, i + 3);
				}
				if (fn != null && funcs.contains(fn)) {
					weight = wm + 3;
					stack.push(fn);
					stack.push(Integer.toString(weight));
					stack.push("0");
					lastOp = false;
					i += 2;
				} else {
					String cs = Character.toString(c);
					if (vals.containsKey(cs)) {
						num = vals.get(cs).toString();
					} else {
						throw new RuntimeException("Unknown variable: " + c);
					}
				}
			} else if (c == '+' || c == '-' || c == '*' || c == '/' || c == '^') {
				// Operator
				weight = wm;
				if (c == '*' || c == '/') {
					weight = wm + 2;
				} else if (c == '^') {
					weight = wm + 3;
				}

				boolean suffix = false;
				if (!num.isEmpty()) {
					stack.push((neg == -1 ? "-" : "") + num);
					neg = 1;
				} else {
					if (c == '-' && lastOp) {
						neg *= -1;
						suffix = true;
					}
				}
				if (!suffix) {
					calc(stack, weight);
					String t = stack.pop();
					stack.push(Character.toString(c));
					stack.push(Integer.toString(weight));
					stack.push(t);
					lastOp = true;
					num = "";
				}
			} else if (c == '(' || c == ')') {
				// Brackets
				if (!num.isEmpty()) {
					stack.push((neg == -1 ? "-" : "") + num);
					num = "";
					neg = 1;
				}
				if (c == '(') {
					if (neg==-1) {
						neg=1;
						weight = wm + 2;
						stack.push("*");
						stack.push(Integer.toString(weight));
						stack.push("-1");
					}
					wm += 10;
					lastOp = true;
				}
				if (c == ')') {
					wm -= 10;
					lastOp = false;
				}
			} else {
				// Number
				if (Character.isDigit(c) || c == '.') {
					num = num + c;
					lastOp = false;
				} else {
					throw new RuntimeException("Syntax error in " + exp + " at " + i + ": " + c + " found!");
				}
			}
		}

		if (!num.isEmpty()) {
			stack.push((neg == -1 ? "-" : "") + num);
			num = "";
		}

		calc(stack, -1);

		return Float.parseFloat(stack.pop());
	}

	private static void calc(LinkedList<String> stack, int w) {
		boolean changed = false;
		do {
			changed = false;
			if (stack.size() > 2) {
				int weight = w;
				if (weight != -1) {
					weight = Integer.parseInt(stack.get(2));
				}
				if (w <= weight) {
					System.out.println("Before: " + Arrays.toString(stack.toArray()) + "/" + weight + "/" + w + "/" + stack.size());
					float n1 = Float.parseFloat(stack.pop());
					float n2 = Float.parseFloat(stack.pop());
					Integer.parseInt(stack.pop());
					String op = stack.pop();
					if (op.equals("+")) {
						n1 = n1 + n2;
					}
					if (op.equals("-")) {
						n1 = n2 - n1;
					}
					if (op.equals("*")) {
						n1 = n2 * n1;
					}
					if (op.equals("/")) {
						n1 = n2 / n1;
					}
					if (op.equals("^")) {
						n1 = (float) Math.pow(n2, n1);
					}
					if (op.equals("sin")) {
						n1 = (float) Math.sin(n1 + n2);
					}
					if (op.equals("cos")) {
						n1 = (float) Math.cos(n1 + n2);
					}
					if (op.equals("tan")) {
						n1 = (float) Math.tan(n1 + n2);
					}
					stack.push(String.valueOf(n1));
					System.out.println("After: " + Arrays.toString(stack.toArray()) + "/" + weight + "/" + w + "/" + stack.size());
					changed = true;
				}
			}
		} while (changed);
	}

}
