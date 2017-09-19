package com.sixtyfour.elements.commands;

import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Term;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.BasicProgramCounter;

/**
 * The interface for commands.
 */
public interface Command extends Atom {

	/**
	 * Must return true, if spaces are important for the command's parameter and
	 * false otherwise. For most commands, this will be false.
	 * 
	 * @return keep or don't keep
	 */
	boolean keepSpaces();

	/**
	 * Gets the name of the command.
	 * 
	 * @return the name
	 */
	String getName();

	/**
	 * Checks if some string matches this command's name.
	 * 
	 * @param command
	 *            the command string
	 * @return true, if it is this command
	 */
	boolean isCommand(String command);

	/**
	 * Clones a command with a given parameter string.
	 * 
	 * @param linePart
	 *            the parameter string
	 * @return the command
	 */
	Command clone(String linePart);

	/**
	 * Gets the term that represents this command's parameters.
	 * 
	 * @return the term
	 */
	Term getTerm();

	/**
	 * Sets the term that represents this command's parameters.
	 * 
	 * @param term
	 *            the new term
	 */
	void setTerm(Term term);

	/**
	 * Parses a string as this command. If successful, it sets this instances'
	 * term to the parsed result.
	 * 
	 * @param linePart
	 *            the parameter string
	 * @param lineCnt
	 *            the line counter
	 * @param lineNumber
	 *            the line number
	 * @param linePos
	 *            the position in the current line
	 * @param lastPos
	 *            true, if it's the last command in the line
	 * @param machine
	 *            the current machine
	 * @return an optional string that be used by the parser. Only very few
	 *         commands make use of this, most return null.
	 */
	String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine);

	/**
	 * Executes the command in the current machine's context.
	 * 
	 * @param machine
	 *            the current machine
	 * @return a program counter instance that contains the current state after
	 *         execution
	 */
	BasicProgramCounter execute(Machine machine);

	/**
	 * Stops the execution of a command. Only application to commands like WAIT.
	 */
	void stopExecution();
	
	/**
	 * Returns true, if the command is a conditional one (IF...)
	 * 
	 * @return is it?
	 */
	boolean isConditional();
}
