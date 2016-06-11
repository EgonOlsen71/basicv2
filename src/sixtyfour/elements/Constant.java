package sixtyfour.elements;

import sixtyfour.system.Machine;

public class Constant<T> implements Atom {
	private T value;

	public Constant(T value) {
		this.value = value;
	}

	public T getValue() {
		return value;
	}

	public String getStringValue() {
		return value.toString();
	}

	public float getRealValue() {
		if (value instanceof Float) {
			return (Float) value;
		}

		if (value instanceof Integer) {
			return Float.valueOf((Integer) value);
		}

		return Float.valueOf(this.getStringValue());
	}

	public int getIntValue() {
		if (value instanceof Float) {
			return ((Float) value).intValue();
		}

		if (value instanceof Integer) {
			return (Integer) value;
		}

		return Integer.valueOf(this.getStringValue());
	}

	@Override
	public String toString() {
		return value.toString();
	}

	@Override
	public Type getType() {
		if (value instanceof Integer) {
			return Type.INTEGER;
		}
		if (value instanceof Float) {
			return Type.REAL;
		}
		if (value instanceof String) {
			return Type.STRING;
		}
		throw new RuntimeException("Type mismatch error: " + this.toString());
	}

	@Override
	public Object eval(Machine memory) {
		if (value instanceof Integer) {
			return (Integer) value;
		}
		if (value instanceof Float) {
			return (Float) value;
		}
		if (value instanceof String) {
			return (String) value;
		}
		throw new RuntimeException("Type mismatch error: " + this.toString());
	}

}
