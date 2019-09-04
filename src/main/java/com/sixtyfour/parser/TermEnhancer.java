package com.sixtyfour.parser;

import java.math.BigDecimal;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.util.VarUtils;

/**
 * This is mainly used to modify existing terms by adding or removing stuff from
 * them to unify them or make them more accessible to the parser.
 * 
 * @author EgonOlsen
 * 
 */
public class TermEnhancer {

    /**
     * Adds the brackets. This is used to simplify expression parsing later.
     * Actually, it might be better to convert the expressions from infix to RPN
     * and use a stack to evaluate them, but then again...I can't be bothered,
     * because this works as well and it's better suitable for JITting the
     * result.
     * 
     * @param term
     *            the term
     * @return the string
     */
    public static String addBrackets(String term) {
	checkBrackets(term);
	// Wrap every term into brackets no matter what. This makes parsing a
	// lot easier afterwards...
	if (!term.startsWith("(") || !term.endsWith(")")) {
	    term = "(" + term + ")";
	}
	term = term.replace('↑', '^');
	return addBrackets(addBrackets(addBrackets(addBrackets(handleSigns(replaceLogicOperators(term)), 3), 2), 0), 1);
    }

    public static String handleNonDecimalNumbers(CompilerConfig conf, String term) {
	final int NONE = 0;
	final int BIN = 1;
	final int HEX = 2;

	if (!conf.isNonDecimalNumbersAware()) {
	    return term;
	}

	int inNumber = 0;
	StringBuilder sb = new StringBuilder();
	String num = "";
	for (int i = 0; i < term.length(); i++) {
	    char c = term.charAt(i);
	    if (inNumber > NONE) {
		char cl = Character.toLowerCase(c);
		if (inNumber == BIN && (cl == '0' || cl == '1')) {
		    num += c;
		} else if ((cl >= '0' && cl <= '9') || (cl >= 'a' && cl <= 'f')) {
		    num += c;
		} else {
		    sb.append(Integer.parseInt(num, inNumber == BIN ? 2 : 16));
		    sb.append(c);
		    inNumber = NONE;
		    num = "";
		}
	    } else {
		if (i < term.length() - 1) {
		    char cf = Character.toLowerCase(term.charAt(i + 1));
		    if (c == '%' && (cf == '0' || cf == '1')) {
			inNumber = BIN;
			num = "";
		    } else if (c == '$' && ((cf >= '0' && cf <= '9') || (cf >= 'a' && cf <= 'f'))) {
			inNumber = HEX;
			num = "";
		    }
		}
		if (inNumber == NONE) {
		    sb.append(c);
		}
	    }
	}
	if (!num.isEmpty()) {
	    sb.append(Integer.parseInt(num, inNumber == BIN ? 2 : 16));
	}
	return sb.toString();
    }

    /**
     * Checks, if a text term's brackets are correctly placed. If not, it will
     * throw a RuntimeException.
     * 
     * @param term
     *            the term to check
     */
    public static void checkBrackets(String term) {
	int open = 0;
	boolean inString = false;
	for (int i = 0; i < term.length(); i++) {
	    char c = term.charAt(i);
	    if (c == '"') {
		inString = !inString;
	    }
	    if (!inString) {
		if (c == '(') {
		    open++;
		} else if (c == ')') {
		    open--;
		}
	    }
	}
	if (open != 0) {
	    throw new RuntimeException("Invalid term: " + term + "/" + open);
	}
    }

    /**
     * Removes the white spaces from a text.
     * 
     * @param txt
     *            the txt
     * @return the txt without the white spaces
     */
    public static String removeWhiteSpace(String txt) {
	StringBuilder sb = new StringBuilder();
	boolean inString = false;
	for (int i = 0; i < txt.length(); i++) {
	    char c = txt.charAt(i);
	    if (c == '"') {
		inString = !inString;
	    }
	    if (inString || c != ' ') {
		sb.append(c);
	    }
	}
	return sb.toString();
    }

