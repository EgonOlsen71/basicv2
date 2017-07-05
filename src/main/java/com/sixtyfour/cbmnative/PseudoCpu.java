package com.sixtyfour.cbmnative;

import java.util.Arrays;
import java.util.Deque;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.sixtyfour.Logger;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.functions.Asc;
import com.sixtyfour.elements.functions.Chr;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.elements.functions.Len;
import com.sixtyfour.elements.functions.Str;
import com.sixtyfour.elements.functions.Val;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.system.Machine;

/**
 * @author EgonOlsen
 * 
 */
public class PseudoCpu {

	public final static int MEM_SIZE = 16384;
	public final static int A = 5;
	public final static int B = 6;
	public final static int X = 0;
	public final static int Y = 1;

	private Deque<Number> stack = new LinkedList<Number>();
	private Number[] regs = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }; // x,y,..,..,..,a,b,...
	private Machine machine;
	private int[] memory = null;
	private Map<String, Integer> memLocations = new HashMap<String, Integer>();
	private int memPointer = 0;
	private int varStart = 0;
	private int bufferPos = MEM_SIZE;
	private int bufferStart = MEM_SIZE;
	private Function chr = new Chr();
	private Function asc = new Asc();
	private Function str = new Str();
	private Function val = new Val();
	private Function len = new Len();

	/**
	 * @param code
	 */
	public void execute(Machine machine, List<String> code) {
		this.machine = machine;
		stack.clear();
		regs = new Number[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
		memory = new int[MEM_SIZE + MEM_SIZE / 2]; // normal string variable
													// memory + work buffer

		// Writing (string) constants into memory, extracted from actual code
		createStringConstants(code);

		// Writing (string) variables into memory
		createStringVariables();

		for (String line : code) {
			try {
				// System.out.println(regs[0]+"/"+regs[1]);
				String[] parts = split(line, " ");
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
					case "COS":
						cos(parts);
						break;
					case "LOG":
						log(parts);
						break;
					case "SQR":
						sqr(parts);
						break;
					case "INT":
						inty(parts);
						break;
					case "ABS":
						abs(parts);
						break;
					case "SGN":
						sgn(parts);
						break;
					case "TAN":
						tan(parts);
						break;
					case "ATN":
						atn(parts);
						break;
					case "EXP":
						exp(parts);
						break;
					case "RND":
						rnd(parts);
						break;
					case "SWAP":
						swap(parts);
						break;
					case "JSR":
						jsr(parts);
						break;
					case "CHGCTX":
						nop(parts);
						break;
					default:
						throw new RuntimeException("Unknown instruction: " + parts[0]);
					}
				}
			} catch (Exception e) {
				throw new RuntimeException("Error while executing: " + line, e);
			}
		}
	}

	private String[] split(String line, String delimiter) {
		int pos = line.indexOf(delimiter);
		if (pos != -1) {
			String[] parts = new String[2];
			parts[0] = line.substring(0, pos);
			parts[1] = line.substring(pos + delimiter.length());
			return parts;
		}
		return new String[] { line };
	}

	private void createStringConstants(List<String> code) {
		for (String line : code) {
			if (line.startsWith("MOV")) {
				String op = split(line, ",")[1];
				if (op.endsWith("{STRING}")) {
					if (op.startsWith("#")) {
						String val = op.substring(1, op.lastIndexOf("{"));
						if (!memLocations.containsKey("#" + val)) {
							System.arraycopy(toIntArray(val), 0, memory, memPointer + 1, val.length());
							memory[memPointer] = val.length();
							memLocations.put("#" + val, memPointer);
							memPointer += val.length() + 1;
							if (memPointer > MEM_SIZE) {
								throw new RuntimeException("Out of memory error: " + val + "/" + memPointer);
							}
						}
					}
				}
			}
		}
		varStart = memPointer;
	}

	private void createStringVariables() {
		Map<String, Variable> vars = machine.getVariables();
		for (Entry<String, Variable> entry : vars.entrySet()) {
			String name = entry.getKey();
			Variable var = entry.getValue();
			if (name.endsWith("$") && !name.equals("TI$")) {
				String val = (String) var.eval(machine);
				if (memLocations.containsKey(val)) {
					throw new RuntimeException("Variable defined twice: " + name);
				}
				storeString(name, val);
			}
		}
	}

	private void storeString(String name, String val) {
		storeString(name, val, 0);
	}

	private void storeString(String name, String val, int bufferPos) {
		if (bufferPos == 0) {
			if (memPointer + val.length() + 1 > MEM_SIZE) {
				throw new RuntimeException("Out of memory error: " + val + "/" + memPointer);
			}
		}

		System.arraycopy(toIntArray(val), 0, memory, bufferPos == 0 ? (memPointer + 1) : bufferPos + 1, val.length());
		memory[bufferPos == 0 ? memPointer : bufferPos] = val.length();
		if (name != null) {
			memLocations.put(name, memPointer);
		}
		if (bufferPos == 0) {
			memPointer += val.length() + 1;
		}
	}

	private int[] toIntArray(String val) {
		char[] chars = val.toCharArray();
		int[] ret = new int[chars.length];
		for (int i = 0; i < chars.length; i++) {
			ret[i] = chars[i];
		}
		return ret;
	}

	/**
	 * @return
	 */
	public Deque<Number> getStack() {
		return stack;
	}

	public String getStringFromStack() {
		Integer num = (Integer) stack.pop();
		return readString(num);
	}

	private String readString(Integer num) {
		return new String(memory, num + 1, memory[num]);
	}

	private void nop(String[] parts) {
		// Do nothing, just a stub
	}

	private void jsr(String[] parts) {
		if (parts[1].equals("CONCAT")) {
			concat(parts);
			return;
		}
		if (parts[1].equals("CHR")) {
			chr(parts);
			return;
		}
		if (parts[1].equals("ASC")) {
			asc(parts);
			return;
		}
		if (parts[1].equals("STR")) {
			str(parts);
			return;
		}
		if (parts[1].equals("VAL")) {
			val(parts);
			return;
		}
		if (parts[1].equals("LEN")) {
			len(parts);
			return;
		}
		throw new RuntimeException("Undefined call address: " + parts[1]);
	}

	private void concat(String[] parts) {
		int sp = regs[A].intValue();
		String s1 = readString(sp);
		String s2 = readString(regs[B].intValue());

		if (sp != bufferStart) {
			bufferStart = bufferPos;
			checkBufferSpace(s1);
			System.arraycopy(toIntArray(s1), 0, memory, bufferStart + 1, s1.length());
			bufferPos += s1.length() + 1;
			memory[bufferStart] = s1.length();
		}

		checkBufferSpace(s2);
		regs[5] = bufferStart;
		System.arraycopy(toIntArray(s2), 0, memory, bufferStart + 1 + memory[bufferStart], s2.length());
		memory[bufferStart] = memory[bufferStart] + s2.length();
		bufferPos += s2.length() + 1;

		// @todo: bufferStart (and -pos) have to be reset after assigning the
		// result to an actual variable.
	}

	private void asc(String[] parts) {
		runStringIntFunction(parts, asc, true);
	}

	private void val(String[] parts) {
		runStringIntFunction(parts, val, false);
	}
	
	private void len(String[] parts) {
		runStringIntFunction(parts, len, true);
	}

	private void runStringIntFunction(String[] parts, Function func, boolean inty) {
		String ch = readString(regs[B].intValue());
		func.setTerm(Parser.getTerm("\"" + ch + "\"", machine, false, false));
		Number num = ((Number) func.eval(machine));
		if (inty) {
			num = num.intValue();
		}
		regs[X] = num;
	}

	private void chr(String[] parts) {
		runIntStringFunction(parts, chr, true);
	}

	private void str(String[] parts) {
		runIntStringFunction(parts, str, false);
	}

	private void runIntStringFunction(String[] parts, Function func, boolean inty) {
		// These results will be stored in the actual variable memory, not in
		// the concat buffer. This will populate the buffer, but anyway...
		Number num = (Number) regs[Y];
		func.setTerm(Parser.getTerm(String.valueOf(inty ? num.intValue() : num.floatValue()), machine, false, false));
		String snum = func.eval(machine).toString();
		collectGarbage(snum.length());
		regs[A] = memPointer;
		memory[memPointer] = snum.length();
		System.arraycopy(toIntArray(snum), 0, memory, memPointer + 1, snum.length());
		memPointer += snum.length() + 1;
	}

	private void checkBufferSpace(String ss) {
		int max = bufferPos + ss.length();
		if (max >= memory.length) {
			throw new RuntimeException("Out of memory: " + ss);
		}
	}

	private void collectGarbage(int addSize) {
		if (memPointer + addSize >= MEM_SIZE) {
			System.out.println("Variable start is " + varStart);
			throw new RuntimeException("Not implemented!");
		}
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

	private void rnd(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return Math.random();
			}

			@Override
			public String op() {
				return "RND(_)";
			}
		});
	}

	private void cos(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return Math.cos(n2.doubleValue());
			}

			@Override
			public String op() {
				return "COS(_)";
			}
		});
	}

	private void tan(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return Math.tan(n2.doubleValue());
			}

			@Override
			public String op() {
				return "TAN(_)";
			}
		});
	}

	private void atn(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return Math.atan(n2.doubleValue());
			}

			@Override
			public String op() {
				return "ATN(_)";
			}
		});
	}

	private void exp(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return Math.exp(n2.doubleValue());
			}

			@Override
			public String op() {
				return "EXP(_)";
			}
		});
	}

	private void log(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return Math.log(n2.doubleValue());
			}

			@Override
			public String op() {
				return "LOG(_)";
			}
		});
	}

	private void sqr(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return Math.sqrt(n2.doubleValue());
			}

			@Override
			public String op() {
				return "SQR(_)";
			}
		});
	}

	private void sgn(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return Math.signum(n2.doubleValue());
			}

			@Override
			public String op() {
				return "SGN(_)";
			}
		});
	}

	private void inty(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return n2.intValue();
			}

			@Override
			public String op() {
				return "INT(_)";
			}
		});
	}

	private void abs(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return Math.abs(n2.doubleValue());
			}

			@Override
			public String op() {
				return "ABS(_)";
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
		String[] ops = split(parts[1], ",");
		String target = ops[0];
		String source = ops[1];
		int ti = getIndex(target);
		int si = getIndex(source);

		Number n1 = regs[si];
		Number n2 = regs[ti];

		regs[ti] = calc.calc(n2, n1);

		/*
		 * if (n1 instanceof Integer && n2 instanceof Integer) { regs[ti] =
		 * regs[ti].intValue(); }
		 */

		// System.out.println(target + "" + calc.op().replace("_", source));
		System.out.println((calc.op().contains("(") ? "" : n2) + "" + calc.op().replace("_", n1.toString()) + "=" + regs[ti]);
	}

	private void pop(String[] parts) {
		try {
			String target = parts[1];
			int ti = getIndex(target);
			regs[ti] = stack.pop();
		} catch (Throwable t) {
			Logger.log("Illegal opcode: " + Arrays.toString(parts), t);
			throw new RuntimeException(t);
		}
	}

	private void push(String[] parts) {
		String target = parts[1];
		int ti = getIndex(target);
		stack.push(regs[ti]);
	}

	private void swap(String[] parts) {
		String[] ops = split(parts[1], ",");
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
		String[] ops = split(parts[1], ",");
		String target = ops[0];
		String source = ops[1];
		int ti = 0;
		int si = 0;

		ti = getIndex(target);
		si = getIndex(source);
		Type type = Type.INTEGER;

		int pos = source.lastIndexOf("{");
		if (pos == -1) {
			regs[ti] = regs[si];
		} else {
			String ts = source.substring(pos + 1, source.lastIndexOf("}"));
			String val = source.substring(0, pos);
			type = Type.valueOf(ts);
			if (type == Type.STRING) {
				// a string...
				Integer addr = memLocations.get(val);
				if (addr == null) {
					throw new RuntimeException("Unknown string: " + val);
				}
				regs[ti] = addr;
			} else {
				// a number...
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
	}

	private int getIndex(String target) {
		int ti = -1;
		if (target.equals("X")) {
			ti = 0;
		} else if (target.equals("Y")) {
			ti = 1;
		} else if (target.equals("A")) {
			ti = 5;
		} else if (target.equals("B")) {
			ti = 6;
		}
		return ti;
	}

	private interface Calc {
		Number calc(Number n1, Number n2);

		String op();
	}
}
