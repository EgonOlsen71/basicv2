package com.sixtyfour.parser;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.elements.commands.Command;

/**
 * A line in BASIC program.
 */
public class Line {

	/** The text content of the line */
	private String line;

	/** The line number */
	private int number;

	/** The line's position */
	private int count;

	/** The commands in this line in order of appearance */
	private List<Command> commands = new ArrayList<Command>();

	/**
	 * Instantiates a new line.
	 * 
	 * @param number
	 *            the line number
	 * @param line
	 *            the line's content
	 */
	public Line(int number, String line) {
		this.line = line;
		this.number = number;
	}

	/**
	 * Creates a new Line instance based on a line of the BASIC program,
	 * 
	 * @param line
	 *            the line as text
	 * @return the line instance
	 */
	public static Line getLine(String line) {
		for (int i = 0; i < line.length(); i++) {
			char c = line.charAt(i);
			if (!Character.isDigit(c)) {
				return new Line(Integer.parseInt(line.substring(0, i)), line.substring(i).trim());
			}
		}
		throw new RuntimeException("No line number found in: " + line);
	}

	/**
	 * Adds the dummy remark to lines that end with a : only. This eases parsing
	 * the line later.
	 */
	public void addDummyRemark() {
		// Just to ease parsing of data commands (because that's the only
		// command
		// where spaces at the end might matter)
		line += "REM";
	}

	/**
	 * Returns the line's text content.
	 * 
	 * @return the text
	 */
	public String getLine() {
		return line;
	}

	/**
	 * Returns the line number.
	 * 
	 * @return the line number
	 */
	public int getNumber() {
		return number;
	}

	/**
	 * Adds the command to the list of commands of this line.
	 * 
	 * @param command
	 *            the command to add
	 */
	public void addCommand(Command command) {
		commands.add(command);
	}

	/**
	 * Return all the commands in this line in the order in which they have been
	 * added. This returns a direct reference to the internal list.
	 * 
	 * @return the commands
	 */
	public List<Command> getCommands() {
		return commands;
	}

	/**
	 * Returns the count/position of this line in the BASIC program.
	 * 
	 * @return the count
	 */
	public int getCount() {
		return count;
	}

	/**
	 * Sets the count of this line in the BASIC program.
	 * 
	 * @param count
	 *            the count
	 */
	public void setCount(int count) {
		this.count = count;
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

}