    /**
     * Replaces logic BASIC operators in a term by a one-char representation.
     * The resulting term isn't valid BASIC anymore but it's easier to parse.
     * 
     * @param term
     *            the term
     * @return the resulting term
     */
    public static String replaceLogicOperators(String term) {
	// Replace logic operators by placeholder chars. NOT actually hasn't
	// two operands, but we abuse the current logic by faking it.
	String[] replacers = { "OR", Operator.getOrOperator(), "AND", Operator.getAndOperator(), "NOT",
		"(0" + Operator.getNotOperator() };
	term = removeWhiteSpace(term);
	String uTerm = VarUtils.toUpper(term);
	for (int i = 0; i < replacers.length; i += 2) {
	    int pos = -1;
	    do {
		String torep = replacers[i];
		pos = uTerm.indexOf(torep, pos);
		if (pos != -1) {
		    boolean inString = false;
		    for (int j = 0; j < pos; j++) {
			char c = uTerm.charAt(j);
			if (c == '\"') {
			    inString = !inString;
			}
		    }
		    if (!inString) {
			term = term.substring(0, pos) + replacers[i + 1] + term.substring(pos + torep.length());
			uTerm = uTerm.substring(0, pos) + replacers[i + 1] + uTerm.substring(pos + torep.length());
			if (torep.equals("NOT")) {
			    int end = findEnd(uTerm, pos + 2);
			    term = term.substring(0, end) + ")" + term.substring(end);
			    uTerm = uTerm.substring(0, end) + ")" + uTerm.substring(end);
			}
		    } else {
			pos++;
		    }

		}
	    } while (pos != -1);
	}
	return term;
    }

    /**
     * Removes the assignment part of the "term", i.e. everything before the =
     * 
     * @param term
     *            the "term"
     * @param stripAssignment
     *            if true, the assignment will be removed (if any). If false,
     *            the string will be returned unchanged.
     * @return the new term
     */
    public static String stripAssignment(String term, boolean stripAssignment) {
	if (stripAssignment) {
	    int pos = term.indexOf('=');
	    if (pos != -1) {
		term = term.substring(pos + 1);
	    }
	}
	return term;
    }

    /**
     * Replaces x*e^y by an actual term to ease the parsing later on
     * 
     * @param line
     * @return
     */
    public static String replaceScientificNotation(String line) {
	if (line.contains("\"") || line.contains("$")) {
	    return line;
	}

	StringBuilder sb = new StringBuilder();

	for (int i = 0; i < line.length(); i++) {
	    char c = Character.toLowerCase(line.charAt(i));
	    if (c == 'e' && i > 0) {
		char cp = line.charAt(i - 1);
		if (!Character.isDigit(cp)) {
		    sb.append(c);
		    continue;
		}

		boolean signFound = false;
		boolean numFound = false;
		StringBuilder num = new StringBuilder();
		int np = i;
		for (int p = i + 1; p < line.length(); p++) {
		    cp = line.charAt(p);
		    if (!signFound) {
			if (cp == '-' || cp == '+') {
			    signFound = true;
			    num.append(cp);
			    np = p;
			    continue;
			}
		    }
		    if (Character.isDigit(cp)) {
			num.append(cp);
			numFound = true;
			signFound = true;
			np = p;
		    } else {
			break;
		    }
		}

		if (!numFound) {
		    num.append("0");
		}
		if (num.length() > 0) {
		    int l = sb.length();
		    int p = findStart(sb.toString(), l - 1);
		    boolean rep = false;
		    try {
			// try to get rid of the scientific notations, at least
			// at this stage
			String vv = sb.substring(p, l) + "e" + num.toString();
			sb.setLength(p);
			sb.append(new BigDecimal(vv).toPlainString());
			rep = true;
		    } catch (Exception e) {
			//
		    }
		    if (!rep) {
			// old, hacky replacement. This is ok for the java based
			// runtime but a performance killer
			// when compiled to native code. It's still here as a
			// fallback, but it should actually never be triggered!
			sb.append("*(10^" + num.toString() + "))");
			sb.insert(p, "(");
		    }
		    i = np;
		} else {
		    sb.append(c);
		}
	    } else {
		sb.append(c);
	    }
	}
	// System.out.println("SFN: "+line+"/"+sb.toString());
	return sb.toString();
    }

