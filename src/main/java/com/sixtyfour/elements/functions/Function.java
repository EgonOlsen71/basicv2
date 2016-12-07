/*
 * 
 */
package com.sixtyfour.elements.functions;

import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Term;
import com.sixtyfour.system.Machine;

/**
 * The interface for functions.
 */
public interface Function extends Atom {

	/**
	 * Gets the name of the function.
	 * 
	 * @return the name
	 */
	String getName();

	/**
	 * Checks if some string matches this function's name.
	 * 
	 * @param function
	 *            the function
	 * @return true, if is function
	 */
	boolean isFunction(String function);

	/**
	 * Clones the function.
	 * 
	 * @return the cloned function
	 */
	Function clone();

	/**
	 * Gets the term to which the function should be applied to.
	 * 
	 * @return the term
	 */
	Term getTerm();

	/**
	 * Sets the term to which the function should be applied to.
	 * 
	 * @param term
	 *            the new term
	 */
	void setTerm(Term term);

	/**
	 * Parses a string as this function. If successful, 
	 * it sets this instances' term to the parsed result.
	 * 
	 * @param linePart
	 *            the input string
	 * @param machine
	 *            the current machine
	 */
	void parse(String linePart, Machine machine);

	/**
	 * Returns true, if this function has a postfix.
	 * 
	 * @return true, if it has.
	 */
	boolean hasPostfix();

	/**
	 * Sets the function's name. This is used for user defined functions only. 
	 * 
	 * @param functionName
	 *            the function's name
	 */
	void setFunctionName(String functionName);

}
