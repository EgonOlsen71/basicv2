package com.sixtyfour.elements.functions;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.cbmnative.CodeContainer;
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

	@Override
	public Type getType(boolean ignoreMt) {
		return getType();
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

	/**
	 * Throws a type mismatch error.
	 * 
	 * @param line
	 */
	protected void typeMismatch(String line) {
		throw new RuntimeException("Type mismatch error: " + line);
	}

	/**
	 * Throws a syntax error.
	 * 
	 * @param line
	 */
	protected void syntaxError(String line) {
		throw new RuntimeException("Syntax error: " + line);
	}

	/**
	 * Throws a type mismatch error.
	 * 
	 * @param line
	 */
	protected void typeMismatch(Object obj) {
		typeMismatch(obj.toString());
	}

	/**
	 * Throws a syntax error.
	 * 
	 * @param line
	 */
	protected void syntaxError(Object obj) {
		syntaxError(obj.toString());
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

	@Override
	public List<CodeContainer> evalToCode(Machine machine) {
		List<String> ret = new ArrayList<String>();
		ret.add("_");
		List<String> n1 = term.evalToCode(machine).get(0).getExpression();
		n1.add(":" + this.getClass().getSimpleName().toUpperCase(Locale.ENGLISH));
		ret.addAll(0, n1);
		List<CodeContainer> cc = new ArrayList<CodeContainer>();
		cc.add(new CodeContainer(ret));
		return cc;
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
	 * @see com.sixtyfour.elements.functions.Function#isDeterministic()
	 */
	@Override
	public boolean isDeterministic() {
		return true;
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.parser.Atom#toCode(com.sixtyfour.system.Machine)
	 */
	@Override
	public String toCode(Machine machine) {
		return null;
	}
}
