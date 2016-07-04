package sixtyfour;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import sixtyfour.elements.commands.Command;
import sixtyfour.elements.commands.Rem;
import sixtyfour.parser.Line;
import sixtyfour.parser.Parser;
import sixtyfour.plugins.InputProvider;
import sixtyfour.plugins.MemoryListener;
import sixtyfour.plugins.OutputChannel;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;
import sixtyfour.util.VarUtils;

/**
 * The Class Interpreter.
 */
public class Interpreter {

	/** The code. */
	private String[] code = null;
	
	/** The lines. */
	private Map<Integer, Line> lines = new HashMap<Integer, Line>();
	
	/** The line numbers. */
	private List<Integer> lineNumbers = new ArrayList<Integer>();
	
	/** The machine. */
	private Machine machine = null;
	
	/** The parsed. */
	private boolean parsed = false;
	
	/** The stop. */
	private boolean stop = false;
	
	/** The print line numbers. */
	private boolean printLineNumbers = false;

	/**
	 * Instantiates a new interpreter.
	 * 
	 * @param code
	 *            the code
	 */
	public Interpreter(String code) {
		this(code.split("\n"));
	}

	/**
	 * Instantiates a new interpreter.
	 * 
	 * @param code
	 *            the code
	 */
	public Interpreter(String[] code) {
		this.code = Arrays.copyOf(code, code.length);
	}

	/**
	 * Gets the machine.
	 * 
	 * @return the machine
	 */
	public Machine getMachine() {
		return machine;
	}

	/**
	 * Gets the string variable.
	 * 
	 * @param name
	 *            the name
	 * @return the string variable
	 */
	public String getStringVariable(String name) {
		Object obj = machine.getVariable(name.toUpperCase(Locale.ENGLISH)).getValue();
		if (VarUtils.isString(obj)) {
			return (String) obj;
		}
		return null;
	}

	/**
	 * Gets the integer variable.
	 * 
	 * @param name
	 *            the name
	 * @return the integer variable
	 */
	public Integer getIntegerVariable(String name) {
		Object obj = machine.getVariable(name.toUpperCase(Locale.ENGLISH)).getValue();
		if (VarUtils.isInteger(obj)) {
			return (Integer) obj;
		}
		return null;
	}

	/**
	 * Gets the float variable.
	 * 
	 * @param name
	 *            the name
	 * @return the float variable
	 */
	public Float getFloatVariable(String name) {
		Object obj = machine.getVariable(name.toUpperCase(Locale.ENGLISH)).getValue();
		if (VarUtils.isFloat(obj)) {
			return (Float) obj;
		}
		return null;
	}

	/**
	 * Gets the array variable.
	 * 
	 * @param name
	 *            the name
	 * @return the array variable
	 */
	@SuppressWarnings("unchecked")
	public Object[] getArrayVariable(String name) {
		if (!name.endsWith("[]")) {
			name = name + "[]";
		}
		Object obj = machine.getVariable(name.toUpperCase(Locale.ENGLISH)).getValue();
		if (obj.getClass().isArray()) {
			return ((ArrayList<Object>) obj).toArray();
		}
		return null;
	}

	/**
	 * Parses the.
	 */
	public void parse() {
		long start = System.nanoTime();
		machine = new Machine();
		Line cl = null;
		int lastLineNumber = -1;
		lines.clear();
		lineNumbers.clear();
		for (String line : code) {
			try {
				cl = Parser.getLine(line);
				if (lines.containsKey(cl.getNumber())) {
					throw new RuntimeException("Duplicate line number in: " + line);
				}
				if (cl.getNumber() < 0 || cl.getNumber() < lastLineNumber) {
					throw new RuntimeException("Faulty line number in: " + line);
				}
				lastLineNumber = cl.getNumber();
				int lineCnt = lineNumbers.size();
				cl.setCount(lineCnt);

				lines.put(cl.getNumber(), cl);
				lineNumbers.add(cl.getNumber());

				boolean looseEnding = cl.getLine().trim().endsWith(":");
				if (looseEnding) {
					cl.addDummyRemark();
				}
				String[] parts = Parser.getParts(cl, machine);

				int pos = 0;
				for (String part : parts) {
					do {
						part = Parser.removeWhiteSpace(part);
						if (part.trim().length() > 0) {
							Command command = Parser.getCommand(part);
							if (command == null) {
								throw new RuntimeException("Syntax error: " + cl.getNumber() + " " + cl.getLine());
							}
							part = command.parse(part, lineCnt, cl.getNumber(), pos, (pos == parts.length - 1), machine);

							machine.addCommand(command);
							cl.addCommand(command);
							pos++;
							if (Rem.REM_MARKER.equals(part)) {
								break;
							}
						} else {
							part = null;
						}
					} while (part != null);
					if (Rem.REM_MARKER.equals(part)) {
						break;
					}
				}
			} catch (Throwable t) {
				String msg = t.getMessage();
				String err = "Error in line " + (cl != null ? cl.getNumber() : "??") + (msg != null ? (": " + msg) : "");
				machine.getOutputChannel().println(0, err);
				throw t;
			}
		}
		parsed = true;
		Logger.log(machine.getCommandList().size() + " commands parsed in: " + (System.nanoTime() - start) / 1000000L + "ms");
	}

