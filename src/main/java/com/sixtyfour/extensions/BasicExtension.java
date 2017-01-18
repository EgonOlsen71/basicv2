package com.sixtyfour.extensions;

import java.util.List;

import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.system.Machine;

/**
 * Interface for implementing BASIC extensions
 * 
 * @author EgonOlsen
 * 
 */
public interface BasicExtension {
	/**
	 * Returns all commands of this extension. If null, no new commands will be
	 * recognized.
	 * 
	 * @return the new commands or null
	 */
	List<Command> getCommands();

	/**
	 * Returns all functions of this extension. If null, no new functions will
	 * be recognized.
	 * 
	 * @return the new functions or null
	 */
	List<Function> getFunctions();
	
	/**
	 * Called when a machine instance gets reset.
	 * 
	 * @param machine the machine instance
	 */
	void reset(Machine machine);
	
}
