package sixtyfour.system;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Stack;

import sixtyfour.elements.Variable;
import sixtyfour.elements.commands.Command;
import sixtyfour.parser.Operator;

public class Machine {
	private Map<String, Variable> vars = new HashMap<String, Variable>();
	private int[] ram = new int[65536];
	private Stack<StackEntry> stack = new Stack<StackEntry>();
	private List<Command> commandList = new ArrayList<Command>();
	private Command currentCommand = null;
	private Operator currentOperator = null;
	private OutputChannel outputChannel = null;

	public Machine() {
		outputChannel = new OutputChannel();
	}

	public int[] getRam() {
		return ram;
	}

	public void push(Command command) {
		if (stack.size() > 1000) {
			throw new RuntimeException("Out of memory error, stack size exceeds 1000!");
		}
		stack.push(new StackEntry(command));
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
}
