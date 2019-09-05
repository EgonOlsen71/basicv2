package com.sixtyfour.extensions;

import java.util.List;
import java.util.Map;

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
	 * Returns all functions of this extension. If null, no new functions will be
	 * recognized.
	 * 
	 * @return the new functions or null
	 */
	List<Function> getFunctions();

	/**
	 * Returns a list of optional runtime libaries that are needed for this
	 * extension to be natively compiled.
	 * 
	 * @return the list or null
	 */
	List<String> getAdditionalIncludes();

	/**
	 * Called when a machine instance gets reset.
	 * 
	 * @param machine the machine instance
	 */
	void reset(Machine machine);
	
	/**
	 * Returns a map of optional constants that are needed for this
	 * extension to be natively compiled.
	 * 
	 * @return the map or null
	 */
	Map<String, Integer> getLabel2Constant();

}
