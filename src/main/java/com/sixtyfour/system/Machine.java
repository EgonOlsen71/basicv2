package com.sixtyfour.system;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Stack;

import com.sixtyfour.Basic;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.For;
import com.sixtyfour.elements.systemvars.Pie;
import com.sixtyfour.elements.systemvars.Status;
import com.sixtyfour.elements.systemvars.Time;
import com.sixtyfour.elements.systemvars.TimeDate;
import com.sixtyfour.extensions.BasicExtension;
import com.sixtyfour.parser.Operator;
import com.sixtyfour.plugins.DeviceProvider;
import com.sixtyfour.plugins.InputProvider;
import com.sixtyfour.plugins.MemoryListener;
import com.sixtyfour.plugins.OutputChannel;
import com.sixtyfour.plugins.SystemCallListener;
import com.sixtyfour.plugins.impl.ConsoleInputProvider;
import com.sixtyfour.plugins.impl.ConsoleOutputChannel;
import com.sixtyfour.plugins.impl.MemoryDeviceProvider;
import com.sixtyfour.plugins.impl.NullMemoryListener;
import com.sixtyfour.plugins.impl.NullSystemCallListener;
import com.sixtyfour.util.VarUtils;

/**
 * The machine. In the context of this application, Machine is the closest that
 * you'll get to a real hardware device. Machine wraps the 64KB of memory, the
 * variable memory (which is, unlike in a real machine, decoupled from the 64KB
 * of memory), input and output "devices" and such...
 */
public class Machine {

	/** The variables */
	private Map<String, Variable> vars = new HashMap<String, Variable>();

	/** The RAM */
	private int[] ram = new int[65536];

	/** The Stack */
	private Stack<StackEntry> stack = new Stack<StackEntry>();

	/** The command list */
	private List<Command> commandList = new ArrayList<Command>();

	/** The current command */
	private Command currentCommand = null;

	/** The current operator */
	private Operator currentOperator = null;

	/** The functions */
	private Map<String, Command> functions = new HashMap<String, Command>();

	/** The data storage */
	private DataStore data = new DataStore();

	/** The output channel */
	private OutputChannel outputChannel = null;

	/** The input provider */
	private InputProvider inputProvider = null;

	/** The memory listener */
	private MemoryListener memoryListener = null;

	/** The system call listener */
	private SystemCallListener systemCallListener = null;

	/** The device provider */
	private DeviceProvider deviceProvider = null;

	private Cpu cpu = null;

	/**
	 * Instantiates a new machine.
	 */
	public Machine() {
		inputProvider = new ConsoleInputProvider();
		outputChannel = new ConsoleOutputChannel();
		memoryListener = new NullMemoryListener();
		deviceProvider = new MemoryDeviceProvider(outputChannel);
		setSystemCallListener(new NullSystemCallListener());
		addDefaults();
		this.cpu = new Cpu(this);
	}

	/**
	 * Sets/adds a function. A function is defined in the BASIC program by the
	 * DEF FN command.
	 * 
	 * @param name
	 *            the name of the function
	 * @param function
	 *            the function
	 */
	public void setFunction(String name, Command function) {
		functions.put(name, function);
	}

	/**
	 * Returns a function.
	 * 
	 * @param name
	 *            the name of the function
	 * @return the function
	 */
	public Command getFunction(String name) {
		return functions.get(name);
	}

	/**
	 * Returns the RAM's content. The RAM is a representation of 64KB of 8bit
	 * wide memory. However, the returned array is of type int[]. It will
	 * contains values in the range of[0..255] only though.
	 * 
	 * @return the RAM
	 */
	public int[] getRam() {
		return ram;
	}

	/**
	 * Pushes a command onto the stack.
	 * 
	 * @param command
	 *            the command
	 */
	public void push(Command command) {
		if (stack.size() > 10000) {
			throw new RuntimeException("Out of memory error, stack size exceeds 10000!");
		}
		stack.push(new StackEntry(command));
	}

	/**
	 * Pushes a FOR command onto the stack.
	 * 
	 * @param fory
	 *            the FOR command
	 */
	public void pushFor(For fory) {
		if (stack.size() > 10000) {
			for (int i = 0; i < stack.size(); i++) {
				StackEntry se = stack.get(i);
				if (se.isSubroutineCall()) {
					System.out.println(se.getCommand());
				}
			}
			throw new RuntimeException("Out of memory error, stack size exceeds 10000!");
		}

		// Remove a for with the same variable and all later ones from the stack
		for (int i = 0; i < stack.size(); i++) {
			StackEntry cmd = stack.get(i);
			if (cmd.isFor()) {
				if (((For) cmd.getCommand()).getVar().equals(fory.getVar())) {
					popFor((For) cmd.getCommand());
					break;
				}
			}
		}

		// System.out.println(stack.size()+"/"+fory.getVar());
		stack.push(new StackEntry(fory));
	}

