package sixtyfour.elements;

import sixtyfour.Memory;

public class Term implements Atom {
	private Atom left;
	private Atom right;
	private Operator operator;
	private String expression;
	private String key;

	public Term(String expression) {
		this.setExpression(expression);
	}

	public Term(Atom left) {
		this.left = left;
		this.operator = Operator.NOP;
		this.right = new Constant<Integer>(0);
	}

	public boolean isComplete() {
		return left != null && right != null && operator != null;
	}

	public boolean isEmpty() {
		return left == null || (left instanceof Term && ((Term) left).isEmpty());
	}

	public Atom getLeft() {
		return left;
	}

	public void setLeft(Atom left) {
		// System.out.println("Left: "+left);
		this.left = left;
	}

	public Atom getRight() {
		return right;
	}

	public void setRight(Atom right) {
		// System.out.println("Right: "+right);
		this.right = right;
	}

	public Operator getOperator() {
		return operator;
	}

	public void setOperator(Operator operator) {
		this.operator = operator;
	}

	public String getExpression() {
		return expression;
	}

	public void setExpression(String expression) {
		this.expression = expression;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	@Override
	public String toString() {
		return "([" + key + "]" + left + this.operator + right + ")";
	}

	@Override
	public Type getType() {
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
		return t1;
	}

	@Override
	public Object eval(Memory memory) {
		try {
			memory.setCurrentOperator(operator);
			if (operator.isNop()) {
				return left.eval(memory);
			}
			Type type = getType();
			if (type.equals(Type.STRING)) {
				if (operator.isPlus()) {
					return left.eval(memory).toString() + right.eval(memory).toString();
				}
			} else {
				Number n1 = (Number) left.eval(memory);
				Number n2 = (Number) right.eval(memory);
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
				if (type.equals(Type.INTEGER)) {
					return (int) v1;
				}
				return v1;
			}
			throw new RuntimeException("Unable to evaluate term: " + this.toString());
		} finally {
			memory.setCurrentOperator(null);
		}
	}

}
