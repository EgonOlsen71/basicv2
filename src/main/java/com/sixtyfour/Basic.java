package com.sixtyfour;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.sixtyfour.cbmnative.PCode;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.config.LoopMode;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.CommandList;
import com.sixtyfour.elements.commands.For;
import com.sixtyfour.elements.commands.Let;
import com.sixtyfour.elements.commands.Next;
import com.sixtyfour.elements.commands.Rem;
import com.sixtyfour.elements.commands.internal.Delay;
import com.sixtyfour.elements.functions.FunctionList;
import com.sixtyfour.extensions.BasicExtension;
import com.sixtyfour.parser.Line;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.TermEnhancer;
import com.sixtyfour.plugins.CodeEnhancer;
import com.sixtyfour.plugins.InputProvider;
import com.sixtyfour.plugins.MemoryListener;
import com.sixtyfour.plugins.OutputChannel;
import com.sixtyfour.plugins.SystemCallListener;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Cpu;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.Jit;
import com.sixtyfour.util.VarUtils;

/**
 * Basic is for parsing/compiling and executing BASIC V2 programs. The program
 * will be compiled into some object code. Albeit the machine offers a 64kb
 * array of memory, the actual basic program doesn't reside in it.
 * 
 * @author EgonOlsen
 * 
 */
public class Basic implements ProgramExecutor {

	/** The code. */
	private String[] code = null;

	/** The lines. */
	private Map<Integer, Line> lines = new HashMap<Integer, Line>();

	/** The line numbers. */
	private List<Integer> lineNumbers = new ArrayList<Integer>();

	/** The machine. */
	private Machine machine = null;

	/** Has it been compiled already? */
	private boolean compiled = false;

	/** Should it stop? */
	private boolean stop = false;

	/** The print line numbers. */
	private boolean printLineNumbers = false;

	private boolean paused;

	private boolean running;

	private Tracer tracer = null;

	private static Map<String, BasicExtension> addedExtensions = new HashMap<String, BasicExtension>();

	private CodeEnhancer codeEnhancer;

	/**
	 * Instantiates a new instance for a BASIC program. No
	 * interpretation/compilation will take place at this stage.
	 * 
	 * @param code
	 *            the basic code
	 */
	public Basic(String code) {
		this(code.split("\n"));
	}

	/**
	 * Instantiates a new instance for a BASIC program. No
	 * interpretation/compilation will take place at this stage.
	 * 
	 * @param code
	 *            the basic code
	 * @param machine
	 *            the machine instance that should be used to run the code. If
	 *            null is given, a new one will be created.
	 */
	public Basic(String code, Machine machine) {
		this(code.split("\n"), machine);
	}

	/**
	 * Instantiates a new instance for a BASIC program. No
	 * interpretation/compilation will take place at this stage. This
	 * constructor takes an array of code lines as input. Each code line should
	 * represent a line in the BASIC program.
	 * 
	 * @param code
	 *            the basic code
	 */
	public Basic(String[] code) {
		this(code, null);
	}

	/**
	 * Instantiates a new instance for a BASIC program. No
	 * interpretation/compilation will take place at this stage. This
	 * constructor takes an array of code lines as input. Each code line should
	 * represent a line in the BASIC program.
	 * 
	 * @param code
	 *            the basic code
	 * @param machine
	 *            the machine instance that should be used to run the code. If
	 *            null is given, a new one will be created.
	 */
	public Basic(String[] code, Machine machine) {
		this.code = Arrays.copyOf(code, code.length);
		if (machine == null) {
			this.machine = new Machine();
		} else {
			this.machine = machine;
		}
	}

	/**
	 * Enables an experimental JIT-compiler with a default compile threshold of
	 * 0. This works only if the application runs on a JDK installation. It
	 * won't work with a JRE. A JIT might help to improve performance for
	 * complex calculations. If your program doesn't do these, it might not even
	 * kick in or the additional overhead might slow your program down. Keep in
	 * mind that compiling the code by the JIT takes some time as well. If the
	 * JIT compiler kicks in, you'll see some console output about it.
	 */
	public void enableJit() {
		machine.setJit(new Jit());
	}

