package com.sixtyfour.elements.commands;

import java.util.List;

import com.sixtyfour.config.CompilerConfig;
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
	 * @param command the command string
	 * @return true, if it is this command
	 */
	boolean isCommand(String command);

	/**
	 * Clones a command.
	 * 
	 * @return the command
	 */
	Command cloneCommand();

	/**
	 * Gets the term that represents this command's parameters.
	 * 
	 * @return the term
	 */
	Term getTerm();

	/**
	 * Gets all terms in case that the command uses more than one (for example FOR,
	 * which has up to 3). For a normal command, the has one element, which is the
	 * same one as getTerm() would return.
	 * 
	 * @return a list of terms
	 */
	List<Term> getAllTerms();

	/**
	 * Sets the term that represents this command's parameters.
	 * 
	 * @param term the new term
	 */
	void setTerm(Term term);

	/**
	 * Parses a string as this command. If successful, it sets this instances' term
	 * to the parsed result.
	 * 
	 * @param linePart   the parameter string
	 * @param lineCnt    the line counter
	 * @param lineNumber the line number
	 * @param linePos    the position in the current line
	 * @param lastPos    true, if it's the last command in the line
	 * @param machine    the current machine
	 * @return an optional string that be used by the parser. Only very few commands
	 *         make use of this, most return null.
	 */
	String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos,
			Machine machine);

	/**
	 * Executes the command in the current machine's context.
	 * 
	 * @param machine the current machine
	 * @return a program counter instance that contains the current state after
	 *         execution
	 */
	BasicProgramCounter execute(CompilerConfig config, Machine machine);

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

	/**
	 * If true, this command can override another one of the same name. Useful to
	 * replace functions with others, more advanced ones provided in some extension.
	 * 
	 * @return does it?
	 */
	boolean isOverride();

}
