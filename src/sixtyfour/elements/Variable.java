package sixtyfour.elements;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import sixtyfour.Memory;

public class Variable implements Atom {
	private String name;
	private Type type;
	private boolean array = false;
	private Object value;
	private int[] dimensions;

	public Variable(String name, List<Object> values, int... dimensions) {
		this(name, values == null ? new ArrayList<Object>(calcSize(dimensions)) : (Object) values);
		this.dimensions = dimensions;
		array = true;
		this.setName(name + "[]");
	}

	public Variable(String name, Object value) {
		String woa=name.replace("[]", "");
		char c = woa.charAt(woa.length() - 1);
		type = null;
		if (c == '$') {
			type = Type.STRING;
		} else if (c == '%') {
			type = Type.INTEGER;
		} else if (Character.isAlphabetic(c) || Character.isDigit(c)) {
			type = Type.REAL;
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
		}

		this.setName(name);
		this.setValue(value);
	}

	@SuppressWarnings("unchecked")
	public void clear() {
		if (array) {
			List<Object> vals = ((List<Object>) value);
			vals.clear();
			for (int i = 0; i < calcSize(dimensions); i++) {
				if (type == Type.STRING) {
					vals.add("");
				}
				if (type == Type.INTEGER) {
					vals.add(0);
				}
				if (type == Type.REAL) {
					vals.add(0f);
				}
			}
		} else {
			if (type == Type.STRING) {
				value = "";
			}
			if (type == Type.INTEGER) {
				value = 0;
			}
			if (type == Type.REAL) {
				value = 0f;
			}
		}
	}

	public boolean isArray() {
		return array;
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

	@SuppressWarnings("unchecked")
	@Override
	public String toString() {
		if (!array) {
			return name + "{" + value + "}";
		} else {
			return name + "{" + Arrays.toString(((List<Object>) value).toArray()) + "}";
		}
	}

	@SuppressWarnings("unchecked")
	public int elements() {
		if (!array) {
			return 1;
		}
		return ((List<Object>) value).size();
	}

	@Override
	public Object eval(Memory memory) {
		return value;
	}

	public Object getValue() {
		if (array) {
			throw new RuntimeException("Not a simple type: " + this);
		}
		return value;
	}

	public void setValue(Object value) {
		if (array) {
			throw new RuntimeException("Not a simple type: " + this);
		}
		this.value = value;
	}

	@SuppressWarnings("unchecked")
	public Object getValue(int... pos) {
		if (!array) {
			throw new RuntimeException("Not an array type: " + this);
		}
		int ap = 0;
		int cnt = 0;

		if (pos.length != dimensions.length) {
			throw new RuntimeException("Array indices don't match: " + this);
		}

		int m = 1;
		for (int p : pos) {
			ap += m * p;
			m *= (dimensions[cnt] + 1);
			cnt++;
		}
		return ((List<Object>) value).get(ap);
	}

	@SuppressWarnings("unchecked")
	public Object setValue(Object val, int... pos) {
		if (!array) {
			throw new RuntimeException("Not an array type: " + this);
		}
		int ap = 0;
		int cnt = 0;

		if (pos.length != dimensions.length) {
			throw new RuntimeException("Array indices don't match: " + this);
		}

		int m = 1;
		for (int p : pos) {
			ap += m * p;
			m *= (dimensions[cnt] + 1);
			cnt++;
		}
		return ((List<Object>) value).set(ap, val);
	}

	public void inc(float value) {
		if (type.equals(Type.INTEGER) || type.equals(Type.REAL)) {
			this.value = ((Number) this.value).floatValue() + value;
		} else {
			throw new RuntimeException("Type mismatch error: " + this);
		}
	}

	private static int calcSize(int[] dimensions) {
		int size = 1;
		for (int i : dimensions) {
			size *= (i + 1);
		}
		return size;
	}
}
