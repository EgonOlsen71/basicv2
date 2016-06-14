package sixtyfour.system;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Stack;

import sixtyfour.elements.Variable;
import sixtyfour.elements.commands.Command;
import sixtyfour.elements.systemvars.Status;
import sixtyfour.elements.systemvars.Time;
import sixtyfour.elements.systemvars.TimeDate;
import sixtyfour.parser.Operator;
import sixtyfour.plugins.ConsoleInputProvider;
import sixtyfour.plugins.InputProvider;

public class Machine {
	private Map<String, Variable> vars = new HashMap<String, Variable>();
	private int[] ram = new int[65536];
	private Stack<StackEntry> stack = new Stack<StackEntry>();
	private List<Command> commandList = new ArrayList<Command>();
	private Command currentCommand = null;
	private Operator currentOperator = null;
	private OutputChannel outputChannel = null;
	private Map<String, Command> functions = new HashMap<String, Command>();
	private InputProvider inputProvider = new ConsoleInputProvider();
	
	public Machine() {
		outputChannel = new OutputChannel();
		addDefaults();
	}

	public void setFunction(String name, Command function) {
		functions.put(name, function);
	}

	public Command getFunction(String name) {
		return functions.get(name);
	}

	public int[] getRam() {
		return ram;
	}

	public void push(Command command) {
		if (stack.size() > 10000) {
			throw new RuntimeException("Out of memory error, stack size exceeds 10000!");
		}
		stack.push(new StackEntry(command));
	}

	public StackEntry getCaller() {
		for (int i = stack.size() - 1; i >= 0; i--) {
			StackEntry entry = stack.get(i);
			if (entry.isSubroutineCall()) {
				for (int p = 0; p < stack.size() - i; p++) {
					stack.pop();
				}
				return entry;
			}
		}
		return null;
	}

	public StackEntry peek() {
		return stack.peek();
	}

	public StackEntry pop() {
		if (stack.isEmpty()) {
			throw new RuntimeException("Out of memory error, stack is empty!");
		}
		return stack.pop();
	}

	public void reset() {
		for (int i = 0; i < ram.length; i++) {
			ram[i] = 0;
		}
		for (Variable var : vars.values()) {
			var.clear();
		}
		addDefaults();
		stack.clear();
	}

	public Variable add(Variable var) {
		Variable ret = getVariable(var.getName());
		if (ret == null) {
			vars.put(var.getName(), var);
			ret = var;
		}
		return ret;
	}

	public Variable getVariable(String name) {
		if (name == null) {
			throw new RuntimeException("Null variable found!");
		}
		name = name.toUpperCase(Locale.ENGLISH);
		return vars.get(name);
	}

	public void addCommand(Command command) {
		commandList.add(command);
	}

	public List<Command> getCommandList() {
		return commandList;
	}

	public void setCommandList(List<Command> commandList) {
		this.commandList = commandList;
	}

	public Command getCurrentCommand() {
		return currentCommand;
	}

	public void setCurrentCommand(Command currentCommand) {
		this.currentCommand = currentCommand;
	}

	public Operator getCurrentOperator() {
		return currentOperator;
	}

	public void setCurrentOperator(Operator currentOperator) {
		this.currentOperator = currentOperator;
	}

	public OutputChannel getOutputChannel() {
		return outputChannel;
	}

	public void setOutputChannel(OutputChannel outputChannel) {
		this.outputChannel = outputChannel;
	}

	private void addDefaults() {
		add(new Variable("Π", (float) Math.PI));
		add(new Time());
		add(new TimeDate());
		add(new Status());
	}

	public InputProvider getInputProvider() {
		return inputProvider;
	}

	public void setInputProvider(InputProvider inputProvider) {
		this.inputProvider = inputProvider;
	}
}