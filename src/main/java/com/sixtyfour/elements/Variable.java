package com.sixtyfour.elements;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.CommandList;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.elements.functions.FunctionList;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * A variable. This can either be a simple variable or an array.
 */
public class Variable implements Atom {

	/** The name. */
	private String name;

	/**
   * 
   */
	private String upperCaseName;

	/** The type. */
	private Type type;

	/** The array. */
	private boolean array = false;

	/** The value. */
	private Object value;

	/** The dimensions. */
	private int[] dimensions;

	/**
	 * Instantiates a new array variable.
	 * 
	 * @param name
	 *            the name of the variable
	 * @param values
	 *            the values in form of a list.
	 * @param dimensions
	 *            the dimensions. If this variable is a multi-dimensional array,
	 *            the list of values will be mapped according to these
	 *            dimensions.
	 */
	public Variable(String name, List<Object> values, int... dimensions) {
		this(name, values == null ? new ArrayList<Object>(calcSize(dimensions)) : (Object) values);
		this.dimensions = dimensions;
		array = true;
		this.setName(name.endsWith("[]") ? name : (name + "[]"));
	}

	/**
	 * Instantiates a new variable with a simple value.
	 * 
	 * @param name
	 *            the name of the variable
	 * @param value
	 *            the value. Depending on the type (determined by the name),
	 *            this value will be parsed into the actual instance type. If
	 *            value is null, a default value will be created instead.
	 */
	public Variable(String name, Object value) {
		// Check name for validity
		String un = VarUtils.toUpper(name);
		List<Command> commands = CommandList.getCommands();
		for (Command command : commands) {
			if (un.contains(command.getName())) {
				throw new RuntimeException("Syntax error: " + un);
			}
		}
		List<Function> functions = FunctionList.getFunctions();
		for (Function function : functions) {
			if (un.contains(function.getName())) {
				throw new RuntimeException("Syntax error: " + un);
			}
		}

		String woa = name.replace("[]", "");
		char c = woa.charAt(woa.length() - 1);
		type = null;
		if (c == '$') {
			type = Type.STRING;
		} else if (c == '%') {
			type = Type.INTEGER;
		} else if (Character.isLetter(c) || Character.isDigit(c)) {
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

		// Limit to the first 2 chars...if needed (not for internal _-vars)
		if (!name.startsWith("_")) {
			StringBuilder sb = new StringBuilder();
			int alphaCount = 0;
			for (int i = 0; i < name.length(); i++) {
				char cc = name.charAt(i);
				if (Character.isLetter(cc) || Character.isDigit(cc)) {
					alphaCount++;
					if (alphaCount <= 2) {
						sb.append(cc);
					}
				} else {
					sb.append(cc);
				}
			}
			name = sb.toString();
		}

		this.setName(name);
		this.setValue(value);
	}

	/**
	 * Clears the variable by setting it back to its default.
	 */
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

	/**
	 * Checks if the variable is an array.
	 * 
	 * @return true, if it is an array
	 */
	public boolean isArray() {
		return array;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#getType()
	 */
	public Type getType() {
		return type;
	}

	/**
	 * Sets the type.
	 * 
	 * @param type
	 *            the new type
	 */
	public void setType(Type type) {
		this.type = type;
	}

	/**
	 * Gets the name.
	 * 
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * Sets the name.
	 * 
	 * @param name
	 *            the new name
	 */
	public void setName(String name) {
		this.name = name;
		this.upperCaseName = VarUtils.toUpper(name);
	}

	/**
	 * Gets the name in upper case.
	 * 
	 * @return
	 */
	public String getUpperCaseName() {
		return upperCaseName;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return name.hashCode();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@SuppressWarnings("unchecked")
	@Override
	public String toString() {
		if (!array) {
			return name + "{" + value + "}";
		} else {
			return name + "{" + Arrays.toString(((List<Object>) value).toArray()) + "}";
		}
	}

	/**
	 * Returns number of elements. If the variable isn't an array, 1 will be
	 * returned.
	 * 
	 * @return the number of elements
	 */
	@SuppressWarnings("unchecked")
	public int elements() {
		if (!array) {
			return 1;
		}
		return ((List<Object>) value).size();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		return value;
	}

	/**
	 * Gets the value of a non-array variable.
	 * 
	 * @return the value
	 */
	public Object getValue() {
		if (array) {
			throw new RuntimeException("Not a simple type: " + this);
		}
		return value;
	}

	/**
	 * Sets the value of a non-array variable.
	 * 
	 * @param value
	 *            the new value
	 */
	public void setValue(Object value) {
		if (array) {
			throw new RuntimeException("Not a simple type: " + this);
		}
		// Convert into proper format
		if (VarUtils.isFloat(value) && type.equals(Type.INTEGER)) {
			value = VarUtils.getInt(value);
		} else if (VarUtils.isInteger(value) && type.equals(Type.REAL)) {
			value = VarUtils.getFloat(value);
		}
		this.value = value;
	}

	/**
	 * Gets the value of an array element.
	 * 
	 * @param pos
	 *            the position in the array
	 * @return the value
	 */
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

		if (pos.length == 1) {
			// Fast path for one-dimensional arrays
			ap = pos[0];
		} else {
			int m = 1;
			for (int p : pos) {
				ap += m * p;
				m *= (dimensions[cnt] + 1);
				cnt++;
			}
		}
		return ((List<Object>) value).get(ap);
	}

	/**
	 * Sets the value of an array element.
	 * 
	 * @param val
	 *            the value
	 * @param pos
	 *            the position in the array
	 * @return the value
	 */
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

		if (pos.length == 1) {
			// Fast path for one-dimensional arrays
			ap = pos[0];
		} else {
			int m = 1;
			for (int p : pos) {
				ap += m * p;
				m *= (dimensions[cnt] + 1);
				cnt++;
			}
		}

		if (VarUtils.isFloat(val) && type.equals(Type.INTEGER)) {
			val = VarUtils.getInt(val);
		} else if (VarUtils.isInteger(val) && type.equals(Type.REAL)) {
			val = VarUtils.getFloat(val);
		}

		List<Object> ovalue = (List<Object>) value;

		if (ap >= ovalue.size() || ap < 0) {
			throw new RuntimeException("Array index out of range: " + name + "(" + val + "/" + ovalue.size() + ")");
		}
		return ovalue.set(ap, val);
	}

	/**
	 * Increments the variable's value by the given value.
	 * 
	 * @param value
	 *            the value to add
	 */
	public void inc(float value) {
		if (type.equals(Type.INTEGER) || type.equals(Type.REAL)) {
			this.value = VarUtils.getFloat(this.value) + value;
		} else {
			throw new RuntimeException("Type mismatch error: " + this);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#isTerm()
	 */
	@Override
	public boolean isTerm() {
		return false;
	}

	/**
	 * Calc size.
	 * 
	 * @param dimensions
	 *            the dimensions
	 * @return the int
	 */
	private static int calcSize(int[] dimensions) {
		int size = 1;
		for (int i : dimensions) {
			size *= (i + 1);
		}
		return size;
	}
}