	/**
	 * Enables an experimental JIT-compiler with a given compile threshold. This
	 * works only if the application runs on a JDK installation. It won't work
	 * with a JRE. One might have to play around with the threshold to find a
	 * value which actually speed up the application. If the threshold is <=0,
	 * then the JIT compiler will try to auto-detect when to compile. A JIT
	 * might help to improve performance for complex calculations. If your
	 * program doesn't do these, it might not even kick in or the additional
	 * overhead might slow your program down. Keep in mind that compiling the
	 * code by the JIT takes some time as well. If the JIT compiler kicks in,
	 * you'll see some console output about it.
	 * 
	 * @param compileThreshold
	 *            the compile threshold
	 */
	public void enableJit(int compileThreshold) {
		machine.setJit(new Jit(compileThreshold));
	}

	/**
	 * Static method to register a BASIC extension. This is static, because all
	 * registered extensions are available in all Basic instances. Adding an
	 * extension multiple times does no harm, but only the first added instance
	 * will be active. This version of the method takes an actual instance of
	 * the extension. If another instance of the same extension has already been
	 * added, nothing will happen.
	 * 
	 * @param extension
	 *            the extension instance to add
	 */
	public static void registerExtension(BasicExtension extension) {
		String name = extension.getClass().getName();
		if (!addedExtensions.containsKey(name)) {
			addedExtensions.put(name, extension);
			Logger.log(name + " registered as a BASIC extension!");
			CommandList.registerNewCommands(extension.getCommands());
			FunctionList.registerNewFunctions(extension.getFunctions());
		}
	}

	/**
	 * Static method to register a BASIC extension. This is static, because all
	 * registered extensions are available in all Basic instances. Adding an
	 * extension multiple times does no harm, but only the first added instance
	 * will be active. This version of the method takes the extension's class
	 * instead of an actual instance.
	 * 
	 * @param extension
	 *            the extension class to add
	 */
	public static void registerExtension(Class<? extends BasicExtension> clazz) {
		try {
			registerExtension(clazz.newInstance());
		} catch (Exception e) {
			throw new RuntimeException("Failed to register extension " + clazz);
		}
	}

	/**
	 * Returns all active instances of added extensions. If there are none, an
	 * empty will be returned.
	 * 
	 * @return the active extensions
	 */
	public static List<BasicExtension> getExtensions() {
		if (addedExtensions.size() == 0) {
			return new ArrayList<BasicExtension>();
		}
		return new ArrayList<BasicExtension>(addedExtensions.values());
	}

	/**
	 * Returns the BASIC code.
	 * 
	 * @return the code, one line per array element
	 */
	public String[] getCode() {
		return this.code;
	}

	/**
	 * Gets the machine.
	 * 
	 * @return the machine
	 */
	@Override
	public Machine getMachine() {
		return machine;
	}

	/**
	 * Sets a new machine.
	 * 
	 * @param machine
	 *            the new machine
	 */
	public void setMachine(Machine machine) {
		this.machine = machine;
	}

	/**
	 * Gets the machine's cpu. This cpu is used to execute machine language
	 * code, not for running basic programs.
	 * 
	 * @return
	 */
	@Override
	public Cpu getCpu() {
		return machine.getCpu();
	}

	/**
	 * Returns the compiled program wrapped into a PCode instance. This method
	 * isn't needed for normal usage.
	 * 
	 * @return the PCode instance
	 */
	public PCode getPCode() {
		return new PCode(lineNumbers, lines);
	}

	/**
	 * Gets the value of a string variable.
	 * 
	 * @param name
	 *            the name of the variable including the "$" postfix, case
	 *            doesn't matter
	 * @return the variable's value or null, if the variable doesn't exist
	 *         (yet).
	 */
	public String getStringVariable(String name) {
		Object obj = machine.getVariable(VarUtils.toUpper(name)).getValue();
		if (VarUtils.isString(obj)) {
			return (String) obj;
		}
		return null;
	}

