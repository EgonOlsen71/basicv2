package com.sixtyfour.cbmnative.mos6502;

import java.util.List;

/**
 * Implement this interface to allow the Transformer implementation to add
 * variables to the string variables' collection in case an extensions needs to
 * do this.
 * 
 * @author EgonOlsen
 *
 */
public interface StringAdder {

	/**
	 * An implementation of this method is supposed to add entries to the given list
	 * directly.
	 * 
	 * @param strVars
	 */
	void addStringVars(List<String> strVars);

}
