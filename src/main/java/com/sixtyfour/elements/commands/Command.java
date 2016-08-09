package com.sixtyfour.elements.commands;

import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Term;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.ProgramCounter;

/**
 * The Interface Command.
 */
public interface Command extends Atom {

	/**
	 * Keep spaces.
	 * 
	 * @return true, if successful
	 */
	boolean keepSpaces();

	/**
	 * Gets the name.
	 * 
	 * @return the name
	 */
	String getName();

	/**
	 * Checks if is command.
	 * 
	 * @param command
	 *            the command
	 * @return true, if is command
	 */
	boolean isCommand(String command);

	/**
	 * Clone.
	 * 
	 * @param linePart
	 *            the line part
	 * @return the command
	 */
	Command clone(String linePart);

	/**
	 * Gets the term.
	 * 
	 * @return the term
	 */
	Term getTerm();

	/**
	 * Sets the term.
	 * 
	 * @param term
	 *            the new term
	 */
	void setTerm(Term term);

	/**
	 * Parses the.
	 * 
	 * @param linePart
	 *            the line part
	 * @param lineCnt
	 *            the line cnt
	 * @param lineNumber
	 *            the line number
	 * @param linePos
	 *            the line pos
	 * @param lastPos
	 *            the last pos
	 * @param machine
	 *            the machine
	 * @return the string
	 */
	String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine);

	/**
	 * Execute.
	 * 
	 * @param machine
	 *            the machine
	 * @return the program counter
	 */
	ProgramCounter execute(Machine machine);

	/**
	 * Stop execution.
	 */
	void stopExecution();
}
