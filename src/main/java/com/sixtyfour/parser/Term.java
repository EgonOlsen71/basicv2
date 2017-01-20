package com.sixtyfour.parser;

import com.sixtyfour.elements.Constant;
import com.sixtyfour.elements.Type;
import com.sixtyfour.system.Machine;

/**
 * A Term is a (part of a) calculation or a logical operation. Terms have two
 * children (left and right) and an operator that connects the two.
 */
public class Term implements Atom {

	/** The left child */
	private Atom left;

	/** The right child */
	private Atom right;

	/** The operator that connects the two children */
	private Operator operator;

	/** The expression that created this Term */
	private String expression;

	/** The key for term replacement while parsing */
	private String key;

	/** The type that the Term returns */
	private Type type;

	/**
	 * Instantiates a new term based on the given expression.
	 * 
	 * @param expression
	 *            the expression
	 */
	public Term(String expression) {
		this.setExpression(expression);
	}

	/**
	 * Instantiates a new term with an Atom as left child and a 0 as the right
	 * child. The operator is a NOP.
	 * 
	 * @param left
	 *            the left child
	 */
	public Term(Atom left) {
		this.left = left;
		this.operator = Operator.NOP;
		this.right = new Constant<Integer>(0);
	}

	/**
	 * Checks if the Term is complete. A complete term has two children and an
	 * operator.
	 * 
	 * @return true, if it's complete
	 */
	public boolean isComplete() {
		return left != null && right != null && operator != null;
	}

	/**
	 * Checks if the term is empty.
	 * 
	 * @return true, if it's empty
	 */
	public boolean isEmpty() {
		return left == null || (left.isTerm() && ((Term) left).isEmpty());
	}

	/**
	 * Returns the left child.
	 * 
	 * @return the left child
	 */
	public Atom getLeft() {
		return left;
	}

	/**
	 * Sets the left child.
	 * 
	 * @param left
	 *            the new left child
	 */
	public void setLeft(Atom left) {
		this.left = left;
	}

	/**
	 * Returns the right child.
	 * 
	 * @return the right child
	 */
	public Atom getRight() {
		return right;
	}

	/**
	 * Sets the right child.
	 * 
	 * @param right
	 *            the new right child
	 */
	public void setRight(Atom right) {
		this.right = right;
	}

	/**
	 * Returns the operator.
	 * 
	 * @return the operator
	 */
	public Operator getOperator() {
		return operator;
	}

	/**
	 * Sets the operator.
	 * 
	 * @param operator
	 *            the new operator
	 */
	public void setOperator(Operator operator) {
		this.operator = operator;
	}

	/**
	 * Returns the expression.
	 * 
	 * @return the expression
	 */
	public String getExpression() {
		return expression;
	}

	/**
	 * Sets the expression.
	 * 
	 * @param expression
	 *            the new expression
	 */
	public void setExpression(String expression) {
		this.expression = expression;
	}

	/**
	 * Returns the key. The key is used for internal replacement of parts of a
	 * term (as text) by placeholders.
	 * 
	 * @return the key
	 */
	public String getKey() {
		return key;
	}

	/**
	 * Sets the key. The key is used for internal replacement of parts of a term
	 * (as text) by placeholders.
	 * 
	 * @param key
	 *            the new key
	 */
	public void setKey(String key) {
		this.key = key;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "([" + key + "]\\l:" + left + this.operator + "\\r:" + right + ")";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		if (type != null) {
			return type;
		}
		Type t1 = left.getType();
		Type t2 = t1;
		if (operator != Operator.NOP) {
			t2 = right.getType();
		}
		if (operator.isDelimiter()) {
			return t1;
		}
		if (t1.equals(Type.INTEGER) && t2.equals(Type.REAL)) {
			return t2;
		}
		if (t1.equals(Type.REAL) && t2.equals(Type.INTEGER)) {
			return t1;
		}
		if (!t1.equals(t2)) {
			throw new RuntimeException("Type mismatch error: " + this.toString() + " | " + left + " | " + right + " | " + t1 + "/" + t2 + "/" + operator.getType());
		}
		type = t1;
		return t1;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		try {
			machine.setCurrentOperator(operator);
			if (operator.isNop()) {
				if (left == null) {
					throw new RuntimeException("Syntax error!");
				}
				return left.eval(machine);
			}
			Type type = getType();
			if (type == Type.STRING) {
				if (operator.isPlus()) {
					return left.eval(machine).toString() + right.eval(machine).toString();
				}
			} else {
				Number n1 = (Number) left.eval(machine);
				Number n2 = n1;
				if (left != right) {
					n2 = (Number) right.eval(machine);
				}

				float v1 = 0;
				if (operator.isPlus()) {
					v1 = n1.floatValue() + n2.floatValue();
				} else if (operator.isMinus()) {
					v1 = n1.floatValue() - n2.floatValue();
				} else if (operator.isPower()) {
					v1 = (float) Math.pow(n1.doubleValue(), n2.doubleValue());
				} else if (operator.isMultiplication()) {
					v1 = n1.floatValue() * n2.floatValue();
				} else if (operator.isDivision()) {
					if (n2.floatValue() == 0) {
						throw new RuntimeException("Division by zero error: " + n1 + "/" + n2);
					}
					v1 = n1.floatValue() / n2.floatValue();
				} else if (operator.isOr()) {
					v1 = n1.intValue() | n2.intValue();
				} else if (operator.isAnd()) {
					v1 = n1.intValue() & n2.intValue();
				} else if (operator.isNot()) {
					v1 = ~n2.intValue();
				}
				return v1;
			}
			throw new RuntimeException("Unable to evaluate term: " + this.toString());
		} finally {
			machine.setCurrentOperator(null);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#isTerm()
	 */
	@Override
	public boolean isTerm() {
		return true;
	}

}
