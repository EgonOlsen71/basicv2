package sixtyfour;

import java.util.List;

import sixtyfour.elements.Atom;

public class VariableAndTerms {

	private String varName;
	private List<Atom> terms;

	public VariableAndTerms(String var, List<Atom> terms) {
		this.varName = var.endsWith("[]") ? var : (var + "[]");
		this.terms = terms;
	}

	public String getVarName() {
		return varName;
	}

	public void setVarName(String varName) {
		this.varName = varName;
	}

	public List<Atom> getTerms() {
		return terms;
	}

	public void setTerms(List<Atom> terms) {
		this.terms = terms;
	}

}
