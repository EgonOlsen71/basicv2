package com.sixtyfour.parser.assembly;

/**
 * Common interface for constants
 * 
 * @author EgonOlsen
 * 
 */
public interface ConstantValue {
	/**
	 * Returns the name of the constant
	 * 
	 * @return the name
	 */
	String getName();

	/**
	 * Returns the value of the constant
	 * 
	 * @return the value
	 */
	int getValue();

}
