package sixtyfour.parser;

import java.util.ArrayList;
import java.util.List;

import sixtyfour.elements.commands.Command;

public class Line {
	private String line;
	private int number;
	private int count;
	private List<Command> commands = new ArrayList<Command>();

	public Line(int number, String line) {
		this.line = line;
		this.number = number;
	}

	public String getLine() {
		return line;
	}

	public int getNumber() {
		return number;
	}

	public void addCommand(Command command) {
		commands.add(command);
	}

	public List<Command> getCommands() {
		return commands;
	}

	public void setCommands(List<Command> commands) {
		this.commands = commands;
	}

	@Override
	public String toString() {
		return number + " " + line;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

}