	/**
	 * Gets the value of an integer variable.
	 * 
	 * @param name
	 *            the name of the variable including the "%" postfix, case
	 *            doesn't matter
	 * @return the variable's value or null, if the variable doesn't exist
	 *         (yet).
	 */
	public Integer getIntegerVariable(String name) {
		Object obj = machine.getVariable(VarUtils.toUpper(name)).getValue();
		if (VarUtils.isInteger(obj)) {
			return (Integer) obj;
		}
		return null;
	}

	/**
	 * Gets the value of a floating point variable.
	 * 
	 * @param name
	 *            the name of the variable, case doesn't matter
	 * @return the variable's value or null, if the variable doesn't exist
	 *         (yet).
	 */
	public Float getFloatVariable(String name) {
		Object obj = machine.getVariable(VarUtils.toUpper(name)).getValue();
		if (VarUtils.isFloat(obj)) {
			return (Float) obj;
		}
		return null;
	}

	/**
	 * Gets the value of an array variable. The actual datatype depends on the
	 * type of the variable and is either String, Integer or Float.
	 * 
	 * @param name
	 *            the name of the variable, [] postfix is optional, case doesn't
	 *            matter
	 * @return the variable's value or null, if the variable doesn't exist
	 *         (yet).
	 */
	@SuppressWarnings("unchecked")
	public Object[] getArrayVariable(String name) {
		if (!name.endsWith("[]")) {
			name = name + "[]";
		}
		Object obj = machine.getVariable(VarUtils.toUpper(name)).getValue();
		if (obj.getClass().isArray()) {
			return ((ArrayList<Object>) obj).toArray();
		}
		return null;
	}

	/**
	 * Compiles the code. This can be called before calling the actual run
	 * method to precompile the code. It doesn't have to though, because run()
	 * will call it on its own if needed.
	 */
	@Override
	public void compile(CompilerConfig config) {
		compile(config, true);
	}

