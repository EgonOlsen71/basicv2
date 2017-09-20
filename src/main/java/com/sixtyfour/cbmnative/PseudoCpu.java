package com.sixtyfour.cbmnative;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Deque;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import com.sixtyfour.Logger;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.functions.Asc;
import com.sixtyfour.elements.functions.Chr;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.elements.functions.Left;
import com.sixtyfour.elements.functions.Len;
import com.sixtyfour.elements.functions.Mid;
import com.sixtyfour.elements.functions.Pos;
import com.sixtyfour.elements.functions.Right;
import com.sixtyfour.elements.functions.Spc;
import com.sixtyfour.elements.functions.Str;
import com.sixtyfour.elements.functions.Tab;
import com.sixtyfour.elements.functions.Val;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * @author EgonOlsen
 * 
 */
public class PseudoCpu {

	public final static int MEM_SIZE = 16384;
	public final static int A = 5; // pointer / int
	public final static int B = 6; // pointer / int
	public final static int C = 7; // parameter / float
	public final static int D = 8; // parameter / float
	public final static int E = 9; // parameter / float / unsused
	public final static int F = 10; // parameter / float / unsused
	public final static int G = 11; // pointer/int/array access
	public final static int X = 0; // float
	public final static int Y = 1; // float

	private Deque<Number> stack = new LinkedList<Number>();
	private Number[] regs = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }; // x,y,..,..,..,a,b,...
	private Machine machine;
	private boolean zeroFlag = false;
	private boolean halt = false;
	private int[] memory = null;
	private int addr = 0;
	private Map<String, Integer> memLocations = new HashMap<String, Integer>();
	private List<String> stringNames = new ArrayList<String>();
	private int memPointer = 0;
	private int stringStart = 0;
	private int bufferPos = MEM_SIZE;
	private int bufferStart = MEM_SIZE;
	private Function chr = new Chr();
	private Function asc = new Asc();
	private Function str = new Str();
	private Function val = new Val();
	private Function len = new Len();
	private Function mid = new Mid();
	private Function left = new Left();
	private Function right = new Right();
	private Function pos = new Pos();
	private Function tab = new Tab();
	private Function spc = new Spc();
	private Map<String, Long> label2line = new HashMap<>();

	/**
	 * @param code
	 */
	public void execute(Machine machine, List<String> code) {
		Tab.setLimitedToPrint(false);
		Spc.setLimitedToPrint(false);
		this.machine = machine;
		stack.clear();
		label2line.clear();

		halt = false;
		regs = new Number[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
		memory = new int[MEM_SIZE + MEM_SIZE / 2]; // normal string variable
		// memory + work buffer

		// Copy machine's memory content over to this cpu's
		System.arraycopy(machine.getRam(), 0, memory, 0, memory.length);

		// Writing (string) constants into memory, extracted from actual code
		createStringConstants(code);

		// Writing arrays into memory
		createArrays();

		// Writing (string) variables into memory
		createStringVariables();

		long cnt = 0;
		for (String line : code) {
			String[] parts = line.split(" ");
			if (parts.length > 0) {
				if (parts[0].endsWith(":")) {
					label2line.put(parts[0], cnt);
				}
			}
			cnt++;
		}

		addr = 0;
		do {
			String line = code.get(addr++);
			try {
				String[] parts = split(line, " ");
				if (parts.length > 0) {

					if (parts[0].endsWith(":") && Character.isDigit(parts[0].charAt(parts[0].length() - 2))) {
						// Just a line number label...skip!
						continue;
					}

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
					case "JMP":
						jmp(parts);
						break;
					case "JE":
						je(parts);
						break;
					case "RTS":
						rts(parts);
						break;
					case "CHGCTX":
						nop(parts);
						break;
					case "EQ":
						equal(parts);
						break;
					case "CMP":
						compare(parts);
						break;
					case "NEQ":
						notEqual(parts);
						break;
					case "GT":
						greaterThan(parts);
						break;
					case "LT":
						lowerThan(parts);
						break;
					case "GTEQ":
						greaterThanOrEqual(parts);
						break;
					case "LTEQ":
						lowerThanOrEqual(parts);
						break;
					default:
						throw new RuntimeException("Unknown instruction: " + parts[0]);
					}
				}
			} catch (Exception e) {
				throw new RuntimeException("Error while executing: " + line, e);
			}
		} while (!halt && addr < code.size());
	}

	public void compactMemory() {
		this.collectGarbage();
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
	}

	private void createStringVariables() {
		stringStart = memPointer;
		Map<String, Variable> vars = machine.getVariables();
		for (Entry<String, Variable> entry : vars.entrySet()) {
			String name = entry.getKey();
			Variable var = entry.getValue();
			if (name.endsWith("$") && !name.equals("TI$")) {
				String val = (String) var.eval(machine);
				if (memLocations.containsKey(val)) {
					throw new RuntimeException("Variable defined twice: " + name);
				}
				stringNames.add(name);
				storeString(name, val);
			}
		}
	}

	private void createArrays() {
		Map<String, Variable> vars = machine.getVariables();
		for (Entry<String, Variable> entry : vars.entrySet()) {
			String name = entry.getKey();
			Variable var = entry.getValue();
			if (var.isArray()) {
				@SuppressWarnings("unchecked")
				List<Object> vals = (List<Object>) var.getInternalValue();

				int[] mems = new int[vals.size()];
				int pos = 0;
				for (Object val : vals) {
					if (val instanceof String) {
						mems[pos++] = memPointer;
						storeString(null, val.toString());
					}
				}

				memLocations.put(name, memPointer);
				boolean flagged = false;
				pos = 0;
				for (Object val : vals) {
					if (val instanceof Float) {
						if (!flagged) {
							memory[memPointer++] = 1; // Flags a Float array
							memory[memPointer++] = vals.size();
							flagged = true;
						}
						memory[memPointer++] = Float.floatToIntBits((Float) val);
					} else if (val instanceof Integer) {
						if (!flagged) {
							memory[memPointer++] = 0; // Flags an Integer array
							memory[memPointer++] = vals.size();
							flagged = true;
						}
						memory[memPointer++] = (Integer) val;
					} else {
						if (!flagged) {
							memory[memPointer++] = 2; // Flags a String array
							memory[memPointer++] = vals.size();
							flagged = true;
							stringNames.add(name);
						}
						int addr = mems[pos++];
						memory[memPointer++] = addr;
					}
				}
				if (memLocations.containsKey(val)) {
					throw new RuntimeException("Variable defined twice: " + name);
				}
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

	public Object getVariableValue(String name) {
		name = name.toUpperCase(Locale.ENGLISH);
		if (name.contains("$")) {
			return readString(memLocations.get(name));
		}
		return this.machine.getVariable(name).eval(machine);
	}

	public Object getVariableValue(String name, int... pos) {
		name = name.toUpperCase(Locale.ENGLISH);
		if (!name.endsWith("[]")) {
			name = name + "[]";
		}
		Variable var = machine.getVariable(name);
		int offset = calcArrayOffset(var, pos);
		int val = memLocations.get(name) + 2 + offset;
		if (name.contains("$")) {
			return readString(memory[val]);
		} else if (name.contains("%")) {
			return memory[val];
		}
		return Float.intBitsToFloat(memory[val]);
	}

	private int calcArrayOffset(Variable var, int... pos) {
		int ap = 0;
		int cnt = 0;

		if (pos.length == 1) {
			// Fast path for one-dimensional arrays
			ap = pos[0];
		} else {
			int m = 1;
			for (int p : pos) {
				ap += m * p;
				m *= (var.getDimensions()[cnt] + 1);
				cnt++;
			}
		}
		return ap;
	}

	private String readString(Integer num) {
		return new String(memory, num + 1, memory[num]);
	}

	private void nop(String[] parts) {
		// Do nothing, just a stub
	}

	private void jmp(String[] parts) {
		String addry = parts[1].trim();
		try {
			jumpTo(addry);
		} catch (Exception e) {
			throw new RuntimeException("Undefined call address: " + parts[1]);
		}
	}

	private void je(String[] parts) {
		if (zeroFlag) {
			String addry = parts[1].trim();
			try {
				jumpTo(addry);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException("Undefined call address: " + parts[1] + " in " + (addr - 1));
			}
		}
	}

	private void jsr(String[] parts) {

		switch (parts[1]) {
		case "CONCAT":
			concat(parts);
			return;
		case "CHR":
			chr(parts);
			return;
		case "ASC":
			asc(parts);
			return;
		case "STR":
			str(parts);
			return;
		case "VAL":
			val(parts);
			return;
		case "LEN":
			len(parts);
			return;
		case "MID":
			mid(parts);
			return;
		case "LEFT":
			left(parts);
			return;
		case "RIGHT":
			right(parts);
			return;
		case "TAB":
			tab(parts);
			return;
		case "SPC":
			spc(parts);
			return;
		case "POS":
			pos(parts);
			return;
		case "ARRAYACCESS":
			arrayAccess(parts);
			return;
		case "ARRAYSTORE":
			arrayStore(parts);
			return;
		case "COMPACT":
			collectGarbage();
			return;
		case "SEQ":
			strEqual(parts);
			return;
		case "SNEQ":
			strNotEqual(parts);
			return;
		case "SGT":
			strGreaterThan(parts);
			return;
		case "SLT":
			strLowerThan(parts);
			return;
		case "SGTEQ":
			strGreaterThanOrEqual(parts);
			return;
		case "SLTEQ":
			strLowerThanOrEqual(parts);
			return;
		case "INTOUT":
			intOut(parts);
			return;
		case "REALOUT":
			realOut(parts);
			return;
		case "STROUT":
			strOut(parts);
			return;
		case "LINEBREAK":
			lineBreak(parts);
			return;
		default:
			stack.push(addr);
			jmp(parts);
		}
	}

	private void lineBreak(String[] parts) {
		System.out.println();
	}

	private void strOut(String[] parts) {
		System.out.print(readString(regs[A].intValue()));
	}

	private void realOut(String[] parts) {
		Number toPrint = regs[X];
		String out = toPrint.toString();
		if (VarUtils.getFloat(toPrint) >= 0) {
			out = " " + out;
		}
		System.out.print(out);
	}

	private void intOut(String[] parts) {
		Number toPrint = regs[X];
		String out = String.valueOf(toPrint.intValue());
		if (VarUtils.getInt(toPrint) >= 0) {
			out = " " + out;
		}
		System.out.print(out);
	}

	private void jumpTo(String newAddr) {
		String label = newAddr + ":";
		addr = label2line.get(label).intValue();
	}

	private void rts(String[] parts) {
		if (stack.isEmpty()) {
			halt = true;
		} else {
			addr = stack.pop().intValue();
		}
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

	private void mid(String[] parts) {
		String ch = readString(regs[B].intValue());
		int end = regs[D].intValue();
		int start = regs[C].intValue();

		if (end != -1) {
			mid.setTerm(Parser.getTerm("\"" + ch + "\"," + start + "," + end, machine, false, false));
		} else {
			mid.setTerm(Parser.getTerm("\"" + ch + "\"," + start, machine, false, false));
		}
		String snum = mid.eval(machine).toString();
		copyStringResult(snum);
	}

	private void left(String[] parts) {
		String ch = readString(regs[B].intValue());
		int end = regs[C].intValue();
		left.setTerm(Parser.getTerm("\"" + ch + "\"," + end, machine, false, false));
		String snum = left.eval(machine).toString();
		copyStringResult(snum);
	}

	private void right(String[] parts) {
		String ch = readString(regs[B].intValue());
		int end = regs[C].intValue();
		right.setTerm(Parser.getTerm("\"" + ch + "\"," + end, machine, false, false));
		String snum = right.eval(machine).toString();
		copyStringResult(snum);
	}

	private void tab(String[] parts) {
		runIntStringFunction(parts, tab, true);
	}

	private void spc(String[] parts) {
		runIntStringFunction(parts, spc, true);
	}

	private void pos(String[] parts) {
		pos.setTerm(Parser.getTerm("0", machine, false, false));
		Number num = (Number) pos.eval(machine);
		regs[X] = num;
	}

	private void copyStringResult(String snum) {
		checkMemory(snum.length());
		regs[A] = memPointer;
		memory[memPointer] = snum.length();
		System.arraycopy(toIntArray(snum), 0, memory, memPointer + 1, snum.length());
		memPointer += snum.length() + 1;
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
		copyStringResult(snum);
	}

	private void checkBufferSpace(String ss) {
		int max = bufferPos + ss.length();
		if (max >= memory.length) {
			throw new RuntimeException("Out of memory: " + ss);
		}
	}

	private void checkMemory(int addSize) {
		if (memPointer + addSize >= MEM_SIZE) {
			throw new RuntimeException("Out of memory: " + MEM_SIZE + "/" + addSize);
		}
	}

	private void collectGarbage() {
		int lookFor = stringStart;
		int closest = MEM_SIZE;
		int highest = stringStart;

		do {
			closest = MEM_SIZE;
			highest = 0;
			for (int i = 0; i < stringNames.size(); i++) {
				String name = stringNames.get(i);
				if (!name.endsWith("[]")) {
					// Handle normal strings
					int memAddr = memLocations.get(name);
					if (lookFor > highest) {
						highest = lookFor;
					}
					if (lookFor == memAddr) {
						Logger.log("Memory (" + memory[lookFor] + " Bytes@" + lookFor + ") for " + name + " still in use, skipping!");
						i = -1;
						lookFor = memAddr + memory[memAddr] + 1;
					} else {
						if (memAddr > lookFor && memAddr < closest) {
							closest = memAddr;
						}
					}
				} else {
					// Handle string array
					int addr = memLocations.get(name);
					int type = memory[addr++];
					int size = memory[addr++];
					if (type != 2) {
						throw new RuntimeException("Unknown array type: " + type);
					}
					for (int p = 0; p < size; p++) {
						int memAddr = memory[addr + p];
						if (lookFor > highest) {
							highest = lookFor;
						}
						if (lookFor == memAddr) {
							Logger.log("Memory (" + memory[lookFor] + " Bytes@" + lookFor + ") for " + name + "[" + p + "] still in use, skipping!");
							i = -1;
							lookFor = memAddr + memory[memAddr] + 1;
						} else {
							if (memAddr > lookFor && memAddr < closest) {
								closest = memAddr;
							}
						}
					}
				}
			}
			if (closest < MEM_SIZE) {
				int size = MEM_SIZE - closest;
				if (lookFor <= closest) {
					throw new RuntimeException("Invalid memory locations: " + closest + "/" + lookFor);
				}
				Logger.log("Compacting memory by moving " + size + " bytes from " + lookFor + " to " + closest + "!");
				System.arraycopy(memory, closest, memory, lookFor, size);
				lookFor = lookFor + memory[lookFor] + 1;

				int dif = lookFor - closest;
				for (String strName : stringNames) {
					if (!strName.endsWith("[]")) {
						int memAddr = memLocations.get(strName);
						if (memAddr >= lookFor) {
							Logger.log("Correcting address of " + strName + " from " + memAddr + " to " + (memAddr - dif) + "!");
							memLocations.put(strName, memAddr - dif);
						}
					} else {
						int addr = memLocations.get(strName);
						int type = memory[addr++];
						int sz = memory[addr++];
						if (type != 2) {
							throw new RuntimeException("Unknown array type: " + type);
						}
						for (int p = 0; p < sz; p++) {
							int memAddr = memory[addr + p];
							if (memAddr >= lookFor) {
								Logger.log("Correcting array address of " + strName + "[" + p + "] from " + memAddr + " to " + (memAddr - dif) + "!");
								memory[addr + p] = memAddr - dif;
							}
						}
					}
				}
			}
		} while (closest < MEM_SIZE);

		if (highest == memPointer) {
			// Logger.log("Memory pointer stays at " + memPointer);
		} else {
			// Logger.log("Moving memory pointer from " + memPointer + " to " +
			// highest);
			memPointer = highest;
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

	private void arrayStore(String[] parts) {
		int addr = regs[G].intValue();
		int offset = regs[X].intValue();
		float val = regs[Y].floatValue();
		int valStr = regs[A].intValue();
		int type = memory[addr];
		int size = memory[addr + 1];
		if (offset >= size) {
			throw new RuntimeException("Array index out of bounds: " + offset + "/" + (size - 1) + " in " + (this.addr - 1));
		}
		int pos = addr + offset + 2; // plus 2 because of the type and size
										// information in the first entries

		if (type == 1) {
			// System.out.println("Storing: "+val+" in "+(pos-2));
			memory[pos] = Float.floatToIntBits(val);
		} else {
			if (type == 0) {
				memory[pos] = (int) val;
			} else {
				// System.out.println("valstr: "+valStr+"/"+this.readString(valStr));
				memory[pos] = valStr;
			}
		}
	}

	private void arrayAccess(String[] parts) {
		int addr = regs[G].intValue();
		int offset = regs[X].intValue();
		int type = memory[addr];
		int size = memory[addr + 1];
		if (offset >= size) {
			throw new RuntimeException("Array index out of bounds: " + offset + "/" + (size - 1));
		}
		int pos = addr + offset + 2; // plus 2 because of the type and size
										// information in the first entries
		int val = memory[pos];

		if (type == 1) {
			regs[X] = Float.intBitsToFloat(val);
		} else {
			if (type == 0) {
				regs[X] = val;
			} else {
				regs[A] = val;
			}
		}
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

	private void lowerThanOrEqual(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return (n1.doubleValue() <= n2.doubleValue()) ? -1 : 0;
			}

			@Override
			public String op() {
				return "LTEQ_";
			}
		});
	}

	private void greaterThanOrEqual(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return (n1.doubleValue() >= n2.doubleValue()) ? -1 : 0;
			}

			@Override
			public String op() {
				return "GTEQ_";
			}
		});
	}

	private void lowerThan(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return n1.doubleValue() < n2.doubleValue() ? -1 : 0;
			}

			@Override
			public String op() {
				return "LT_";
			}
		});
	}

	private void greaterThan(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return n1.doubleValue() > n2.doubleValue() ? -1 : 0;
			}

			@Override
			public String op() {
				return "GT_";
			}
		});
	}

	private void notEqual(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return n1.doubleValue() == n2.doubleValue() ? 0 : -1;
			}

			@Override
			public String op() {
				return "NEQ_";
			}
		});
	}

	private void equal(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return n1.doubleValue() == n2.doubleValue() ? -1 : 0;
			}

			@Override
			public String op() {
				return "EQ_";
			}
		});
	}

	private void compare(String[] parts) {
		String[] ops = split(parts[1], ",");
		String target = ops[0];
		String source = ops[1];
		int ti = 0;
		int si = 0;

		ti = getIndex(target);
		si = getIndex(source);
		Type type = Type.INTEGER;

		Object v0 = null;
		Object v1 = null;

		if (ti == -1 && si != -1) {
			// memory with register
			int pos = target.lastIndexOf("{");
			if (pos != -1) {
				String ts = target.substring(pos + 1, target.lastIndexOf("}"));
				String val = target.substring(0, pos);
				type = Type.valueOf(ts);
				if (type == Type.STRING) {
					throw new RuntimeException("Comparing a string isn't supported!");
				} else {
					// a number...
					v0 = machine.getVariableUpperCase(val).getValue();
					v1 = regs[si];
				}
			} else {
				throw new RuntimeException("Unknown opcode: " + Arrays.toString(parts));
			}
		} else {
			// register with memory or register
			int pos = source.lastIndexOf("{");
			if (pos == -1) {
				v0 = regs[ti];
				v1 = regs[si];
			} else {
				String ts = source.substring(pos + 1, source.lastIndexOf("}"));
				String val = source.substring(0, pos);
				type = Type.valueOf(ts);
				if (type == Type.STRING) {
					throw new RuntimeException("Comparing a string isn't supported!");
				} else {
					// a number...
					if (val.startsWith("#")) {
						Number n = Float.valueOf(val.replace("#", ""));
						if (type == Type.INTEGER) {
							n = n.intValue();
						}
						v0 = regs[ti];
						v1 = n;
					} else {
						Number n = (Number) machine.getVariableUpperCase(val).eval(machine);
						v0 = regs[ti];
						v1 = n;
					}
				}
			}
		}

		double cmp = 1;
		if (v0 instanceof Number && v1 instanceof Number) {
			cmp = ((Number) v0).doubleValue() - ((Number) v1).doubleValue();
		} else {
			throw new RuntimeException("Can't compare " + v0.getClass() + " with " + v1.getClass());
		}

		updateZeroFlag(cmp);

	}

	private void strLowerThanOrEqual(String[] parts) {
		String n1 = readString(regs[B].intValue());
		String n2 = readString(regs[A].intValue());
		regs[X] = n1.compareTo(n2) >= 0 ? -1 : 0;
	}

	private void strGreaterThanOrEqual(String[] parts) {
		String n1 = readString(regs[B].intValue());
		String n2 = readString(regs[A].intValue());
		regs[X] = n1.compareTo(n2) <= 0 ? -1 : 0;
	}

	private void strLowerThan(String[] parts) {
		String n1 = readString(regs[B].intValue());
		String n2 = readString(regs[A].intValue());
		regs[X] = n1.compareTo(n2) > 0 ? -1 : 0;
	}

	private void strGreaterThan(String[] parts) {
		String n1 = readString(regs[B].intValue());
		String n2 = readString(regs[A].intValue());
		regs[X] = n1.compareTo(n2) < 0 ? -1 : 0;
	}

	private void strNotEqual(String[] parts) {
		String n1 = readString(regs[B].intValue());
		String n2 = readString(regs[A].intValue());
		regs[X] = n1.compareTo(n2) != 0 ? -1 : 0;
	}

	private void strEqual(String[] parts) {
		String n1 = readString(regs[B].intValue());
		String n2 = readString(regs[A].intValue());
		regs[X] = n1.compareTo(n2) == 0 ? -1 : 0;
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
		String[] ops = { "X", "Y" };
		if (parts.length > 1) {
			ops = split(parts[1], ",");
		}
		String target = ops[0];
		String source = ops[1];
		int ti = getIndex(target);
		int si = getIndex(source);

		Number n2 = regs[si];
		Number n1 = regs[ti];

		regs[ti] = calc.calc(n1, n2);
		updateZeroFlag(regs[ti]);
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

		if (ti == -1 && si != -1) {
			// From register into memory
			int pos = target.lastIndexOf("{");
			if (pos != -1) {
				String ts = target.substring(pos + 1, target.lastIndexOf("}"));
				String val = target.substring(0, pos);
				type = Type.valueOf(ts);
				if (type == Type.STRING) {
					// a string...
					Integer addr = regs[si].intValue();
					memLocations.put(val, addr);
				} else {
					// a number...
					if (val.contains("[]")) {
						throw new RuntimeException("Writing into '" + val + "' isn't supported!");
					} else {
						machine.getVariableUpperCase(val).setValue(regs[si]);
					}
				}
			} else {
				throw new RuntimeException("Unknown opcode: " + Arrays.toString(parts));
			}
		} else {
			// From memory or register into register
			int pos = source.lastIndexOf("{");
			if (pos == -1) {
				if (source.startsWith("(") && source.endsWith(")")) {
					regs[ti] = memory[regs[si].intValue()] & 0xff;
				} else {
					regs[ti] = regs[si];
				}
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
						if (val.contains("[]")) {
							Integer addr = memLocations.get(val);
							if (addr == null) {
								throw new RuntimeException("Unknown pointer to: " + val);
							}
							regs[ti] = addr;
						} else {
							Number n = (Number) machine.getVariableUpperCase(val).eval(machine);
							regs[ti] = n;
						}
					}
				}
			}
		}
		if (ti > -1) {
			updateZeroFlag(regs[ti]);
		}
	}

	private void updateZeroFlag(Number value) {
		zeroFlag = value.doubleValue() == 0;
	}

	private int getIndex(String target) {
		int ti = -1;
		if (target.equals("X") || target.equals("(X)")) {
			ti = 0;
		} else if (target.equals("Y") || target.equals("(Y)")) {
			ti = 1;
		} else if (target.equals("A") || target.equals("(A)")) {
			ti = 5;
		} else if (target.equals("B") || target.equals("(B)")) {
			ti = 6;
		} else if (target.equals("C") || target.equals("(C)")) {
			ti = 7;
		} else if (target.equals("D") || target.equals("(D)")) {
			ti = 8;
		} else if (target.equals("E") || target.equals("(E)")) {
			ti = 9;
		} else if (target.equals("F") || target.equals("(F)")) {
			ti = 10;
		} else if (target.equals("G") || target.equals("(G)")) {
			ti = 11;
		}
		return ti;
	}

	private interface Calc {
		Number calc(Number n1, Number n2);

		String op();
	}
}
