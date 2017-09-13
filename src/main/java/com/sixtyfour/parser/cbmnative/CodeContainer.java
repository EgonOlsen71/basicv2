package com.sixtyfour.parser.cbmnative;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Foerster-H
 * 
 */
public class CodeContainer {
	private List<String> pseudoBefore;

	private List<String> expression;

	private List<String> pseudoAfter;

	public CodeContainer(List<String> expression) {
		this(null, expression, null);
	}

	public CodeContainer(List<String> before, List<String> expression, List<String> after) {
		this.expression = expression == null ? new ArrayList<String>() : new ArrayList<String>(expression);
		this.pseudoBefore = before == null ? new ArrayList<String>() : new ArrayList<String>(before);
		this.pseudoAfter = after == null ? new ArrayList<String>() : new ArrayList<String>(after);
	}

	public List<String> getPseudoBefore() {
		return pseudoBefore;
	}

	public void setPseudoBefore(List<String> pseudoBefore) {
		this.pseudoBefore = pseudoBefore;
	}

	public List<String> getExpression() {
		return expression;
	}

	public void setExpression(List<String> expression) {
		this.expression = expression;
	}

	public List<String> getPseudoAfter() {
		return pseudoAfter;
	}

	public void setPseudoAfter(List<String> pseudoAfter) {
		this.pseudoAfter = pseudoAfter;
	}
}
