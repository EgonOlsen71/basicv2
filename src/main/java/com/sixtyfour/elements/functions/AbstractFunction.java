package com.sixtyfour.elements.functions;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Atom;
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

	@Override
	public Type getType(boolean ignoreMt) {
		return getType();
	}

	/**
	 * Instantiates a new abstract function.
	 * 
	 * @param name the name
	 */
	public AbstractFunction(String name) {
		this.name = VarUtils.toUpper(name);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object o) {
		if (o == null) {
			return false;
		}

		if (o instanceof Function && this.isDeterministic()) {
			if (o == this) {
				return true;
			}
			return this.name.equals(((Function) o).getName()) && term.equals(((Function) o).getTerm());
		}
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return name.hashCode();
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
	 * @see com.sixtyfour.elements.functions.Function#getParameterCount()
	 */
	public int getParameterCount() {
		return 0;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#clone()
	 */
	@SuppressWarnings("deprecation")
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
	 * @see
	 * com.sixtyfour.parser.Atom#evalToCode(com.sixtyfour.config.CompilerConfig,
	 * com.sixtyfour.system.Machine)
	 */
	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		List<String> ret = new ArrayList<String>();
		ret.add("_");
		List<String> n1 = term.evalToCode(config, machine).get(0).getExpression();
		n1.add(":" + getNativeFunctionName());
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
	 * @see com.sixtyfour.elements.functions.Function#getInitialCall()
	 */
	@Override
	public String getInitialCall() {
		return this.name + "(" + term.getInitial() + ")";
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
	public void parse(CompilerConfig config, String linePart, Machine machine) {
		this.setTerm(Parser.getTerm(config, linePart, machine, false, true));
		if (getParameterCount() > 0) {
			if (Parser.getParameters(term).size() > getParameterCount()) {
				throw new RuntimeException("Syntax error: " + linePart);
			}
		}
	}

	@Override
	public boolean typesMatch() {
		Type type = getParameterType();
		if (type != null && getParameterCount() == 1) {
			Atom par = Parser.getParameters(term).get(0);

			if ((par.getType(true) == Type.STRING && type != Type.STRING)
					|| (par.getType(true) != Type.STRING && type == Type.STRING)) {
				return false;
			}
		}
		return true;
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
	 * @see
	 * com.sixtyfour.elements.functions.Function#isNativeFunction(java.lang.String)
	 */
	@Override
	public boolean isNativeFunction(String function) {
		return VarUtils.toUpper(function.trim()).startsWith(getNativeFunctionName());
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
	 */
	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.functions.Function#isExcluded()
	 */
	@Override
	public boolean isExcluded() {
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.functions.Function#setFunctionName(java.lang.String)
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.parser.Atom#isConstant()
	 */
	@Override
	public boolean isConstant() {
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.functions.Function#isOverride()
	 */
	@Override
	public boolean isOverride() {
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.functions.Function#getNativeFunctionName()
	 */
	@Override
	public String getNativeFunctionName() {
		return this.getClass().getSimpleName().toUpperCase(Locale.ENGLISH);

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.sixtyfour.elements.functions.Function#addNativeFunctionCall(java.util.
	 * List)
	 */
	@Override
	public boolean addNativeFunctionCall(List<String> code) {
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.functions.Function#getParameterType()
	 */
	@Override
	public Type getParameterType() {
		return null;
	}
	
	/**
	 * 
	 */
	@Override
	public boolean isLimitedToPrint() {
		return false;
	}

}
