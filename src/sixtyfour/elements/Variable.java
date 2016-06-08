package sixtyfour.elements;

public class Variable implements Atom {
	private String name;
	private Type type;
	private Object value;

	public Variable(String name, Object value) {
		char c = name.charAt(name.length() - 1);
		type = null;
		if (c == '$') {
			type = Type.STRING;
		} else if (c == '%') {
			type = Type.INTEGER;
		} else if (Character.isAlphabetic(c) || Character.isDigit(c)) {
			type = Type.REAL;
		}
		if (c == ']') {
			type = Type.ARRAY;
		}

		if (type == null) {
			throw new RuntimeException("Unknown variable type for: " + name);
		}

		if (value == null) {
			if (type == Type.STRING) {
				value = "";
			}
			if (type == Type.INTEGER) {
				value = 0;
			}
			if (type == Type.REAL) {
				value = 0f;
			}
			if (type == Type.ARRAY) {
				value = null;
			}
		}

		this.setName(name);
		this.setValue(value);
	}

	public Type getType() {
		return type;
	}

	public void setType(Type type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public boolean equals(Object o) {
		if (o == null) {
			return false;
		}
		if (o instanceof Variable) {
			return this.name.equalsIgnoreCase(((Variable) o).name);
		}
		return false;
	}

	@Override
	public int hashCode() {
		return name.hashCode();
	}

	@Override
	public String toString() {
		return name + "{" + value + "}";
	}

	@Override
	public Object eval() {
		return value;
	}

	public Object getValue() {
		return value;
	}

	public void setValue(Object value) {
		this.value = value;
	}
}
