package sixtyfour.elements;

public class Operator {
	private final static String[] OPS = { "^", "*", "/", "+", "-", "|", ",", "°", "&", "!" };
	public final static Operator NOP = new Operator('|');

	private int type = -1;

	public static String getOrOperator() {
		return OPS[7];
	}

	public static String getAndOperator() {
		return OPS[8];
	}

	public static String getNotOperator() {
		return OPS[9];
	}

	public Operator(char c) {
		this(Character.toString(c));
	}

	public boolean isOr() {
		return type == 7;
	}

	public boolean isAnd() {
		return type == 8;
	}

	public boolean isNot() {
		return type == 9;
	}

	public boolean isPlus() {
		return type == 3;
	}

	public boolean isPower() {
		return type == 0;
	}

	public boolean isMinus() {
		return type == 4;
	}

	public boolean isMultiplication() {
		return type == 1;
	}

	public boolean isDivision() {
		return type == 2;
	}

	public boolean isDelimiter() {
		return type == 6;
	}

	public boolean isNop() {
		return type == 5;
	}

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

	public static boolean isOperator(char c) {
		for (String op : OPS) {
			if (op.charAt(0) == c) {
				return true;
			}
		}
		return false;
	}

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

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	@Override
	public String toString() {
		return OPS[type];
	}
}
