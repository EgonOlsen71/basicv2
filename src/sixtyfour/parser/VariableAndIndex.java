package sixtyfour.parser;

import sixtyfour.elements.Variable;

public class VariableAndIndex {

	private Variable variable;
	private Term indexTerm;

	public VariableAndIndex(Variable variable, Term indexTerm) {
		this.setVariable(variable);
		this.setIndexTerm(indexTerm);
	}

	public Term getIndexTerm() {
		return indexTerm;
	}

	public void setIndexTerm(Term indexTerm) {
		this.indexTerm = indexTerm;
	}

	public Variable getVariable() {
		return variable;
	}

	public void setVariable(Variable variable) {
		this.variable = variable;
	}

}
