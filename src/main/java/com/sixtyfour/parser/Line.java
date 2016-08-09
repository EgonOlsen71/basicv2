/*
 * 
 */
package com.sixtyfour.parser;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.elements.commands.Command;

/**
 * The Class Line.
 */
public class Line {

	/** The line. */
	private String line;

	/** The number. */
	private int number;

	/** The count. */
	private int count;

	/** The commands. */
	private List<Command> commands = new ArrayList<Command>();

	/**
	 * Instantiates a new line.
	 * 
	 * @param number
	 *            the number
	 * @param line
	 *            the line
	 */
	public Line(int number, String line) {
		this.line = line;
		this.number = number;
	}

	/**
	 * Adds the dummy remark.
	 */
	public void addDummyRemark() {
		// Just to ease parsing of data commands (because that's the only command
		// where spaces at the end might matter)
		line += "REM";
	}

	/**
	 * Gets the line.
	 * 
	 * @return the line
	 */
	public String getLine() {
		return line;
	}

	/**
	 * Gets the number.
	 * 
	 * @return the number
	 */
	public int getNumber() {
		return number;
	}

	/**
	 * Adds the command.
	 * 
	 * @param command
	 *            the command
	 */
	public void addCommand(Command command) {
		commands.add(command);
	}

	/**
	 * Gets the commands.
	 * 
	 * @return the commands
	 */
	public List<Command> getCommands() {
		return commands;
	}

	/**
	 * Sets the commands.
	 * 
	 * @param commands
	 *            the new commands
	 */
	public void setCommands(List<Command> commands) {
		this.commands = commands;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return number + " " + line;
	}

	/**
	 * Gets the count.
	 * 
	 * @return the count
	 */
	public int getCount() {
		return count;
	}

	/**
	 * Sets the count.
	 * 
	 * @param count
	 *            the new count
	 */
	public void setCount(int count) {
		this.count = count;
	}

}
