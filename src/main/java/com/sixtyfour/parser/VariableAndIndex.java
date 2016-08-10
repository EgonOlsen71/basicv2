package com.sixtyfour.parser;

import com.sixtyfour.elements.Variable;

/**
 * VariableAndIndex holds an array variable and its corresponding index terms to
 * access a specific element.
 */
public class VariableAndIndex {

	/** The variable */
	private Variable variable;

	/** The index term */
	private Term indexTerm;

	/**
	 * Instantiates a new variable and index term
	 * 
	 * @param variable
	 *            the variable
	 * @param indexTerm
	 *            the index term
	 */
	public VariableAndIndex(Variable variable, Term indexTerm) {
		this.setVariable(variable);
		this.setIndexTerm(indexTerm);
	}

	/**
	 * Returns the index term.
	 * 
	 * @return the index term
	 */
	public Term getIndexTerm() {
		return indexTerm;
	}

	/**
	 * Sets the index term.
	 * 
	 * @param indexTerm
	 *            the new index term
	 */
	public void setIndexTerm(Term indexTerm) {
		this.indexTerm = indexTerm;
	}

	/**
	 * Returns the variable.
	 * 
	 * @return the variable
	 */
	public Variable getVariable() {
		return variable;
	}

	/**
	 * Sets the variable.
	 * 
	 * @param variable
	 *            the new variable
	 */
	public void setVariable(Variable variable) {
		this.variable = variable;
	}

}
