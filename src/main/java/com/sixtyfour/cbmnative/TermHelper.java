package com.sixtyfour.cbmnative;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.TermEnhancer;
import com.sixtyfour.system.Machine;

/**
 * Bundles some static helper methods that the native compiler is using.
 * 
 * @author EgonOlsen
 * 
 */
public class TermHelper {

	/**
	 * "linearizes" a term. This is basically a kind of preprocessing step that
	 * creates a new term out of a given one which is equivalent to the former one,
	 * but better suited for the native compiler to process.
	 * 
	 * @param machine the machine
	 * @param term    the term
	 * @return the processed term
	 */
	public static Term linearize(CompilerConfig config, Machine machine, Term term) {
		if (term == null) {
			throw new RuntimeException("Term is null!");
		}
		return Parser.getTerm(config, linearize(term.getInitial(), config.isNonDecimalNumbersAware()), machine, false,
				true);
	}

	/**
	 * "linearizes" a term. This is basically a kind of preprocessing step that
	 * creates a new term out of a given one which is equivalent to the former one,
	 * but better suited for the native compiler to process.
	 * 
	 * @param term        the term
	 * @param nonDecimals are % and $ supported?
	 * @return the processed term
	 */
	public static String linearize(String term, boolean nonDecimals) {
		String t = term;
		boolean inString = false;
		int start = -1;
		int end = -1;
		char[] ct = term.toCharArray();

		for (int i = 0; i < term.length(); i++) {
			char c = t.charAt(i);
			boolean nd = false;
			if (nonDecimals && i < term.length() - 1) {
				// Peek ahead to separate Strings from Hexcadecimals
				char cn = Character.toLowerCase(t.charAt(i + 1));
				nd = (cn >= '0' && cn <= '9') || (cn >= 'a' && cn <= 'f');
			}
			if (c == '"') {
				if (!inString && i > 0) {
					start = findStart(t, i);
					end = findEnd(t, i);
				}
				inString = !inString;
			}

			boolean isLogic = false;
			if (!inString && c == '$' && !nd) {
				start = findStart(t, i);
				end = findEnd(t, i);
			}

			while (start != -1 && end != -1) {

				// Handle a combination of logic with strings and normal
				// calculations
				boolean iss = false;
				for (int p = start; p < end; p++) {
					char c2 = t.charAt(p);
					if (c2 == '"') {
						iss = !iss;
					}
					if (!iss && (c2 == '=' || c2 == '<' || c2 == '>')) {
						isLogic = true;
						break;
					}
				}

				boolean rep = false;
				// System.out
				// .println(start + "/" + end + "/" + (start >= 0 ? ct[start] :
				// 0) + "/" + (start > 0 ? ct[start - 1] : 0));
				if (start >= 0 && ct[start] == '(') {
					if (start > 0) {
						char cp = t.charAt(start - 1);
						if (cp == '$' || cp == '%' || Character.isLetterOrDigit(cp)) {
							start = -1;
							end = -1;
							break;
						}
					}

					ct[start] = (isLogic ? '(' : ' ');
					rep = !isLogic;
				}
				if (end < term.length()) {
					if (ct[end] == ')') {
						ct[end] = (isLogic ? ')' : ' ');
						rep = !isLogic;
					}
				}
				start = -1;
				end = -1;
				if (rep) {
					t = new String(ct);
					// System.out.println(new String(ct) + "/" + i);
					start = findStart(t, i);
					end = findEnd(t, i);
				}
			}
		}
		return TermEnhancer.removeWhiteSpace(new String(ct));
	}

	private static int findEnd(String term, int pos) {
		int brackets = 0;
		boolean inString = false;
		for (int i = pos; i < term.length(); i++) {
			char c = term.charAt(i);
			if (c == '"') {
				inString = !inString;
			}
			if (!inString) {
				if (brackets == 0 && c == ')') {
					return i;
				}
				if (c == '(') {
					brackets++;
				} else if (c == ')' && brackets > 0) {
					brackets--;
				}
			}
		}
		return term.length();
	}

	private static int findStart(String term, int pos) {
		int brackets = 0;
		boolean inString = false;
		for (int i = pos - 1; i >= 0; i--) {
			char c = term.charAt(i);
			if (c == '"') {
				inString = !inString;
			}
			if (!inString) {
				if (brackets == 0 && c == '(') {
					return i;
				}
				if (c == ')') {
					brackets++;
				} else if (c == '(' && brackets > 0) {
					brackets--;
				}
			}
		}
		return 0;
	}
}
