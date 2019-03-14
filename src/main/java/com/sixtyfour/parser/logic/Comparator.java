/*
 * 
 */
package com.sixtyfour.parser.logic;

/**
 * Comparator is an enum that contains all possible comparators that a BASIC
 * program can contain, as there are =, <>, >=, =>, <=, =<, > and <
 */
public enum Comparator {

	NOT_EQUAL("<>"), LARGER_OR_EQUAL(">=", "=>"), SMALLER_OR_EQUAL("<=", "=<"), EQUAL("="), LARGER(">"), SMALLER("<"),
	EXISTS();

	/** The term */
	private String[] term;

	/**
	 * Instantiates a new comparator.
	 * 
	 * @param term the term
	 */
	private Comparator(String... term) {
		this.term = term;
	}

	/**
	 * Return the comparator that matches a given term.
	 * 
	 * @param term the term
	 * @return the matching comparator or null, if none matches
	 */
	public static Comparator getComparator(String term) {
		if (term != null && term.length() > 0) {
			for (Comparator compy : values()) {
				if (compy.term != null) {
					for (String t : compy.term) {
						if (term.startsWith(t)) {
							return compy;
						}
					}
				}
			}
		}
		return null;
	}

	/**
	 * Returns the term's length.
	 * 
	 * @return the term's length
	 */
	public int getTermLength() {
		return term[0].length();
	}

	/**
	 * Returns the internal representation that the native compiler uses.
	 * 
	 * @return
	 */
	public String evalToCode() {
		return "CMP " + term[0];
	}

}