    /**
     * Adds brackets to a term based on the operator order. The resulting term
     * makes it clear which operations belong together without any knowledge
     * about the actual operator order needed.
     * 
     * @param term
     *            the term
     * @param level
     *            the level, either 0,1 or 2. Three passes are needed to handle
     *            *,/ (level 0), ^(level 1) and <,>,= and combinations (level
     *            2). level 3 is for logic operators like AND, OR
     * @return the resulting term
     */
    private static String addBrackets(String term, int level) {
	term = removeWhiteSpace(term);
	StringBuilder sb = new StringBuilder();
	boolean inString = false;
	for (int i = 0; i < term.length(); i++) {
	    // System.out.println(term);
	    char c = term.charAt(i);
	    if (c == '"') {
		inString = !inString;
	    }
	    if (inString) {
		continue;
	    }

	    // Wrap parameters into brackets to ease term creation later on
	    if (c == ',') {
		int end = findNextDelimiter(term, i);
		String curPar = term.substring(i + 1, end);
		if (!curPar.startsWith("(") || !curPar.endsWith(")")) {
		    sb.append(term.substring(0, i + 1)).append('(').append(curPar).append(')');
		    if (end != term.length()) {
			sb.append(term.substring(end));
		    }
		    i++;
		    term = sb.toString();
		    sb.setLength(0);
		}
	    }

	    if ((level == 2 && (c == '=' || c == '<' || c == '>')) || (level == 1 && (c == '*' || c == '/'))
		    || (level == 0 && c == '^') || (level == 3 && (c == '&' || c == '°'))) {
		int start = level != 3 ? findStart(term, i, level >= 2) : i + 1;
		int end = findEnd(term, i, level >= 2);
		if (start > 0 && term.charAt(start - 1) == '(' && end < term.length() && term.charAt(end) == ')') {
		    sb.append(term.substring(0, start)).append(term.substring(start, end));
		} else {
		    sb.append(term.substring(0, start)).append('(').append(term.substring(start, end)).append(')');
		    i++;
		}
		if (end != term.length()) {
		    sb.append(term.substring(end));
		}
		term = sb.toString();
		sb.setLength(0);
	    }
	}
	// System.out.println("AB: " + term);
	return term;
    }

    /**
     * Finds the position of the next delimiter.
     * 
     * @param term
     *            the term
     * @param pos
     *            the last position
     * @return the next position
     */
    private static int findNextDelimiter(String term, int pos) {
	int brackets = 1;
	term = term + ",";
	boolean inString = false;
	for (int i = pos + 1; i < term.length(); i++) {
	    char c = term.charAt(i);
	    if (c == '"') {
		inString = !inString;
	    }
	    if (!inString) {
		if (c == '(') {
		    brackets++;
		}
		if (c == ')') {
		    brackets--;
		}
		if ((c == ',' && brackets == 1) || (c == ')' && brackets == 0)) {
		    return i;
		}
	    }
	}
	throw new RuntimeException("Syntax error: " + term);
    }

    /**
     * Handles negations by adding an additional -1* in front of the negated
     * element. Something similar applies to terms like ++++2.
     * 
     * @param term
     *            the term
     * @return the resulting term
     */
    private static String handleSigns(String term) {
	// System.out.println("Start: " + term);
	term = removeWhiteSpace(term);
	StringBuilder sb = new StringBuilder();
	boolean inString = false;
	boolean wasOp = true;
	for (int i = 0; i < term.length(); i++) {
	    char c = term.charAt(i);
	    if (c == '\"') {
		inString = !inString;
	    }
	    if (!inString && c == '-' && wasOp) {
		wrapSign(term, sb, i, "-1");
		i++;
		term = sb.toString();
		sb.setLength(0);
	    } else {
		if (!inString && c == '+' && wasOp) {
		    sb.append(term.substring(0, i)).append(term.substring(i + 1, term.length()));
		    i--;
		    term = sb.toString();
		    sb.setLength(0);
		}
	    }

	    wasOp = Operator.isOperator(c) || c == '(';
	}
	// System.out.println("Result: " + term);
	return term;
    }

