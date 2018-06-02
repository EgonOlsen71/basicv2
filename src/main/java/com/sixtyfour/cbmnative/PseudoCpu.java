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
import com.sixtyfour.config.CompilerConfig;
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
import com.sixtyfour.plugins.DeviceProvider;
import com.sixtyfour.plugins.SystemCallListener;
import com.sixtyfour.system.DataStore;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * @author EgonOlsen
 * 
 */
public class PseudoCpu {

	public final static int MEM_SIZE = 32768;
	public final static int PRG_START = 2064;

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
	private Deque<Number> jumpStack = new LinkedList<Number>();
	private byte[] forStack = new byte[1024];
	private int forStackPos;
	private Number[] regs = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }; // x,y,..,..,..,a,b,...
	private Machine machine;
	private CompilerConfig config;
	private boolean zeroFlag = false;
	private boolean halt = false;
	private int[] memory = null;
	private int addr = 0;
	private int datasAddr = MEM_SIZE;
	private int datasPointer = MEM_SIZE;
	private int datasSize = 0;
	private int emptyReal = 0;
	private int emptyString = 0;
	private int emptyInteger = 0;
	private int dynamicStart = 0;
	private int initialJumpStackSize = 0;
	@SuppressWarnings("unused")
	private int outputChannel = 0;
	private List<String> inputQueue = new ArrayList<String>();
	private int jumpTargetAddr = MEM_SIZE - 4;
	private Map<String, Integer> memLocations = new HashMap<String, Integer>();
	private Map<Integer, String> varLocations = new HashMap<Integer, String>();
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
	private SystemCallListener callListener = null;
	private int memoryLimit = MEM_SIZE;
	private boolean sharedRam = false;

	/**
	 * @param code
	 */
	public synchronized final void execute(CompilerConfig config, Machine machine, List<String> code) {
		Tab.setLimitedToPrint(false);
		Spc.setLimitedToPrint(false);
		this.machine = machine;
		this.config = config;
		stack.clear();
		label2line.clear();
		memLocations.clear();
		varLocations.clear();
		inputQueue.clear();
		outputChannel = 0;
		zeroFlag = false;
		addr = 0;
		datasSize = 0;
		emptyReal = 0;
		emptyString = 0;
		emptyInteger = 0;
		forStackPos = 0;
		stringStart = 0;
		bufferPos = MEM_SIZE;
		bufferStart = MEM_SIZE;
		datasAddr = MEM_SIZE;
		datasPointer = MEM_SIZE;
		halt = false;
		regs = new Number[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
		memory = new int[MEM_SIZE * 2]; // normal memory + work buffer
		memPointer = PRG_START;

		// Copy machine's memory content over to this cpu's...
		if (memory.length == machine.getRam().length) {
			// ...or(just use it, if it's of the same size;
			memory = machine.getRam();
			sharedRam = true;
		} else {
			System.arraycopy(machine.getRam(), 0, memory, 0, memory.length);
			sharedRam = false;
		}

		// Writing datas into ram
		createDatas();

		// Create emptry placeholders
		createEmtpyVariables();

		// Mapping Pseudo-memory addresses to simple typed variables
		createVariables();

		// Writing (string) constants into memory, extracted from actual code
		createStringConstants(code);

		// Writing arrays into memory
		createArrays();

		// Writing (string) variables into memory
		createStringVariables();

		this.dynamicStart = memPointer;

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

		List<String[]> splittedCode = new ArrayList<String[]>();
		for (String line : code) {
			splittedCode.add(split(line, " "));
		}

		do {
			executeCommand(code, splittedCode);
		} while (!halt && addr < code.size());
	}

	private final void executeCommand(List<String> code, List<String[]> splittedCode) {
		String[] parts = splittedCode.get(addr++);
		try {
			if (parts.length > 0) {

				if (parts[0].endsWith(":") && (Character.isDigit(parts[0].charAt(parts[0].length() - 2)) || parts[0].startsWith("PROGRAM"))) {
					return;
				}

				switch (parts[0]) {
				case "MOV":
					mov(parts);
					break;
				case "MOVB":
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
				case "SHR":
					shr(parts);
					break;
				case "SHL":
					shl(parts);
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
				case "XOR":
					xor(parts);
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
				case "NOP":
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
				case "JNE":
					jne(parts);
					break;
				case "RTS":
					rts(parts);
					break;
				case "BRK":
					halt = true;
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
			throw new RuntimeException("Error while executing: " + code.get(addr - 1) + "/" + addr, e);
		}
	}

	public void compactMemory() {
		this.collectGarbage();
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

	public int[] getRam() {
		return memory;
	}

	public SystemCallListener getSystemCallListener() {
		return callListener;
	}

	public void setSystemCallListener(SystemCallListener callListener) {
		this.callListener = callListener;
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

	private void createVariables() {
		Map<String, Variable> vars = machine.getVariables();
		for (Entry<String, Variable> entry : vars.entrySet()) {
			String name = entry.getKey();
			Variable var = entry.getValue();
			if (var.getType() != Type.STRING) {
				varLocations.put(System.identityHashCode(var), name);
			}
		}
	}

	private void createEmtpyVariables() {
		emptyString = memPointer;
		storeString(null, "");
		emptyInteger = memPointer++;
		memory[emptyInteger] = 0;
		emptyReal = memPointer++;
		memory[emptyReal] = Float.floatToIntBits(0f);
	}

	private void createStringVariables() {
		stringStart = memPointer;
		Map<String, Variable> vars = machine.getVariables();
		for (Entry<String, Variable> entry : vars.entrySet()) {
			String name = entry.getKey();
			Variable var = entry.getValue();
			if (name.endsWith("$") && !name.equals("TI$")) {
				String val = (String) var.eval(machine);
				if (memLocations.containsKey(name)) {
					throw new RuntimeException("Variable defined twice: " + name);
				}
				stringNames.add(name);
				if (val.isEmpty()) {
					memLocations.put(name, this.emptyString);
				} else {
					storeString(name, val);
				}
			}
		}
		// System.out.println("Mempointer(1): "+memPointer);
	}

	private void createDatas() {
		datasAddr = memPointer++;
		DataStore datas = machine.getDataStore();
		datas.restore();
		Object obj = null;
		while ((obj = datas.read()) != null) {
			Type type = Type.STRING;
			if (obj instanceof Integer) {
				type = Type.INTEGER;
			} else if (obj instanceof Float) {
				type = Type.REAL;
			}

			if (obj.toString().equals("\\0")) {
				if (type == Type.STRING) {
					obj = "";
				} else if (type == Type.REAL) {
					obj = 0.0f;
				} else {
					obj = 0;
				}
			}

			// System.out.println("Type: " + type + "/" + memPointer);
			if (type == Type.INTEGER) {
				memory[memPointer++] = 0;
				memory[memPointer++] = Integer.valueOf(obj.toString());
			} else if (type == Type.REAL) {
				memory[memPointer++] = 1;
				memory[memPointer++] = Float.floatToIntBits(Float.valueOf(obj.toString()));
			} else {
				memory[memPointer++] = 2;
				this.storeString(null, obj.toString());
			}
		}
		memory[datasAddr] = memPointer - datasAddr;
		restore(null);
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
						if (!val.toString().isEmpty()) {
							mems[pos++] = memPointer;
							storeString(null, val.toString());
						} else {
							mems[pos++] = this.emptyString;
						}
					}
				}

				if (memLocations.containsKey(name)) {
					throw new RuntimeException("Variable defined twice: " + name);
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

		if (val.length() > 0) {
			System.arraycopy(toIntArray(val), 0, memory, bufferPos == 0 ? (memPointer + 1) : bufferPos + 1, val.length());
		}
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
		if (memory[num] == 0) {
			return "";
		}
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
			if (callListener != null) {
				try {
					if (addry.startsWith("$")) {
						addry = String.valueOf(Integer.parseInt(addry.substring(1, addry.length()), 16));
					}
					callListener.sys(Integer.valueOf(addry));
					jumpStack.pop();
				} catch (Exception e2) {
					throw new RuntimeException("Undefined call address: " + parts[1]);
				}
			} else {
				throw new RuntimeException("Undefined call address: " + parts[1]);
			}
		}
	}

	private void je(String[] parts) {
		if (zeroFlag) {
			condJump(parts);
		}
	}

	private void jne(String[] parts) {
		if (!zeroFlag) {
			condJump(parts);
		}
	}

	private void condJump(String[] parts) {
		String addry = parts[1].trim();
		try {
			if (addry.startsWith("(") && addry.endsWith(")")) {
				if (addry.contains("$JUMP")) {
					addry = String.valueOf(MEM_SIZE - 4);
				} else {
					addry = addry.substring(1, addry.length() - 1);
				}
				int ia = Integer.parseInt(addry);
				this.addr = (memory[ia] & 0xff) + ((memory[ia + 1] & 0xff) << 8) + ((memory[ia + 2] & 0xff) << 16) + ((memory[ia + 3] & 0xff) << 24);
			} else {
				jumpTo(addry);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("Undefined call address: " + parts[1] + " in " + (addr - 1));
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
		case "EXTRAIGNORED":
			strOutAbs("?extra ignored", 0);
			return;
		case "USR":
			usr(parts);
			return;
		case "ASC":
			asc(parts);
			return;
		case "STR":
			str(parts);
			return;
		case "FRE":
			intOut(parts, 0);
			return;
		case "VAL":
			val(parts);
			return;
		case "TABOUT":
			regs[Y] = 1;
			tab(parts);
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
		case "TABCHANNEL":
			tab(parts);
			return;
		case "SPC":
		case "SPCCHANNEL":
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
		case "CHECKCMD":
			// @todo handle additional blank when in CMD mode...
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
			intOut(parts, 0);
			return;
		case "REALOUT":
			realOut(parts, 0);
			return;
		case "STROUT":
			strOut(parts, 0);
			return;
		case "LINEBREAK":
			lineBreak(parts, 0);
			return;
		case "INTOUTCHANNEL":
			intOutChannel(parts);
			return;
		case "REALOUTCHANNEL":
			realOutChannel(parts);
			return;
		case "STROUTCHANNEL":
			strOutChannel(parts);
			return;
		case "LINEBREAKCHANNEL":
			lineBreakChannel(parts);
			return;
		case "INITFOR":
			initFor(parts);
			return;
		case "FASTFOR":
			fastFor(parts);
			return;
		case "NEXT":
			next(parts);
			return;
		case "GOSUB":
			gosub(parts);
			return;
		case "RETURN":
			returny(parts);
			return;
		case "COPYSTR":
			copyString(parts);
			return;
		case "RESTORE":
			restore(parts);
			return;
		case "READSTR":
			readString(parts);
			return;
		case "READNUMBER":
			readNumber(parts);
			return;
		case "GETSTR":
			getString(parts);
			return;
		case "GETNUMBER":
			getNumber(parts);
			return;
		case "GETSTRCHANNEL":
			getStringChannel(parts);
			return;
		case "GETNUMBERCHANNEL":
			getNumberChannel(parts);
			return;
		case "CMD":
			cmd(parts);
			return;
		case "OPEN":
			open(parts);
			return;
		case "CLOSE":
			close(parts);
			return;
		case "INPUTSTR":
			inputString(parts);
			return;
		case "INPUTNUMBER":
			inputNumber(parts);
			return;
		case "INPUTSTRCHANNEL":
			inputStringChannel(parts);
			return;
		case "INPUTNUMBERCHANNEL":
			inputNumberChannel(parts);
			return;
		case "QUEUESIZE":
			queueSize(parts);
			return;
		case "CLEARQUEUE":
			clearQueue(parts);
			return;
		case "CLR":
			clearVars(parts);
			return;
		case "RUN":
			run(parts);
			return;
		case "END":
			end(parts);
			return;
		case "START":
			start(parts);
			return;
		default:
			jumpStack.push(addr);
			jmp(parts);
		}
	}

	private void usr(String[] parts) {
		// do nothing...who uses this anyway...
	}

	private void returny(String[] parts) {
		int fsp = forStackPos;
		while (fsp >= 0) {
			ForStackEntry fse = new ForStackEntry(fsp);
			if (fse.type == 0) {
				// System.out.println(forStack[forStackPos-1]);
				forStackPos = fsp - fse.size;
				// System.out.println("Stack corrected to "+forStackPos+"/"+fse.size);
				return;
			}
			fsp -= fse.size;
		}
		throw new RuntimeException("Stack underflow!");
	}

	private void gosub(String[] parts) {
		ForStackEntry fse = new ForStackEntry();
		forStackPos = fse.push(forStackPos);
	}

	private void lineBreak(String[] parts, int channel) {
		if (channel == 0) {
			machine.getOutputChannel().println(channel, "");
		} else {
			machine.getDeviceProvider().println(channel, "");
		}
	}

	private void strOut(String[] parts, int channel) {
		if (channel == 0) {
			machine.getOutputChannel().print(channel, readString(regs[A].intValue()));
		} else {
			machine.getDeviceProvider().print(channel, readString(regs[A].intValue()));
		}
	}

	private void strOutAbs(String strg, int channel) {
		if (channel == 0) {
			machine.getOutputChannel().print(channel, strg);
		} else {
			machine.getDeviceProvider().print(channel, strg);
		}
	}

	private void realOut(String[] parts, int channel) {
		Number toPrint = regs[X];
		String out = toPrint.toString();
		if (VarUtils.getFloat(toPrint) >= 0) {
			out = " " + out;
		}
		if (out.endsWith(".0")) {
			out = out.substring(0, out.length() - 2);
		}
		if (channel == 0) {
			machine.getOutputChannel().print(channel, out);
		} else {
			machine.getDeviceProvider().print(channel, out);
		}
	}

	private void intOut(String[] parts, int channel) {
		Number toPrint = regs[X];
		String out = String.valueOf(toPrint.intValue());
		if (VarUtils.getInt(toPrint) >= 0) {
			out = " " + out;
		}
		if (channel == 0) {
			machine.getOutputChannel().print(channel, out);
		} else {
			machine.getDeviceProvider().print(channel, out);
		}
	}

	private void intOutChannel(String[] parts) {
		intOut(parts, regs[C].intValue());
	}

	private void lineBreakChannel(String[] parts) {
		lineBreak(parts, regs[C].intValue());
	}

	private void strOutChannel(String[] parts) {
		strOut(parts, regs[C].intValue());
	}

	private void realOutChannel(String[] parts) {
		realOut(parts, regs[C].intValue());
	}

	private void cmd(String[] parts) {
		int fn = regs[X].intValue();
		if (!machine.getDeviceProvider().isOpen(fn)) {
			throw new RuntimeException("File not open error: " + this);
		}
		machine.getOutputChannel().setPrintConsumer(machine.getDeviceProvider(), fn);
		outputChannel = fn;
	}

	private void open(String[] parts) {
		DeviceProvider device = machine.getDeviceProvider();
		int size = regs[Y].intValue();

		try {
			switch (size) {
			case 1:
				device.open(VarUtils.getInt(regs[X]));
				break;
			case 2:
				device.open(VarUtils.getInt(regs[X]), VarUtils.getInt(regs[C]));
				break;
			case 3:
				device.open(VarUtils.getInt(regs[X]), VarUtils.getInt(regs[C]), VarUtils.getInt(regs[D]));
				break;
			case 4:
				device.open(VarUtils.getInt(regs[X]), VarUtils.getInt(regs[C]), VarUtils.getInt(regs[D]), readString(regs[G].intValue()));
				break;
			default:
				throw new RuntimeException("Invalid parameter count: " + size);
			}
		} catch (ClassCastException e) {
			throw new RuntimeException("Invalid parameter type!");
		}

	}

	private void close(String[] parts) {
		int fn = regs[X].intValue();

		if (machine.getOutputChannel().getPrintConsumer() != null) {
			if (machine.getOutputChannel().getChannel() == fn) {
				machine.getOutputChannel().setPrintConsumer(null, 0);
			}
		}

		machine.getDeviceProvider().close(fn);
	}

	private void jumpTo(String newAddr) {
		String label = newAddr + ":";
		addr = label2line.get(label).intValue();
	}

	private void rts(String[] parts) {
		if (jumpStack.isEmpty()) {
			halt = true;
		} else {
			addr = jumpStack.pop().intValue();
		}
	}

	private void xToStack() {
		int size = initialJumpStackSize;
		while (jumpStack.size() > size) {
			jumpStack.pop();
		}
	}

	private void stackToX() {
		initialJumpStackSize = jumpStack.size();
	}

	private void start(String[] parts) {
		stackToX();
	}

	private void end(String[] parts) {
		xToStack();
	}

	private void initFor(String[] parts) {
		Number stepVal = getStack().pop();
		Number endVal = getStack().pop();

		ForStackEntry fse = new ForStackEntry(regs[A].intValue(), this.addr, endVal, stepVal);
		forStackPos = fse.push(forStackPos);
	}

	private void fastFor(String[] parts) {
		Number stepVal = getStack().pop();
		Number endVal = getStack().pop();
		int varAddr = regs[A].intValue();

		ForStackEntry fse = new ForStackEntry(varAddr, this.addr, endVal, stepVal);
		Variable var = machine.getVariableUpperCase(varLocations.get(fse.varPointer));
		int val = ((Number) var.eval(machine)).intValue();
		int to = fse.to.intValue();
		int step = fse.step.intValue();
		int pval = regs[X].intValue();
		for (int i = val; i <= to; i += step) {
			memory[i] = pval & 0xff;
		}
		var.setValue(to + step);
	}

	private void next(String[] parts) {
		int varAddr = regs[A].intValue();

		int fsp = forStackPos;
		while (fsp >= 0) {
			ForStackEntry fse = new ForStackEntry(fsp);
			if (fse.type == 0) {
				// Still an open GOSUB => error!
				break;
			} else if (fse.type == 1) {
				if (varAddr == 0 || varAddr == fse.varPointer) {
					Variable var = machine.getVariableUpperCase(varLocations.get(fse.varPointer));
					double val = ((Number) var.eval(machine)).doubleValue();
					double to = fse.to.doubleValue();
					double step = fse.step.doubleValue();

					// System.out.println(val+"/"+to+"/"+step);

					val += step;
					var.setValue(val);

					if (step < 0) {
						if (val >= to) {
							regs[A] = 0;
							memory[jumpTargetAddr] = (byte) (fse.addr & 0xff);
							memory[jumpTargetAddr + 1] = (byte) ((fse.addr >> 8) & 0xff);
							memory[jumpTargetAddr + 2] = (byte) ((fse.addr >> 16) & 0xff);
							memory[jumpTargetAddr + 3] = (byte) (fse.addr >> 24);
						} else {
							regs[A] = 1;
							forStackPos = fsp - fse.size;
						}
					} else {
						if (val <= to) {
							regs[A] = 0;
							memory[jumpTargetAddr] = (byte) (fse.addr & 0xff);
							memory[jumpTargetAddr + 1] = (byte) ((fse.addr >> 8) & 0xff);
							memory[jumpTargetAddr + 2] = (byte) ((fse.addr >> 16) & 0xff);
							memory[jumpTargetAddr + 3] = (byte) (fse.addr >> 24);
							forStackPos = fsp;
						} else {
							regs[A] = 1;
							forStackPos = fsp - fse.size;
						}
					}
					return;
				}
			}
			fsp -= fse.size;
		}
		throw new RuntimeException("Next without for!");
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
		regs[A] = bufferStart;
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
			mid.setTerm(Parser.getTerm(config, "\"" + ch + "\"," + start + "," + end, machine, false, false));
		} else {
			mid.setTerm(Parser.getTerm(config, "\"" + ch + "\"," + start, machine, false, false));
		}
		String snum = mid.eval(machine).toString();
		copyStringResult(snum);
	}

	private void left(String[] parts) {
		String ch = readString(regs[B].intValue());
		int end = regs[C].intValue();
		left.setTerm(Parser.getTerm(config, "\"" + ch + "\"," + end, machine, false, false));
		String snum = left.eval(machine).toString();
		copyStringResult(snum);
	}

	private void right(String[] parts) {
		String ch = readString(regs[B].intValue());
		int end = regs[C].intValue();
		right.setTerm(Parser.getTerm(config, "\"" + ch + "\"," + end, machine, false, false));
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
		pos.setTerm(Parser.getTerm(config, "0", machine, false, false));
		Number num = (Number) pos.eval(machine);
		regs[X] = num;
	}

	private void copyString(String[] parts) {
		int fromAddr = regs[A].intValue();
		if (fromAddr >= MEM_SIZE) {
			String toCopy = this.readString(fromAddr);
			copyStringResult(toCopy);
		}
		this.bufferPos = MEM_SIZE;
		this.bufferStart = MEM_SIZE;
	}

	private void run(String[] parts) {
		clearVars(parts);
		addr = 0;
	}

	private void clearVars(String[] parts) {
		for (Variable var : machine.getVariables().values()) {
			if (var.isArray()) {
				int addr = memLocations.get(var.getName());
				int type = memory[addr++];
				int size = memory[addr++];
				for (int i = 0; i < size; i++) {
					if (type == 0) {
						memory[addr + i] = 0;
					} else if (type == 1) {
						memory[addr + i] = Float.floatToIntBits(0f);
					} else if (type == 2) {
						memory[addr + i] = this.emptyString;
					} else {
						throw new RuntimeException("Unknown type: " + type);
					}
				}

			} else {
				if (var.getType() == Type.INTEGER) {
					var.setValue(0);
				} else if (var.getType() == Type.REAL) {
					var.setValue(0.0f);
				} else {
					if (memLocations.containsKey(var.getName())) {
						memLocations.put(var.getName(), this.emptyString);
					}
				}
			}
		}
		this.restore(parts);
		memPointer = dynamicStart;
		bufferPos = MEM_SIZE;
		bufferStart = MEM_SIZE;
	}

	private void restore(String[] parts) {
		datasPointer = datasAddr;
		datasSize = memory[datasPointer++];
	}

	private void getString(String[] parts) {
		Character c = machine.getInputProvider().readKey();
		if (c == null) {
			regs[A] = emptyString;
		} else {
			copyStringResult(c.toString());
		}
		machine.getOutputChannel().setPrintConsumer(null, 0);
	}

	private void getNumber(String[] parts) {
		Character c = machine.getInputProvider().readKey();
		if (c == null) {
			regs[Y] = emptyReal;
		} else {
			c = ensureNumberKey(machine, c, true);
			regs[Y] = Integer.valueOf(c.toString());
		}
		machine.getOutputChannel().setPrintConsumer(null, 0);
	}

	private void clearQueue(String[] parts) {
		inputQueue.clear();
	}

	private void queueSize(String[] parts) {
		regs[X] = inputQueue.size();
	}

	private void inputNumber(String[] parts) {
		String inp = inputNext();
		regs[X] = 0;
		try {
			Float num = Float.valueOf(inp);
			regs[Y] = num;
		} catch (NumberFormatException nfe) {
			regs[X] = 1;
			inputQueue.clear();
		}
	}

	private void inputString(String[] parts) {
		String inp = inputNext();
		copyStringResult(inp);
		regs[X] = 0;
	}

	private String inputNext() {
		String input = null;
		if (inputQueue.isEmpty()) {
			input = machine.getInputProvider().readString();
			machine.getOutputChannel().println(0, "");
			if (input == null) {
				input = "";
			}
			String[] parts = input.split(",");
			if (parts.length > 1) {
				for (int p = 1; p < parts.length; p++) {
					inputQueue.add(parts[p]);
				}
			}
			input = parts[0];
		} else {
			input = inputQueue.remove(0);
		}
		return input;
	}

	private void getStringChannel(String[] parts) {
		int fn = regs[C].intValue();
		DeviceProvider device = machine.getDeviceProvider();
		Character c = device.getChar(fn);
		copyStringResult(c.toString());
	}

	private void getNumberChannel(String[] parts) {
		int fn = regs[C].intValue();
		DeviceProvider device = machine.getDeviceProvider();
		Character c = device.getChar(fn);
		c = ensureNumberKey(machine, c, true);
		regs[Y] = Integer.valueOf(c.toString());
	}

	private void inputNumberChannel(String[] parts) {
		int fn = regs[C].intValue();
		DeviceProvider device = machine.getDeviceProvider();
		float num = device.inputNumber(fn);
		regs[Y] = num;
	}

	private void inputStringChannel(String[] parts) {
		int fn = regs[C].intValue();
		DeviceProvider device = machine.getDeviceProvider();
		String str = device.inputString(fn);
		copyStringResult(str);
	}

	private void readString(String[] parts) {
		checkDataPointer();
		int type = memory[datasPointer++];
		if (type != 2) {
			Number n = null;
			if (type == 0) {
				n = memory[datasPointer++];
			} else {
				n = Float.intBitsToFloat(memory[datasPointer++]);
			}
			copyStringResult(n.toString());
		} else {
			regs[A] = datasPointer;
			datasPointer += memory[datasPointer++] + 1;
		}
	}

	private Character ensureNumberKey(Machine machine, Character input, boolean checkColon) {
		if (input == '+' || input == '-' || input == '.' || input == ',' || input == 'e') {
			input = '0';
		}
		if (checkColon && input == ':') {
			machine.getOutputChannel().systemPrintln(0, "?Extra ignored:" + this);
			input = '0';
		}
		if (input < '0' || input > '9') {
			throw new RuntimeException("Invalid key!");
		}
		return input;
	}

	private void readNumber(String[] parts) {
		checkDataPointer();
		int type = memory[datasPointer++];
		if (type == 2) {
			throw new RuntimeException("Type mismatch: " + type);
		}
		if (type == 0) {
			regs[Y] = memory[datasPointer++];
		} else {
			regs[Y] = Float.intBitsToFloat(memory[datasPointer++]);
		}
	}

	private void checkDataPointer() {
		if (datasPointer - datasAddr >= datasSize) {
			throw new RuntimeException("Out of data: " + datasPointer + "/" + datasAddr + "/" + datasSize);
		}
	}

	private void copyStringResult(String snum) {
		checkMemory(snum.length());
		regs[A] = memPointer;
		memory[memPointer] = snum.length();
		System.arraycopy(toIntArray(snum), 0, memory, memPointer + 1, snum.length());
		memPointer += snum.length() + 1;
		this.bufferPos = MEM_SIZE;
		this.bufferStart = MEM_SIZE;
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
		func.setTerm(Parser.getTerm(config, "\"" + ch + "\"", machine, false, false));
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
		func.setTerm(Parser.getTerm(config, String.valueOf(inty ? num.intValue() : num.floatValue()), machine, false, false));
		String snum = func.eval(machine).toString();
		copyStringResult(snum);
	}

	private void checkBufferSpace(String ss) {
		int max = bufferPos + ss.length();
		if (max >= memory.length) {
			throw new RuntimeException("Out of memory: [" + ss + "] - " + max + "/" + bufferPos + "/" + memory.length);
		}
	}

	private void checkMemory(int addSize) {
		if (memPointer + addSize >= memoryLimit) {
			throw new RuntimeException("Out of memory: " + memoryLimit + "/" + addSize);
		}
	}

	private void collectGarbage() {
		int lookFor = stringStart;
		int closest = memPointer;
		int highest = stringStart;

		do {
			closest = memPointer;
			highest = 0;
			for (int i = 0; i < stringNames.size(); i++) {
				String name = stringNames.get(i);
				// System.out.println("Checking: "+name+"/"+lookFor);
				if (!name.endsWith("[]")) {
					// Handle normal strings
					int memAddr = memLocations.get(name);
					// System.out.println("Addr "+name+": "+memAddr+"/"+memory[memAddr]);
					if (lookFor > highest) {
						highest = lookFor;
					}
					if (lookFor == memAddr) {
						// Logger.log("Memory (" + memory[lookFor] + " Bytes@" +
						// lookFor + ") for " + name +
						// " still in use, skipping!");
						i = -1;
						lookFor = memAddr + memory[memAddr] + 1;
						closest = memPointer;
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
							// Logger.log("Memory (" + memory[lookFor] +
							// " Bytes@" + lookFor + ") for " + name + "[" + p +
							// "] still in use, skipping!");
							i = -1;
							lookFor = memAddr + memory[memAddr] + 1;
							closest = memPointer;
						} else {
							if (memAddr > lookFor && memAddr < closest) {
								closest = memAddr;
							}
						}
					}
				}
			}

			if (closest < memPointer) {
				int size = memPointer - closest;
				if (lookFor > closest) {
					throw new RuntimeException("Invalid memory locations: " + closest + "/" + lookFor + "/" + memPointer);
				}
				// Logger.log("Compacting memory by moving " + size +
				// " bytes from " + closest + " to " + lookFor + "!");
				System.arraycopy(memory, closest, memory, lookFor, size);
				int oldLookFor = lookFor;
				lookFor = lookFor + memory[lookFor] + 1;

				int dif = closest - oldLookFor;
				for (String strName : stringNames) {
					if (!strName.endsWith("[]")) {
						int memAddr = memLocations.get(strName);
						if (memAddr >= oldLookFor) {
							// Logger.log("Correcting address of " + strName +
							// " from " + memAddr + " to " + (memAddr - dif) +
							// "!");
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
							if (memAddr >= oldLookFor) {
								// Logger.log("Correcting array address of " +
								// strName + "[" + p + "] from " + memAddr +
								// " to " + (memAddr - dif) + "!");
								memory[addr + p] = memAddr - dif;
							}
						}
					}
				}
			}
		} while (closest < memPointer);

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

	private void xor(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return n1.intValue() ^ n2.intValue();
			}

			@Override
			public String op() {
				return "~_";
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

	private void shr(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return n1.floatValue() / Math.pow(2, n2.floatValue());
			}

			@Override
			public String op() {
				return ">_";
			}
		});
	}

	private void shl(String[] parts) {
		calc(parts, new Calc() {
			@Override
			public Number calc(Number n1, Number n2) {
				return n1.floatValue() * Math.pow(2, n2.floatValue());
			}

			@Override
			public String op() {
				return "<_";
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

		if (ti == -1 && si == -1) {
			// constant into memory
			int addr = Integer.parseInt(target);
			int val = Integer.parseInt(source.substring(0, source.indexOf("{")).replace("#", "").trim()) & 0xff;
			memory[addr] = val;
			return;
		}

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
				// From register into fixed memory address
				int addr = Integer.parseInt(target);
				int val = regs[si].intValue() & 0xff;
				memory[addr] = val;
				if (sharedRam) {
					machine.getMemoryListener().poke(addr, val);
				}
			}
		} else {
			// From memory or register into register
			int pos = source.lastIndexOf("{");
			if (pos == -1) {
				if (source.startsWith("(") && source.endsWith(")")) {
					regs[ti] = memory[regs[si].intValue()] & 0xff;
				} else {
					if (target.startsWith("(") && target.endsWith(")")) {
						int addr = regs[ti].intValue();
						int val = regs[si].intValue() & 0xff;
						memory[addr] = val;
						if (sharedRam) {
							machine.getMemoryListener().poke(addr, val);
						}
						// System.out.println(regs[ti].intValue()+"/"+(regs[si].intValue()
						// & 0xff)+"/"+memory[regs[ti].intValue()]);
					} else {
						String val = source;
						if (isNumber(val)) {
							// From fixed memory address into register
							int vally = Integer.parseInt(val);
							regs[ti] = memory[vally];
						} else {
							regs[ti] = regs[si];
						}
					}
				}
			} else {
				String ts = source.substring(pos + 1, source.lastIndexOf("}"));
				String val = source.substring(0, pos);

				if (source.startsWith("(") && source.endsWith(")")) {
					val = val.substring(1);
					regs[ti] = System.identityHashCode(machine.getVariableUpperCase(val));
				} else {
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
		}
		if (ti > -1) {
			updateZeroFlag(regs[ti]);
		}
	}

	private boolean isNumber(String val) {
		for (int i = 0; i < val.length(); i++) {
			if (!Character.isDigit(val.charAt(i))) {
				return false;
			}
		}
		return true;
	}

	private void updateZeroFlag(Number value) {
		zeroFlag = value.doubleValue() == 0;
	}

	private int getIndex(String target) {
		int ti = -1;
		if (target.length() > 3) {
			return ti;
		}
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

	public int getMemoryLimit() {
		return memoryLimit;
	}

	public void setMemoryLimit(int memoryLimit) {
		this.memoryLimit = memoryLimit;
	}

	private static interface Calc {
		Number calc(Number n1, Number n2);

		String op();
	}

	private class ForStackEntry {
		byte size;
		byte type; // 0=gosub, 1=for
		int varPointer;
		int addr;
		Number to;
		Number step;

		public ForStackEntry() {
			this.type = 0;
		}

		public ForStackEntry(int varPointer, int addr, Number to, Number step) {
			this.varPointer = varPointer;
			this.addr = addr;
			this.to = to;
			this.step = step;
			this.type = 1;
		}

		public ForStackEntry(int stackPos) {
			size = forStack[stackPos - 1];
			type = forStack[stackPos - 2];
			if (type == 0) {
				return;
			}

			int sp = stackPos - size;
			varPointer = getInt(sp);
			addr = getInt(sp + 4);
			Number[] sc = getNumbers(sp + 8);
			to = sc[0];
			step = sc[1];
		}

		public int push(int stackPos) {
			int s = 0;
			if (type != 0) {
				store(varPointer, stackPos);
				s += 4;
				store(addr, stackPos + s);
				s += 4;
				int h = 0;
				if (to instanceof Integer) {
					h = to.intValue();
					forStack[stackPos + (s++)] = 0;
				} else {
					h = Float.floatToIntBits(to.floatValue());
					forStack[stackPos + (s++)] = 1;
				}
				store(h, stackPos + s);
				s += 4;
				if (step instanceof Integer) {
					h = step.intValue();
					forStack[stackPos + (s++)] = 0;
				} else {
					h = Float.floatToIntBits(step.floatValue());
					forStack[stackPos + (s++)] = 1;
				}
				store(h, stackPos + s);
				s += 4;
			}
			forStack[stackPos + (s++)] = type;
			forStack[stackPos + s] = (byte) ++s;
			return s + stackPos;
		}

		private void store(int h, int sp) {
			forStack[sp] = (byte) (h & 0xff);
			forStack[sp + 1] = (byte) ((h >> 8) & 0xff);
			forStack[sp + 2] = (byte) ((h >> 16) & 0xff);
			forStack[sp + 3] = (byte) (h >> 24);
		}

		private Number[] getNumbers(int sp) {
			Number[] ret = new Number[2];
			int p = 0;
			do {
				byte type = forStack[sp];
				if (type == 0) {
					int h = getInt(sp + 1);
					ret[p] = h;
					sp += 5;
				} else {
					float h = Float.intBitsToFloat(getInt(sp + 1));
					ret[p] = h;
					sp += 5;
				}
			} while (++p < 2);
			return ret;
		}

		private int getInt(int sp) {
			return (forStack[sp] & 0xff) + ((forStack[sp + 1] & 0xff) << 8) + ((forStack[sp + 2] & 0xff) << 16) + ((forStack[sp + 3] & 0xff) << 24);
		}
	}
}
