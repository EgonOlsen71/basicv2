/*
 * 
 */
package sixtyfour.parser;

/**
 * The Class Operator.
 */
public class Operator {
	
	/** The Constant OPS. */
	private final static String[] OPS = { "^", "*", "/", "+", "-", "|", ",", "°", "&", "!" };
	
	/** The Constant NOP. */
	public final static Operator NOP = new Operator('|');

	/** The type. */
	private int type = -1;

	/**
	 * Gets the or operator.
	 * 
	 * @return the or operator
	 */
	public static String getOrOperator() {
		return OPS[7];
	}

	/**
	 * Gets the and operator.
	 * 
	 * @return the and operator
	 */
	public static String getAndOperator() {
		return OPS[8];
	}

	/**
	 * Gets the not operator.
	 * 
	 * @return the not operator
	 */
	public static String getNotOperator() {
		return OPS[9];
	}

	/**
	 * Instantiates a new operator.
	 * 
	 * @param c
	 *            the c
	 */
	public Operator(char c) {
		this(Character.toString(c));
	}

	/**
	 * Checks if is or.
	 * 
	 * @return true, if is or
	 */
	public boolean isOr() {
		return type == 7;
	}

	/**
	 * Checks if is and.
	 * 
	 * @return true, if is and
	 */
	public boolean isAnd() {
		return type == 8;
	}

	/**
	 * Checks if is not.
	 * 
	 * @return true, if is not
	 */
	public boolean isNot() {
		return type == 9;
	}

	/**
	 * Checks if is plus.
	 * 
	 * @return true, if is plus
	 */
	public boolean isPlus() {
		return type == 3;
	}

	/**
	 * Checks if is power.
	 * 
	 * @return true, if is power
	 */
	public boolean isPower() {
		return type == 0;
	}

	/**
	 * Checks if is minus.
	 * 
	 * @return true, if is minus
	 */
	public boolean isMinus() {
		return type == 4;
	}

	/**
	 * Checks if is multiplication.
	 * 
	 * @return true, if is multiplication
	 */
	public boolean isMultiplication() {
		return type == 1;
	}

	/**
	 * Checks if is division.
	 * 
	 * @return true, if is division
	 */
	public boolean isDivision() {
		return type == 2;
	}

	/**
	 * Checks if is delimiter.
	 * 
	 * @return true, if is delimiter
	 */
	public boolean isDelimiter() {
		return type == 6;
	}

	/**
	 * Checks if is nop.
	 * 
	 * @return true, if is nop
	 */
	public boolean isNop() {
		return type == 5;
	}

	/**
	 * Instantiates a new operator.
	 * 
	 * @param op
	 *            the op
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
	 * Checks if is operator.
	 * 
	 * @param c
	 *            the c
	 * @return true, if is operator
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
	 * Checks if is real operator.
	 * 
	 * @param c
	 *            the c
	 * @return true, if is real operator
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
	 * Gets the type.
	 * 
	 * @return the type
	 */
	public int getType() {
		return type;
	}

	/**
	 * Sets the type.
	 * 
	 * @param type
	 *            the new type
	 */
	public void setType(int type) {
		this.type = type;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return OPS[type];
	}
}
