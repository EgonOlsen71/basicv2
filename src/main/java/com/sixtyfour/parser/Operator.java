/*
 * 
 */
package com.sixtyfour.parser;

/**
 * An operator is either a mathematical operator like "+" or "*" or a logical
 * like "AND" or "NOT". For internal reasons, there's also a NOP operator that
 * does nothing and a delimiter operator.
 */
public class Operator {
	private final static String[] OPS = { "^", "*", "/", "+", "-", "|", ",", "°", "&", "!", "<", ">", "=" };
	private int type = -1;

	public final static Operator NOP = new Operator('|');

	/**
	 * Instantiates a new operator.
	 * 
	 * @param op
	 *            the string the represents the operator
	 */
	public Operator(String op) {
		op = op.trim();
		int cnt = 0;
		for (String o : OPS) {
			if (o.equals(op)) {
				setType(cnt);
			}
			cnt++;
		}
		if (type == -1) {
			throw new RuntimeException("Unsupported operator: " + op);
		}
	}

	/**
	 * Instantiates a new operator.
	 * 
	 * @param c
	 *            the char the represents the operator
	 */
	public Operator(char c) {
		this(Character.toString(c));
	}

	/**
	 * Returns the string that represents an OR operator.
	 * 
	 * @return the string
	 */
	public static String getOrOperator() {
		return OPS[7];
	}

	/**
	 * Returns the string that represents an AND operator.
	 * 
	 * @return the string
	 */
	public static String getAndOperator() {
		return OPS[8];
	}

	/**
	 * Returns the string that represents a NOT operator.
	 * 
	 * @return the string
	 */
	public static String getNotOperator() {
		return OPS[9];
	}

	/**
	 * Returns true, if this is an OR operator
	 * 
	 * @return is it?
	 */
	public boolean isOr() {
		return type == 7;
	}

	/**
	 * Returns true, if this is an AND operator
	 * 
	 * @return is it?
	 */
	public boolean isAnd() {
		return type == 8;
	}

	/**
	 * Returns true, if this is a NOT operator
	 * 
	 * @return is it?
	 */
	public boolean isNot() {
		return type == 9;
	}

	/**
	 * Returns true, if this is a plus operator
	 * 
	 * @return is it?
	 */
	public boolean isPlus() {
		return type == 3;
	}

	/**
	 * Returns true, if this is a power operator
	 * 
	 * @return is it?
	 */
	public boolean isPower() {
		return type == 0;
	}

	/**
	 * Returns true, if this is a minus operator
	 * 
	 * @return is it?
	 */
	public boolean isMinus() {
		return type == 4;
	}

	/**
	 * Returns true, if this is a multiplication operator
	 * 
	 * @return is it?
	 */
	public boolean isMultiplication() {
		return type == 1;
	}

	/**
	 * Returns true, if this is a division operator
	 * 
	 * @return is it?
	 */
	public boolean isDivision() {
		return type == 2;
	}

	/**
	 * Returns true, if this is a delimiter (a ",")
	 * 
	 * @return is it?
	 */
	public boolean isDelimiter() {
		return type == 6;
	}

	/**
	 * Returns true, if this is a NOP operator
	 * 
	 * @return is it?
	 */
	public boolean isNop() {
		return type == 5;
	}

	/**
	 * Checks if a char is an actual operator.
	 * 
	 * @param c
	 *            the char
	 * @return true, if it's an operator
	 */
	public static boolean isOperator(char c) {
		for (String op : OPS) {
			if (op.charAt(0) == c) {
				return true;
			}
		}
		return false;
	}
	
	 /**
	  * Checks if a char is a logic operator (AND or OR).
	  * 
	 * @param c the char
	 * @return true, if it's a logic operator
	 */
	public static boolean isLogicOperator(char c) {
	    return c=='&' || c=='°';
	  }

	/**
	 * Checks if a char is a real operator, i.e. not NOP and not a delimiter.
	 * 
	 * @param c
	 *            the char
	 * @return true, if it's a real operator
	 */
	public static boolean isRealOperator(char c) {
		if (c == ',' || c == '|') {
			return false;
		}
		for (String op : OPS) {
			if (op.charAt(0) == c) {
				return true;
			}
		}
		return false;
	}

	/**
	 * Checks if a char is a comparison operator, i.e. <, > or =
	 * 
	 * @param c
	 *            the char
	 * @return true, if it's a comparison operator
	 */
	public static boolean isComparisonOperator(char c) {
		return c == '<' || c == '>' || c == '=';
	}

	/**
	 * Returns the type that this operator will "produce".
	 * 
	 * @return the type
	 */
	public int getType() {
		return type;
	}

	/**
	 * Sets the type that this operator will "produce".
	 * 
	 * @param type
	 *            the new type
	 */
	public void setType(int type) {
		this.type = type;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return OPS[type];
	}
}
