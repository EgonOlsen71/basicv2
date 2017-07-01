package com.sixtyfour.cbmnative;

import java.util.Deque;
import java.util.LinkedList;
import java.util.List;

import com.sixtyfour.elements.Type;
import com.sixtyfour.system.Machine;

/**
 * @author EgonOlsen
 * 
 */
public class PseudoCpu {
	private Deque<Number> stack = new LinkedList<Number>();
	private Number[] regs = { 0, 0 }; // x,y
	private Machine machine;

	/**
	 * @param code
	 */
	public void execute(Machine machine, List<String> code) {
		this.machine = machine;
		stack.clear();
		for (String line : code) {
			//System.out.println(regs[0]+"/"+regs[1]);
			String[] parts = line.split(" ");
			if (parts.length > 0) {
				switch (parts[0]) {
				case "MOV":
					mov(parts);
					break;
				case "PUSH":
					push(parts);
					break;
				case "POP":
					pop(parts);
					break;
				case "MUL":
					mul(parts);
					break;
				case "DIV":
					div(parts);
					break;
				case "SUB":
					sub(parts);
					break;
				case "ADD":
					add(parts);
					break;
				case "AND":
					and(parts);
					break;
				case "NOT":
					not(parts);
					break;
				case "OR":
					or(parts);
					break;
				case "POW":
					pow(parts);
					break;
				case "SIN":
					sin(parts);
					break;
				case "SWAP":
					swap(parts);
					break;
				default:
					throw new RuntimeException("Unknown instruction: " + parts[0]);
				}
			}
		}
	}

	/**
	 * @return
	 */
	public Deque<Number> getStack() {
		return stack;
	}

	private void sin(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return Math.sin(n2.doubleValue());
			}

			@Override
			public String op() {
				return "SIN(_)";
			}
		});
	}

	private void not(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return ~n2.intValue();
			}

			@Override
			public String op() {
				return "!_";
			}
		});
	}

	private void or(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return n1.intValue() | n2.intValue();
			}

			@Override
			public String op() {
				return "|_";
			}
		});
	}

	private void and(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return n1.intValue() & n2.intValue();
			}

			@Override
			public String op() {
				return "&_";
			}
		});
	}

	private void add(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return n1.floatValue() + n2.floatValue();
			}

			@Override
			public String op() {
				return "+_";
			}
		});
	}

	private void pow(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return Math.pow(n1.floatValue(), n2.floatValue());
			}

			@Override
			public String op() {
				return "^_";
			}
		});
	}

	private void sub(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return n1.floatValue() - n2.floatValue();
			}

			@Override
			public String op() {
				return "-_";
			}
		});
	}

	private void div(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return n1.floatValue() / n2.floatValue();
			}

			@Override
			public String op() {
				return "/_";
			}
		});
	}

	private void mul(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return n1.floatValue() * n2.floatValue();
			}

			@Override
			public String op() {
				return "*_";
			}
		});
	}

	private void calc(String[] parts, Calc calc) {
		String[] ops = parts[1].split(",");
		String target = ops[0];
		String source = ops[1];
		int ti = 0;
		int si = 0;
		ti = getIndex(target);
		si = getIndex(source);

		Number n1 = regs[si];
		Number n2 = regs[ti];

		regs[ti] = calc.calc(n2, n1);

		/*
		if (n1 instanceof Integer && n2 instanceof Integer) {
			regs[ti] = regs[ti].intValue();
		}
		*/

		System.out.println(target + "" + calc.op().replace("_", source));
		System.out.println(((n2 == n1) ? "" : n2) + "" + calc.op().replace("_", n1.toString()) + "=" + regs[ti]);
	}

	private void pop(String[] parts) {
		String target = parts[1];
		int ti = getIndex(target);
		regs[ti] = stack.pop();
	}

	private void push(String[] parts) {
		String target = parts[1];
		int ti = getIndex(target);
		stack.push(regs[ti]);
	}

	private void swap(String[] parts) {
		String[] ops = parts[1].split(",");
		String target = ops[0];
		String source = ops[1];
		int ti = 0;
		int si = 0;

		ti = getIndex(target);
		si = getIndex(source);
		Number rti = regs[ti];
		regs[ti] = regs[si];
		regs[si] = rti;
	}

	private void mov(String[] parts) {
		String[] ops = parts[1].split(",");
		String target = ops[0];
		String source = ops[1];
		int ti = 0;
		int si = 0;
		Type type = Type.INTEGER;

		ti = getIndex(target);
		si = getIndex(source);

		int pos = source.indexOf("{");
		if (pos == -1) {
			regs[ti] = regs[si];
		} else {
			String ts = source.substring(pos + 1, source.indexOf("}"));
			String val = source.substring(0, pos);
			type = Type.valueOf(ts);

			if (val.startsWith("#")) {
				Number n = Float.valueOf(val.replace("#", ""));
				if (type == Type.INTEGER) {
					n = n.intValue();
				}
				regs[ti] = n;
			} else {
				Number n = (Number) machine.getVariableUpperCase(val).eval(machine);
				regs[ti] = n;
			}
		}
	}

	private int getIndex(String target) {
		int ti = 0;
		if (target.equals("X")) {
			ti = 0;
		} else if (target.equals("Y")) {
			ti = 1;
		}
		return ti;
	}

	private interface Calc {
		Number calc(Number n1, Number n2);

		String op();
	}
}
