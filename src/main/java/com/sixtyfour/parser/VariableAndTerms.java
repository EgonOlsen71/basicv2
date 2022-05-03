/*
 * 
 */
package com.sixtyfour.parser;

import java.util.List;

/**
 * VariableAndTerms holds an array variable's name and terms used to determine
 * it's dimensions.
 */
public class VariableAndTerms {

	/** The variable's name */
	private String varName;

	/** The terms */
	private List<Atom> terms;

	/**
	 * Instantiates a new variable and terms.
	 * 
	 * @param var   the variable's name
	 * @param terms the terms
	 */
	public VariableAndTerms(String var, List<Atom> terms) {
		this.varName = var.endsWith("[]") ? var : (var + "[]");
		this.terms = terms;
	}

	/**
	 * Returns the variable's name.
	 * 
	 * @return the variable's name
	 */
	public String getVarName() {
		return varName;
	}

	/**
	 * Sets the variable's name.
	 * 
	 * @param varName the new variable's name
	 */
	public void setVarName(String varName) {
		this.varName = varName;
	}

	/**
	 * Returns the terms.
	 * 
	 * @return the terms
	 */
	public List<Atom> getTerms() {
		return terms;
	}

	/**
	 * Sets the terms.
	 * 
	 * @param terms the new terms
	 */
	public void setTerms(List<Atom> terms) {
		this.terms = terms;
	}

}