	/**
	 * Run.
	 */
	public void run() {
		stop = false;
		if (!parsed) {
			parse();
		}
		if (parsed) {
			long start = System.nanoTime();
			execute(0, 0);
			long end = System.nanoTime();
			machine.getOutputChannel().println(0, "\nREADY. (" + ((end - start) / 1000000L) + "ms)");
			parsed = false;
		} else {
			machine.getOutputChannel().println(0, "\nREADY.");
		}
	}

	/**
	 * Run stop.
	 */
	public void runStop() {
		stop = true;
	}

	/**
	 * Gets the ram.
	 * 
	 * @return the ram
	 */
	public int[] getRam() {
		return machine.getRam();
	}

	/**
	 * Gets the input provider.
	 * 
	 * @return the input provider
	 */
	public InputProvider getInputProvider() {
		return machine.getInputProvider();
	}

	/**
	 * Sets the input provider.
	 * 
	 * @param inputProvider
	 *            the new input provider
	 */
	public void setInputProvider(InputProvider inputProvider) {
		machine.setInputProvider(inputProvider);
	}

	/**
	 * Gets the output channel.
	 * 
	 * @return the output channel
	 */
	public OutputChannel getOutputChannel() {
		return machine.getOutputChannel();
	}

	/**
	 * Sets the output channel.
	 * 
	 * @param outputChannel
	 *            the new output channel
	 */
	public void setOutputChannel(OutputChannel outputChannel) {
		machine.setOutputChannel(outputChannel);
	}

	/**
	 * Gets the memory listener.
	 * 
	 * @return the memory listener
	 */
	public MemoryListener getMemoryListener() {
		return machine.getMemoryListener();
	}

	/**
	 * Sets the memory listener.
	 * 
	 * @param memoryListener
	 *            the new memory listener
	 */
	public void setMemoryListener(MemoryListener memoryListener) {
		machine.setMemoryListener(memoryListener);
	}

	/**
	 * Checks if is prints the line numbers.
	 * 
	 * @return true, if is prints the line numbers
	 */
	public boolean isPrintLineNumbers() {
		return printLineNumbers;
	}

	/**
	 * Sets the prints the line numbers.
	 * 
	 * @param printLineNumbers
	 *            the new prints the line numbers
	 */
	public void setPrintLineNumbers(boolean printLineNumbers) {
		this.printLineNumbers = printLineNumbers;
	}

	/**
	 * Execute.
	 * 
	 * @param lineCnt
	 *            the line cnt
	 * @param pos
	 *            the pos
	 */
	private void execute(int lineCnt, int pos) {
		if (lineNumbers.size() == 0) {
			return;
		}
		Integer num = null;
		try {
			do {
				num = lineNumbers.get(lineCnt);
				if (printLineNumbers) {
					Logger.log("[" + num + "]");
				}
				if (stop) {
					machine.getOutputChannel().println(0, "\nBREAK IN " + num);
				}
				Line line = lines.get(num);
				for (int i = pos; i < line.getCommands().size(); i++) {
					Command command = line.getCommands().get(i);
					machine.setCurrentCommand(command);
					ProgramCounter pc = command.execute(machine);
					machine.setCurrentCommand(null);
					if (pc != null) {
						if (pc.isEnd() || pc.isStop()) {
							lineCnt = lines.size();
							if (pc.isStop()) {
								this.machine.getOutputChannel().println(0, "Break in " + num);
							}
							break;
						}
						if (pc.isList()) {
							for (String cl : code) {
								this.machine.getOutputChannel().println(0, cl);
							}
						} else {
							if (pc.isSkip()) {
								break;
							}
							if (pc.getLineNumber() == -1) {
								// Line index is known (FOR...NEXT/RETURN/RUN
								// w/o
								// line)
								lineCnt = pc.getLineCnt();
								num = lineNumbers.get(lineCnt);
								line = lines.get(num);
								i = pc.getLinePos();
								if (i >= line.getCommands().size() - 1) {
									lineCnt++;
									num = lineNumbers.get(lineCnt);
									line = lines.get(num);
									i = -1;
								}
							} else {
								// Line number is known (GOTO/GOSUB/RUN w/ line)
								num = pc.getLineNumber();
								line = lines.get(num);
								i = -1;
								if (line == null) {
									throw new RuntimeException("Undef'd statement error: " + command);
								}
								lineCnt = line.getCount();
							}
						}
					}
				}
				lineCnt++;
			} while (lineCnt < lines.size());
		} catch (Throwable t) {
			String msg = t.getMessage();
			String err = "Error in line " + (num != null ? num : "??") + (msg != null ? (": " + msg) : "");
			machine.getOutputChannel().println(0, err);
			throw t;
		}
	}
}
