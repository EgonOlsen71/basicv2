package com.sixtyfour.elements.functions;

import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * An abstract base class for functions that provides some common code base.
 */
public abstract class AbstractFunction implements Function {

	/** The name. */
	protected String name;

	/** The term. */
	protected Term term;

	/** The function name. */
	protected String functionName;

	/**
	 * Instantiates a new abstract function.
	 */
	@SuppressWarnings("unused")
	private AbstractFunction() {
		//
	}

	/**
	 * Instantiates a new abstract function.
	 * 
	 * @param name
	 *            the name
	 */
	public AbstractFunction(String name) {
		this.name = VarUtils.toUpper(name);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#clone()
	 */
	public Function clone() {
		try {
			AbstractFunction clone = this.getClass().newInstance();
			clone.name = name;
			return clone;
		} catch (Exception e) {
			throw new RuntimeException("Unable to instantiate function: " + name);
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.functions.Function#getName()
	 */
	@Override
	public String getName() {
		return name;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.functions.Function#getTerm()
	 */
	@Override
	public Term getTerm() {
		return term;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.functions.Function#setTerm(sixtyfour.parser.Term)
	 */
	@Override
	public void setTerm(Term term) {
		this.term = term;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.functions.Function#parse(java.lang.String,
	 * sixtyfour.system.Machine)
	 */
	@Override
	public void parse(String linePart, Machine machine) {
		this.setTerm(Parser.getTerm(linePart, machine, false, true));
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.functions.Function#isFunction(java.lang.String)
	 */
	@Override
	public boolean isFunction(String function) {
		return VarUtils.toUpper(function.trim()).startsWith(name);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.functions.Function#hasPostfix()
	 */
	@Override
	public boolean hasPostfix() {
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * sixtyfour.elements.functions.Function#setFunctionName(java.lang.String)
	 */
	@Override
	public void setFunctionName(String functionName) {
		this.functionName = functionName;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return this.name + "(" + term + ")";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#isTerm()
	 */
	@Override
	public boolean isTerm() {
		return false;
	}
}