	/**
	 * Pop a FOR command from the stack. All later FOR commands will be popped
	 * as well.
	 * 
	 * @param fory
	 *            the FOR command
	 * @return the popped command
	 */
	public For popFor(For fory) {
		List<StackEntry> toRemove = new ArrayList<StackEntry>();
		for (int i = stack.size() - 1; i >= 0; i--) {
			StackEntry entry = stack.get(i);
			if (entry.getCommand() == fory) {
				for (int p = stack.size() - 1; p >= i; p--) {
					entry = stack.get(i);
					if (entry.isFor()) {
						toRemove.add(entry);
					}
				}
				stack.removeAll(toRemove);
				return (For) entry.getCommand();
			}
		}
		return null;
	}

	/**
	 * Peeks on the stack for variable of a certain name and returns the
	 * macthing FOR command if any.
	 * 
	 * @param varName
	 *            the variable name
	 * @return the corresponding FOR
	 */
	public For peekFor(String varName) {
		for (int i = stack.size() - 1; i >= 0; i--) {
			StackEntry entry = stack.get(i);
			if (entry.isFor() && (varName == null || varName.equalsIgnoreCase(((For) entry.getCommand()).getVar().getName()))) {
				return (For) entry.getCommand();
			}
		}
		return null;
	}

	/**
	 * Gets the stack entry of the last GOSUB, if there was any.
	 * 
	 * @return the calling GOSUB
	 */
	public StackEntry getCaller() {
		for (int i = stack.size() - 1; i >= 0; i--) {
			StackEntry entry = stack.get(i);
			if (entry.isSubroutineCall()) {
				int end = stack.size();
				for (int p = 0; p < end - i; p++) {
					stack.pop();
				}
				return entry;
			}
		}
		return null;
	}

	/**
	 * Peeks on the last element of the stack.
	 * 
	 * @return the most current stack entry
	 */
	public StackEntry peek() {
		return stack.peek();
	}

	/**
	 * Pops the stack
	 * 
	 * @return the popped stack entry
	 */
	public StackEntry pop() {
		if (stack.isEmpty()) {
			throw new RuntimeException("Out of memory error, stack is empty!");
		}
		return stack.pop();
	}

	/**
	 * Resets the memory. This will clean the 64KB of main memory as well as all
	 * variables. It will not reset the cpu.
	 */
	public void resetMemory() {
		for (int i = 0; i < ram.length; i++) {
			ram[i] = 0;
		}
		clearVars();
		for (BasicExtension ex : Basic.getExtensions()) {
			ex.reset(this);
		}
	}

	/**
	 * Clears all variables.
	 */
	public void clearVars() {
		for (Variable var : vars.values()) {
			var.clear();
		}
		addDefaults();
		stack.clear();
	}

	/**
	 * Adds a variable and returns it. If a variable of that name already
	 * exists, nothing will be added and the old variable will be returned
	 * instead.
	 * 
	 * @param var
	 *            the variable
	 * @return either the newly added variable or the old one with the same name
	 */
	public Variable add(Variable var) {
		Variable ret = getVariableUpperCase(var.getUpperCaseName());
		if (ret == null) {
			vars.put(var.getUpperCaseName(), var);
			ret = var;
		}
		return ret;
	}

	/**
	 * The same as add, this in addition, it will set the value of the new
	 * variable to the old one, if it finds it.
	 * 
	 * @param var
	 *            the variable
	 * @return either the newly added variable or the old one with the same name
	 */
	public Variable addOrSet(Variable var) {
		Variable ret = getVariableUpperCase(var.getUpperCaseName());
		if (ret == null) {
			vars.put(var.getUpperCaseName(), var);
			ret = var;
		} else {
			ret.setValue(var.getValue());
		}
		return ret;
	}

	/**
	 * Returns the variable with the given name. Case doesn't matter.
	 * 
	 * @param name
	 *            the name of the variable
	 * @return the variable or null, if it doesn't exist
	 */
	public Variable getVariable(String name) {
		if (name == null) {
			throw new RuntimeException("Null variable found!");
		}
		name = VarUtils.toUpper(name);
		return vars.get(name);
	}

	/**
	 * Returns the variable with the given name in upper case.
	 * 
	 * @param name
	 *            in upper case
	 * @return the variable or null, if it doesn't exist
	 */
	public Variable getVariableUpperCase(String name) {
		return vars.get(name);
	}

	/**
	 * Adds a command to the internal command list. This list is more kept for
	 * reference reasons rather than for actual runtime reasons.
	 * 
	 * @param command
	 *            the command
	 */
	public void addCommand(Command command) {
		commandList.add(command);
	}

