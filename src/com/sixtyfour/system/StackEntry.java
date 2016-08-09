package com.sixtyfour.system;

import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.For;
import com.sixtyfour.elements.commands.Gosub;
import com.sixtyfour.elements.commands.On;

/**
 * The Class StackEntry.
 */
public class StackEntry {
	
	/** The command. */
	private Command command;

	/**
	 * Instantiates a new stack entry.
	 * 
	 * @param command
	 *            the command
	 */
	public StackEntry(Command command) {
		this.command = command;
	}

	/**
	 * Gets the command.
	 * 
	 * @return the command
	 */
	public Command getCommand() {
		return command;
	}

	/**
	 * Checks if is for.
	 * 
	 * @return true, if is for
	 */
	public boolean isFor() {
		return command instanceof For;
	}

	/**
	 * Checks if is subroutine call.
	 * 
	 * @return true, if is subroutine call
	 */
	public boolean isSubroutineCall() {
		return command instanceof Gosub || command instanceof On;
	}
}