    private static void wrapSign(String term, StringBuilder sb, int i, String sign) {
	int end = findEndOfNegation(term, i, true);
	if (end == i + 1) {
	    throw new RuntimeException("Syntax error: " + term);
	}
	if (end == -1) {
	    sb.append(term.substring(0, i)).append(sign + "*").append(term.substring(i + 1));
	} else {
	    sb.append(term.substring(0, i)).append("(" + sign + "*").append(term.substring(i + 1, end)).append(")")
		    .append(term.substring(end));
	}
    }

    private static int findEndOfNegation(String term, int pos, boolean negative) {
	int brackets = 0;
	boolean rowOfOps = true;
	boolean inString = false;
	for (int i = pos + 1; i < term.length(); i++) {
	    char c = term.charAt(i);
	    if (c == '"') {
		inString = !inString;
	    }

	    if (!inString) {
		if (c == ',' && brackets == 0) {
		    return i;
		}

		boolean opi = Operator.isOperator(c);
		if (!opi && negative) {
		    rowOfOps = false;
		}

		if (brackets == 0 && ((opi && !rowOfOps) || c == ')')) {
		    if (c == '^') {
			// Power of x must not be wrapped into brackets, because
			// that would kill the correct operator order. We return
			// a
			// -1 to indicate that.
			return -1;
		    } else {
			return i;
		    }
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

    private static int findEnd(String term, int pos) {
	return findEnd(term, pos, false);
    }

    /**
     * Finds the end of a term starting at the current position.
     * 
     * @param term
     *            the term
     * @param pos
     *            the current position
     * @return the end
     */
    private static int findEnd(String term, int pos, boolean logicCheck) {
	int brackets = 0;
	boolean inString = false;
	int st = pos + 1;
	if (Operator.isComparisonOperator(term.charAt(pos)) && (pos < term.length() - 1)
		&& Operator.isComparisonOperator(term.charAt(pos + 1))) {
	    st++;
	}
	for (int i = st; i < term.length(); i++) {
	    char c = term.charAt(i);
	    if (c == '"') {
		inString = !inString;
	    }
	    if (!inString) {
		if (c == ',' && brackets == 0) {
		    return i;
		}

		if (brackets == 0
			&& ((logicCheck ? Operator.isLogicOperator(c) : Operator.isOperator(c)) || c == ')')) {
		    if (!(!logicCheck && (c == '-' || c == '+') && i - 1 == pos)) {
			// Handle term like 2*-2^2 correctly. The bracket is
			// then not supposed to go
			// between the * and the -
			return i;
		    }
		    // return i;
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
	return findStart(term, pos, false);
    }

    /**
     * Finds the start of a term starting at the current position.
     * 
     * @param term
     *            the term
     * @param pos
     *            the current position
     * @return the start
     */
    private static int findStart(String term, int pos, boolean logicCheck) {
	int brackets = 0;
	boolean inString = false;
	int st = pos - 1;
	if (Operator.isComparisonOperator(term.charAt(pos)) && (pos > 1)
		&& Operator.isComparisonOperator(term.charAt(pos - 1))) {
	    st--;
	}
	for (int i = st; i >= 0; i--) {
	    char c = term.charAt(i);
	    if (c == '"') {
		inString = !inString;
	    }
	    if (!inString) {
		if (c == ',' && brackets == 0) {
		    return i + 1;
		}
		char pc = c;
		if (i > 0) {
		    pc = term.charAt(i - 1);
		}

		// This handles negative numbers as well, like *-10. However,
		// the
		// parser doesn't allow for such numbers here, because they get
		// resolved much earlier...anyway...
		if (brackets == 0 && (((logicCheck ? Operator.isLogicOperator(c) : Operator.isOperator(c))
			&& (c != '-' || (i > 0 && !Operator.isOperator(pc) && pc != '('))) || c == '(')) {
		    return i + 1;
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