	/**
	 * Returns the command list. This list contains all the commands of the
	 * BASIC program in order of parsing.
	 * 
	 * @return the command list
	 */
	public List<Command> getCommandList() {
		return commandList;
	}

	/**
	 * Sets the command list.
	 * 
	 * @param commandList
	 *            the new command list
	 */
	public void setCommandList(List<Command> commandList) {
		this.commandList = commandList;
	}

	/**
	 * Clears the command list.
	 */
	public void clearCommandList() {
		this.commandList.clear();
	}

	/**
	 * Returns the current command. This is the command that the runtime
	 * currently executes.
	 * 
	 * @return the current command
	 */
	public Command getCurrentCommand() {
		return currentCommand;
	}

	/**
	 * Sets the current command. This is the command that the runtime currently
	 * executes.
	 * 
	 * @param currentCommand
	 *            the new current command
	 */
	public void setCurrentCommand(Command currentCommand) {
		this.currentCommand = currentCommand;
	}

	/**
	 * Returns the current operator. This is the operator that the runtime
	 * currently works on.
	 * 
	 * @return the current operator
	 */
	public Operator getCurrentOperator() {
		return currentOperator;
	}

	/**
	 * Sets the current operator. This is the operator that the runtime
	 * currently works on.
	 * 
	 * @param currentOperator
	 *            the new current operator
	 */
	public void setCurrentOperator(Operator currentOperator) {
		this.currentOperator = currentOperator;
	}

	/**
	 * Returns the output channel. By default, this is the console.
	 * 
	 * @return the output channel
	 */
	public OutputChannel getOutputChannel() {
		return outputChannel;
	}

	/**
	 * Sets the output channel. By default, this is the console.
	 * 
	 * @param outputChannel
	 *            the new output channel
	 */
	public void setOutputChannel(OutputChannel outputChannel) {
		this.outputChannel = outputChannel;
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
		return memoryListener;
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
		this.memoryListener = memoryListener;
	}

	/**
	 * Returns the input provider. The input provider implements the methods for
	 * reading keyboard input. The default implementation is based on the Java
	 * console, which has only limited support for reading single key strokes.
	 * 
	 * @return the input provider
	 */
	public InputProvider getInputProvider() {
		return inputProvider;
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
		this.inputProvider = inputProvider;
	}

	/**
	 * Returns the data store. The data store contains the data stored in the
	 * program's DATA lines.
	 * 
	 * @return the data store
	 */
	public DataStore getDataStore() {
		return data;
	}

	/**
	 * Sets the data store. The data store contains the data stored in the
	 * program's DATA lines.
	 * 
	 * @param data
	 *            the new data store
	 */
	public void setDataStore(DataStore data) {
		this.data = data;
	}

	/**
	 * Returns the system call listener. The system call listener listens for
	 * SYS calls of the program. The default implementation just ignores these
	 * calls.
	 * 
	 * @return the system call listener
	 */
	public SystemCallListener getSystemCallListener() {
		return systemCallListener;
	}

	/**
	 * Sets the system call listener. The system call listener listens for SYS
	 * calls of the program. The default implementation just ignores these
	 * calls.
	 * 
	 * @param scl
	 *            the new system call listener
	 */
	public void setSystemCallListener(SystemCallListener systemCallListener) {
		this.systemCallListener = systemCallListener;
	}

	/**
	 * Returns the device provider. This is used to mimic the functionality of
	 * disc and tape drives and such. The default implementation provides basic
	 * support for disc and tape operation in memory.
	 * 
	 * @return the device provider
	 */
	public DeviceProvider getDeviceProvider() {
		return deviceProvider;
	}

	/**
	 * Sets the device provider. This is used to mimic the functionality of disc
	 * and tape drives and such. The default implementation provides basic
	 * support for disc and tape operation in memory.
	 * 
	 * @param deviceProvider
	 *            the new device provider
	 */
	public void setDeviceProvider(DeviceProvider deviceProvider) {
		this.deviceProvider = deviceProvider;
	}

	/**
	 * Returns the cpu that this machine uses for executing assembler (NOT
	 * BASIC) programs.
	 * 
	 * @return the cpu
	 */
	public Cpu getCpu() {
		return cpu;
	}

	/**
	 * Copies a program's binary content in this machine's memory.
	 * 
	 * @param prg
	 *            the program
	 */
	public void putProgram(Program prg) {
		List<ProgramPart> parts = prg.getParts();
		for (ProgramPart part : parts) {
			int[] bin = part.getBytes();
			System.arraycopy(bin, 0, this.getRam(), part.getAddress(), bin.length);
		}
	}

	/**
	 * Adds the default variables
	 */
	private void addDefaults() {
		add(new Pie());
		add(new Time());
		add(new TimeDate());
		add(new Status());
	}
}