	/**
	 * Compiles the code. This can be called before calling the actual run
	 * method to precompile the code. It doesn't have to though, because run()
	 * will call it on its own if needed.
	 * 
	 * @param resetMachine
	 *            if true, the compile will happen on a clean machine. If false,
	 *            it it will reuse existing variable definitions
	 */
	public void compile(CompilerConfig config, boolean resetMachine) {
		long start = System.nanoTime();
		if (resetMachine) {
			machine.resetMemory();
		}
		machine.clearCommandList();
		Line cl = null;
		int lastLineNumber = -1;
		lines.clear();
		lineNumbers.clear();
		for (String line : code) {
			try {
				line = line.replaceAll("^\\s+", "");
				if (line.isEmpty()) {
					continue;
				}
				cl = Line.getLine(line);
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
				    	int loops=0;
					do {
						if (part.trim().length() > 0) {
							Command command = Parser.getCommand(part);
							if (command == null) {
								throw new RuntimeException("Syntax error: " + cl.getNumber() + " " + cl.getLine());
							}
							if (!command.keepSpaces()) {
								part = TermEnhancer.removeWhiteSpace(part);
							}
							part = command.parse(config, part, lineCnt, cl.getNumber(), pos, (pos == parts.length - 1), machine);

							machine.addCommand(command);
							cl.addCommand(command);
							
							if (command instanceof Let && loops>0) {
							    // If it's a LET after an IF, it must not be counted as a single assignment, because it might not happen at all.
							    // This doesn't take assignments after (conditional) jumps into account, but...well...
							    machine.trackVariableUsage(((Let) command).getVar(), false);
							}
							
							pos++;
							loops++;
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
				machine.getOutputChannel().systemPrintln(0, err);
				throw t;
			}
		}

		modifyDelayLoops(config);

		compiled = true;
		Logger.log(machine.getCommandList().size() + " commands compiled in: " + (System.nanoTime() - start) / 1000000L + "ms");
	}

	/**
	 * Starts a previously compiled BASIC program. This method is similar to
	 * run() with the exception that it requires the code to be compiled
	 * already. If it isn't, it will exit with a RuntimeException. This can be
	 * useful, it you want to re-run the same program multiple times without
	 * compiling it over and over again.
	 */
	@Override
	public void start(CompilerConfig config) {
		stop = false;
		if (!compiled) {
			throw new RuntimeException("Code not compiled! Either call compile();start(); or run()!");
		}
		runInternal(config);
	}

	/**
	 * Runs the program. If needed, this will call compile() as well. This will
	 * wipe the memory clear and resets all variables as well. If you don't want
	 * this, use start() instead or call compile() before calling run().
	 */
	@Override
	public void run(CompilerConfig config) {
		stop = false;
		if (!compiled) {
			compile(config);
		}
		if (compiled) {
			runInternal(config);
			compiled = false;
		} else {
			machine.getOutputChannel().systemPrintln(0, "\nREADY.");
		}
	}

	/**
	 * Executes a single command in the context of this instance's machine.
	 * Please note that this might happen in parallel with another command of
	 * the actual problem, so depending on the given command, this can have some
	 * side effects at runtime.
	 * 
	 * @param cmd
	 *            the command to execute
	 */
	public void executeSingleCommand(CompilerConfig config, String cmd) {
		if (cmd == null || cmd.isEmpty()) {
			return;
		}
		Command command = Parser.getCommand(cmd.trim());
		if (command == null) {
			throw new RuntimeException("Syntax error: " + cmd);
		}
		if (!command.keepSpaces()) {
			cmd = TermEnhancer.removeWhiteSpace(cmd);
		}
		command.parse(config, cmd, 0, 0, 0, false, machine);
		command.execute(config, machine);
	}

	/**
	 * Resets the memory. This will clean the 64KB of main memory as well as all
	 * variables.
	 */
	public void resetMemory() {
		machine.resetMemory();
	}

	/**
	 * Stops a currently running program after the next commands has been
	 * executed.
	 */
	@Override
	public void runStop() {
		paused = false;
		stop = true;
	}

	/**
	 * Returns the RAM's content. The RAM is a representation of 64KB of 8bit
	 * wide memory. However, the returned array is of type int[]. It will
	 * contains values in the range of[0..255] only though.
	 * 
	 * @return the RAM
	 */
	@Override
	public int[] getRam() {
		return machine.getRam();
	}

	/**
	 * Returns the input provider. The input provider implements the methods for
	 * reading keyboard input. The default implementation is based on the Java
	 * console, which has only limited support for reading single key strokes.
	 * 
	 * @return the input provider
	 */
	public InputProvider getInputProvider() {
		return machine.getInputProvider();
	}

	/**
	 * Returns the input provider. The input provider implements the methods for
	 * reading keyboard input. The default implementation is based on the Java
	 * console, which has only limited support for reading single key strokes.
	 * 
	 * @param inputProvider
	 *            the new input provider
	 */
	public void setInputProvider(InputProvider inputProvider) {
		machine.setInputProvider(inputProvider);
	}

	/**
	 * Returns the output channel. By default, this is the console.
	 * 
	 * @return the output channel
	 */
	public OutputChannel getOutputChannel() {
		return machine.getOutputChannel();
	}

	/**
	 * Sets the output channel. By default, this is the console.
	 * 
	 * @param outputChannel
	 *            the new output channel
	 */
	public void setOutputChannel(OutputChannel outputChannel) {
		machine.setOutputChannel(outputChannel);
	}

	/**
	 * Returns the system call listener. The system call listener listens for
	 * SYS calls of the program. The default implementation just ignores these
	 * calls.
	 * 
	 * @return the system call listener
	 */
	public SystemCallListener getSystemCallListener() {
		return machine.getSystemCallListener();
	}

	/**
	 * Sets the system call listener. The system call listener listens for SYS
	 * calls of the program. The default implementation just ignores these
	 * calls.
	 * 
	 * @param scl
	 *            the new system call listener
	 */
	public void setSystemCallListener(SystemCallListener scl) {
		machine.setSystemCallListener(scl);
	}

	/**
	 * Returns the memory listener. The memory listener listens for PEEKs and
	 * POKEs. In addition to reading from/writing to the RAM, which happens
	 * anyway, the listener method get called for each PEEK or POKE. The default
	 * implementation does nothing.
	 * 
	 * @return the memory listener
	 */
	public MemoryListener getMemoryListener() {
		return machine.getMemoryListener();
	}

	/**
	 * Sets the memory listener. The memory listener listens for PEEKs and
	 * POKEs. In addition to reading from/writing to the RAM, which happens
	 * anyway, the listener method get called for each PEEK or POKE. The default
	 * implementation does nothing.
	 * 
	 * @param memoryListener
	 *            the new memory listener
	 */
	public void setMemoryListener(MemoryListener memoryListener) {
		machine.setMemoryListener(memoryListener);
	}

	/**
	 * Returns true, if line numbers should be printed out at runtime.
	 * 
	 * @return true, if yes. Default is false.
	 */
	public boolean isPrintLineNumbers() {
		return printLineNumbers;
	}

	/**
	 * If set to true, the current line number will be printed out at runtime.
	 * 
	 * @param printLineNumbers
	 *            Should line numbers be printed out?
	 */
	public void setPrintLineNumbers(boolean printLineNumbers) {
		this.printLineNumbers = printLineNumbers;
	}

	/**
	 * Pauses/resumes the program
	 * 
	 * @param paused
	 *            true for pause, false for resume
	 */
	public void setPause(boolean paused) {
		this.paused = paused;
	}

	/**
	 * Is the program paused?
	 * 
	 * @return is it?
	 */
	public boolean isPaused() {
		return paused;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.ProgramExecutor#isRunning()
	 */
	@Override
	public boolean isRunning() {
		return running;
	}

	/**
	 * Gets the current Tracer or null if none has been set.
	 * 
	 * @return the Tracer or null
	 */
	public Tracer getTracer() {
		return tracer;
	}

	/**
	 * Sets a new Tracer
	 * 
	 * @param tracer
	 *            the tracer
	 */
	public void setTracer(Tracer tracer) {
		this.tracer = tracer;
	}

	/**
	 * Sets a new code enhancer instance.
	 * 
	 * @return the new code enhancer
	 */
	public CodeEnhancer getCodeEnhancer() {
		return codeEnhancer;
	}

	/**
	 * Returns the current code enhancer instance.
	 * 
	 * @param codeEnhancer
	 *            the instance
	 */
	public void setCodeEnhancer(CodeEnhancer codeEnhancer) {
		this.codeEnhancer = codeEnhancer;
	}

	/**
   */
	private void runInternal(CompilerConfig config) {
		long start = System.nanoTime();
		if (codeEnhancer != null) {
			String cmd = codeEnhancer.getFirstCommand();
			executeSingleCommand(config, cmd);
		}
		execute(config, 0, 0);
		if (codeEnhancer != null) {
			String cmd = codeEnhancer.getLastCommand();
			executeSingleCommand(config, cmd);
		}
		long end = System.nanoTime();
		machine.getOutputChannel().systemPrintln(0, "\nREADY. (" + ((end - start) / 1000000L) + "ms)");
	}

	/**
	 * @param lineCnt
	 *            the line cnt
	 * @param pos
	 *            the pos
	 */
	private void execute(CompilerConfig config, int lineCnt, int pos) {
		if (lineNumbers.size() == 0) {
			return;
		}
		Integer num = null;
		running = true;
		if (tracer != null) {
			tracer.start(this);
		}
		try {
			do {
				num = lineNumbers.get(lineCnt);
				if (printLineNumbers) {
					Logger.log("[" + num + "]");
				}
				Line line = lines.get(num);

				for (int i = pos; i < line.getCommands().size(); i++) {

					if (stop) {
						break;
					}

					while (paused) {
						try {
							Thread.sleep(1);
						} catch (InterruptedException e) {
							//
						}
					}

					Command command = line.getCommands().get(i);
					machine.setCurrentCommand(command);
					BasicProgramCounter pc = command.execute(config, machine);
					if (tracer != null) {
						tracer.commandExecuted(this, command, num, i);
					}
					machine.setCurrentCommand(null);
					if (pc != null) {
						if (pc.isEnd() || pc.isStop()) {
							lineCnt = lines.size();
							if (pc.isStop()) {
								stop = true;
							}
							break;
						}
						if (pc.isList()) {
							for (String cl : code) {
								this.machine.getOutputChannel().systemPrintln(0, cl);
							}
						} else {
							if (pc.isSkip()) {
								break;
							}
							if (pc.getLineNumber() == -1) {
								// Line index is unknown (FOR...NEXT/RETURN/RUN
								// w/o line)
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
			} while (lineCnt < lines.size() && !stop);
			if (stop) {
				machine.getOutputChannel().systemPrintln(0, "\nBREAK IN " + num);
			}
		} catch (Throwable t) {
			String msg = t.getMessage();
			String err = "Error in line " + (num != null ? num : "??") + (msg != null ? (": " + msg) : "");
			machine.getOutputChannel().systemPrintln(0, err);
			running = false;
			throw t;
		} finally {
			if (tracer != null) {
				tracer.stop(this);
			}
		}
		running = false;
	}

	/**
	 * Modifies loops according to the corresponding setting in the
	 * CompilerConfig. Usually, there's no need to call this method directly.
	 * 
	 * @param config
	 *            the config
	 */
	public void modifyDelayLoops(CompilerConfig config) {
		LoopMode loopMode = config.getLoopMode();
		if (loopMode == null || loopMode == LoopMode.EXECUTE) {
			return;
		}

		int forLine = -1;
		int nextLine = -1;
		int forPos = -1;
		int nextPos = -1;
		Command forCmd = null;
		for (Integer num : lineNumbers) {
			Line line = lines.get(num);
			int cnt = 0;
			for (Command cmd : line.getCommands()) {
				if (forLine == -1) {
					if (cmd instanceof For) {
						forLine = num;
						forPos = cnt;
						forCmd = cmd;
						// System.out.println("For found: "+num+"/"+cnt);
					}
				} else {
					if (cmd instanceof Rem) {
						// System.out.println("Re, found: "+num+"/"+cnt);
						continue;
					} else if (cmd instanceof Next) {
						nextLine = num;
						nextPos = cnt;
						// System.out.println("Next found: "+num+"/"+cnt);
					} else {
						forLine = -1;
						nextLine = -1;
						forPos = -1;
						nextPos = -1;
						forCmd = null;
						// System.out.println("??? found: "+num+"/"+cnt);
					}
				}

				if (forLine != -1 && nextLine != -1) {
					lines.get(forLine).getCommands().set(forPos, new Delay((For) forCmd, loopMode == LoopMode.DELAY));
					lines.get(nextLine).getCommands().set(nextPos, new Rem());
					Logger.log("Replaced for-loop at line " + forLine + " with " + (loopMode == LoopMode.DELAY ? "a delay" : "an empty operation!"));
					forLine = -1;
					nextLine = -1;
					forPos = -1;
					nextPos = -1;
					forCmd = null;
				}

				cnt++;
			}
		}
	}

	/**
	 * Removes all the commands in the list from the program by replacing them
	 * with NOPs (i.e. instances of REM).
	 * 
	 * @param toRemove
	 *            the commands to remove
	 */
	public void removeCommands(List<Command> toRemove) {
		this.machine.removeCommands(toRemove);

		Set<Command> remSet = new HashSet<Command>(toRemove);

		Integer num = null;
		int lineCnt = 0;
		int pos = 0;

		do {
			num = lineNumbers.get(lineCnt);
			Line line = lines.get(num);

			List<Command> cmds = line.getCommands();
			for (int i = pos; i < cmds.size(); i++) {
				Command cmd = cmds.get(i);
				if (remSet.contains(cmd)) {
					cmds.set(i, new Rem());
					Logger.log("Eliminated dead store to " + ((Let) cmd).getVar().getUpperCaseName() + " from line " + num);
				}
			}
			lineCnt++;
		} while (lineCnt < lines.size() && !stop);

	}
}
