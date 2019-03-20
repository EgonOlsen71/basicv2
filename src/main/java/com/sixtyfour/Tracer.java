package com.sixtyfour;

import com.sixtyfour.elements.commands.Command;

/**
 * Interface from implementing tracing of BASIC programs. For each BASIC
 * command, the commandExecuted() method of this interface will be called after
 * the command has been executed.
 * 
 * @author EgonOlsen
 * 
 */
public interface Tracer {
	/**
	 * Called when a program starts.
	 * 
	 * @param basic the Basic instance that has started the program
	 */
	void start(Basic basic);

	/**
	 * Called when a program stops.
	 * 
	 * @param basic the Basic instance that has stoppepd the program
	 */
	void stop(Basic basic);

	/**
	 * A command has been executed.
	 * 
	 * @param basic      the Basic instance that has executed the command
	 * @param command    the actual command
	 * @param lineNumber the line number
	 * @param count      the position of the command in line (0-based)
	 */
	void commandExecuted(Basic basic, Command command, Integer lineNumber, int count);
}
