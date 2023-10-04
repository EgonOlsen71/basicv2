/*
 * 
 */
package com.sixtyfour.elements.functions;

import java.util.List;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
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
	 * @param function the function
	 * @return true, if is function
	 */
	boolean isFunction(String function);

	/**
	 * Checks if some string matches this function's native name(s). A function in
	 * BASIC source code can have different native names.
	 * 
	 * @param function the function
	 * @return true, if is native function
	 */
	boolean isNativeFunction(String function);

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
	 * @param term the new term
	 */
	void setTerm(Term term);

	/**
	 * Parses a string as this function. If successful, it sets this instances' term
	 * to the parsed result.
	 * 
	 * @param linePart the input string
	 * @param machine  the current machine
	 */
	void parse(CompilerConfig config, String linePart, Machine machine);

	/**
	 * Returns true, if this function has a postfix.
	 * 
	 * @return true, if it has.
	 */
	boolean hasPostfix();

	/**
	 * Sets the function's name. This is used for user defined functions only.
	 * 
	 * @param functionName the function's name
	 */
	void setFunctionName(String functionName);

	/**
	 * Returns true, if the function call will return the same value every time it's
	 * called with the same input. This is true for mathematical functions and such
	 * but false for RND or PEEK.
	 * 
	 * @return
	 */
	boolean isDeterministic();

	/**
	 * Returns true if a function should be excluded from term optimizations.
	 * Default is false.
	 * 
	 * @return
	 */
	boolean isExcluded();

	/**
	 * Returns the actual string that defines this function (i.e. how it has been
	 * written in the code).
	 * 
	 * @return the string
	 */
	String getInitialCall();

	/**
	 * Returns the number of parameters that this functions expects at least. May
	 * return 0, if no number has been specified.
	 * 
	 * @return the minimum number or 0
	 */
	int getParameterCount();

	/**
	 * If true, this function can override another one of the same name. Useful to
	 * replace functions with others, more advanced ones provided in some extension.
	 * 
	 * @return does it?
	 */
	boolean isOverride();

	/**
	 * Returns the name of the native code's function to be called.
	 * 
	 * @return the name
	 */
	String getNativeFunctionName();

	/**
	 * Adds native (in terms of intermediate language) code to the list for this
	 * function. This only applies to function that are part of a BASIC extension.
	 * Otherwise, the NativeCompiler itself handles this and this method has to
	 * return false for these default functions.
	 * 
	 * @param code the current code
	 * @return if new code has been added
	 */
	boolean addNativeFunctionCall(List<String> code);

	/**
	 * Returns the type of the parameter that a function wants. Functions with mixed
	 * parameter are allowed to return null and check individually.
	 * 
	 * @return the type or null
	 */
	Type getParameterType();

	/**
	 * Allows an implementation of this interface to check for proper typing.
	 * 
	 * @return true, if the types match. False otherwise
	 */
	boolean typesMatch();
	
	/**
	 * Returns true for functions that can only be used in PRINT like TAB and SPC.
	 * 
	 * @return true or false
	 */
	boolean isLimitedToPrint();

}
