package sixtyfour.parser.logic;

public enum Comparator {

	EQUAL("="), NOT_EQUAL("<>"), LARGER_OR_EQUAL(">=", "=>"), SMALLER_OR_EQUAL("<=", "=<"), LARGER(">"), SMALLER("<"), EXISTS();

	private String[] term;

	private Comparator(String... term) {
		this.term = term;
	}

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

	public int getTermLength() {
		return term[0].length();
	}

}
