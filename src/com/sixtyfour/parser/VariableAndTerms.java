/*
 * 
 */
package com.sixtyfour.parser;

import java.util.List;

/**
 * The Class VariableAndTerms.
 */
public class VariableAndTerms {

	/** The var name. */
	private String varName;
	
	/** The terms. */
	private List<Atom> terms;

	/**
	 * Instantiates a new variable and terms.
	 * 
	 * @param var
	 *            the var
	 * @param terms
	 *            the terms
	 */
	public VariableAndTerms(String var, List<Atom> terms) {
		this.varName = var.endsWith("[]") ? var : (var + "[]");
		this.terms = terms;
	}

	/**
	 * Gets the var name.
	 * 
	 * @return the var name
	 */
	public String getVarName() {
		return varName;
	}

	/**
	 * Sets the var name.
	 * 
	 * @param varName
	 *            the new var name
	 */
	public void setVarName(String varName) {
		this.varName = varName;
	}

	/**
	 * Gets the terms.
	 * 
	 * @return the terms
	 */
	public List<Atom> getTerms() {
		return terms;
	}

	/**
	 * Sets the terms.
	 * 
	 * @param terms
	 *            the new terms
	 */
	public void setTerms(List<Atom> terms) {
		this.terms = terms;
	}

}
