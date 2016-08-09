/*
 * 
 */
package com.sixtyfour.parser.logic;

/**
 * The Enum Comparator.
 */
public enum Comparator {

	/** The equal. */
	EQUAL("="), /** The not equal. */
 NOT_EQUAL("<>"), /** The larger or equal. */
 LARGER_OR_EQUAL(">=", "=>"), /** The smaller or equal. */
 SMALLER_OR_EQUAL("<=", "=<"), /** The larger. */
 LARGER(">"), /** The smaller. */
 SMALLER("<"), /** The exists. */
 EXISTS();

	/** The term. */
	private String[] term;

	/**
	 * Instantiates a new comparator.
	 * 
	 * @param term
	 *            the term
	 */
	private Comparator(String... term) {
		this.term = term;
	}

	/**
	 * Gets the comparator.
	 * 
	 * @param term
	 *            the term
	 * @return the comparator
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
	 * Gets the term length.
	 * 
	 * @return the term length
	 */
	public int getTermLength() {
		return term[0].length();
	}

}
