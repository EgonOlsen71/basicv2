package com.sixtyfour.parser.assembly;

import com.sixtyfour.system.Machine;

/**
 * Interface for storing and inserting delayed, dynamic data after the actual parsing is done.
 * 
 * @author EgonOlsen
 *
 */
public interface DelayedData {

	/**
	 * Insert the data
	 * 
	 * @param machine the machine
	 * @param ccon the container for the constants
	 */
	void apply(Machine machine, ConstantsContainer ccon);
	
}
