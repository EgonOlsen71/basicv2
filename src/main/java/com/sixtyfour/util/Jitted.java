package com.sixtyfour.util;

import com.sixtyfour.elements.Variable;

/**
 * Interface for Java classes created by the JIT compiler.
 * 
 * @author EgonOlsen
 * 
 */
public interface Jitted {
	/**
	 * Sets the variables that the compiled code accesses
	 * 
	 * @param vars
	 *            the variables
	 */
	void setVars(Variable[] vars);
}
