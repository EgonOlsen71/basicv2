/*
 * 
 */
package com.sixtyfour.elements.functions;

import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Term;
import com.sixtyfour.system.Machine;

/**
 * The Interface Function.
 */
public interface Function extends Atom {

	/**
	 * Gets the name.
	 * 
	 * @return the name
	 */
	String getName();

	/**
	 * Checks if is function.
	 * 
	 * @param function
	 *            the function
	 * @return true, if is function
	 */
	boolean isFunction(String function);

	/**
	 * Clone.
	 * 
	 * @return the function
	 */
	Function clone();

	/**
	 * Gets the term.
	 * 
	 * @return the term
	 */
	Term getTerm();

	/**
	 * Sets the term.
	 * 
	 * @param term
	 *            the new term
	 */
	void setTerm(Term term);

	/**
	 * Parses the.
	 * 
	 * @param linePart
	 *            the line part
	 * @param machine
	 *            the machine
	 */
	void parse(String linePart, Machine machine);

	/**
	 * Checks for postfix.
	 * 
	 * @return true, if successful
	 */
	boolean hasPostfix();

	/**
	 * Sets the function name.
	 * 
	 * @param functionName
	 *            the new function name
	 */
	void setFunctionName(String functionName);

}
