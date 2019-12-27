package com.sixtyfour.elements;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.CommandList;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.elements.functions.FunctionList;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.IntegerC;
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

	private boolean persistent = false;

	private boolean constant = false;

	/**
	 * Instantiates a new array variable.
	 * 
	 * @param name       the name of the variable
	 * @param values     the values in form of a list.
	 * @param dimensions the dimensions. If this variable is a multi-dimensional
	 *                   array, the list of values will be mapped according to these
	 *                   dimensions.
	 */
	public Variable(String name, List<Object> values, int... dimensions) {
		this(name, values == null ? createEmptyArray(dimensions) : (Object) values);
		this.dimensions = dimensions;
		array = true;
		this.setName(name.endsWith("[]") ? name : (name + "[]"));
	}

	/**
	 * Instantiates a new variable with a simple value.
	 * 
	 * @param name  the name of the variable
	 * @param value the value. Depending on the type (determined by the name), this
	 *              value will be parsed into the actual instance type. If value is
	 *              null, a default value will be created instead.
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

		if (!Character.isAlphabetic(un.charAt(0)) && un.equals("_")) {
			throw new RuntimeException("Syntax error: " + un);
		}

		String woa = name.replace("[]", "");
		char c = woa.charAt(woa.length() - 1);
		type = null;
		findType(c);

		if (type == null) {
			if (!Character.isAlphabetic(c) && !Character.isDigit(c)) {
				throw new RuntimeException("Syntax error: " + name + "/" + woa);
			} else {
				throw new RuntimeException("Unknown variable type for: " + name + "/" + woa);
			}
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

	private void findType(char c) {
		if (c == '$') {
			type = Type.STRING;
		} else if (c == '%') {
			type = Type.INTEGER;
		} else if (Character.isLetter(c) || Character.isDigit(c)) {
			type = Type.REAL;
		}
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		List<String> ret = new ArrayList<String>();
		ret.add(upperCaseName.toString() + "{" + type + "}");
		List<CodeContainer> cc = new ArrayList<CodeContainer>();
		cc.add(new CodeContainer(ret));
		return cc;
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
	 * Checks if the variable is an actual array. This method is allowed to return
	 * false an array variables that are supposed to be arrays but haven't been
	 * initialized yet.
	 * 
	 * @return true, if it is an array
	 */
	public boolean isArray() {
		return array;
	}

	/**
	 * Checks if the variable is supposed to be an array, but might not have been
	 * initialized as such yet. This will return true an all array variables,
	 * initialized or not.
	 * 
	 * @return true, if it is supposed to be an array
	 */
	public boolean isSupposedToBeArray() {
		return array || name.endsWith("[]");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#getType()
	 */
	public Type getType() {
		return type;
	}

	public Type getType(boolean ignoreMT) {
		return type;
	}

	/**
	 * Sets the type.
	 * 
	 * @param type the new type
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
	 * @param name the new name
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
			if (o == this) {
				return true;
			}
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
		if (!array || value == null) {
			return name + "{" + value + "/" + this.isConstant() + "}";
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
	 * @return
	 */
	public Object evalFromCode() {
		return value;
	}

	public boolean isReadOnly() {
		return false;
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
	 * @param value the new value
	 */
	public void setValue(Object value) {
		if (array) {
			throw new RuntimeException("Not a simple type: " + this);
		}
		if (value == this.value || value.equals(this.value)) {
			return;
		}
		// Convert into proper format
		if (type == Type.INTEGER && VarUtils.isFloat(value)) {
			value = IntegerC.valueOf(VarUtils.getInt(value));
		} else if (type == Type.REAL && VarUtils.isInteger(value)) {
			value = VarUtils.getFloat(value);
		}
		this.value = value;
	}

	/**
	 * Returns the actual value object regardless of type.
	 * 
	 * @return the value object
	 */
	public Object getInternalValue() {
		return value;
	}

	/**
	 * Gets the value of an array element.
	 * 
	 * @param pos the position in the array
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
			throw new RuntimeException(
					"Array indices don't match: " + this + "/" + pos.length + "/" + dimensions.length);
		}

		if (pos.length == 1) {
			// Fast path for one-dimensional arrays
			ap = pos[0];
		} else {
			int m = 1;
			for (int p : pos) {
				ap += m * p;
				m *= (dimensions[cnt] + 1);
				// System.out.println(ap+"/"+m+"/"+p);
				cnt++;
			}
		}
		return ((List<Object>) value).get(ap);
	}

	public int[] getDimensions() {
		return dimensions;
	}

	/**
	 * Sets the value of an array element.
	 * 
	 * @param val the value
	 * @param pos the position in the array
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

		if (type == Type.INTEGER && VarUtils.isFloat(val)) {
			val = IntegerC.valueOf(VarUtils.getInt(val));
		} else if (type == Type.REAL && VarUtils.isInteger(val)) {
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
	 * @param value the value to add
	 * @return the new value
	 */
	public float inc(float value) {
		if (type == Type.INTEGER) {
			int ret = (int) (VarUtils.getInt(this.value) + value);
			this.value = IntegerC.valueOf(ret);
			return ret;
		} else if (type == Type.REAL) {
			float ret = VarUtils.getFloat(this.value) + value;
			this.value = ret;
			return ret;
		}
		throw new RuntimeException("Type mismatch error: " + this);
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
	 * Returns true, if the variable is persistent in a machine's context.
	 * 
	 * @return is it?
	 */
	public boolean isPersistent() {
		return persistent;
	}

	/**
	 * Marks the variable as persistent in a machines context, i.e. it "belongs" to
	 * that machine.
	 * 
	 * @param persistent is it persistent
	 */
	public void setPersistent(boolean persistent) {
		this.persistent = persistent;
	}

	@Override
	public String toCode(Machine machine) {
		if (array) {
			return null;
		}

		machine.getJit().addVariable(this);

		String nam = VarUtils.relabel(name);
		if (type == Type.REAL) {
			return "((Number) " + nam + ".evalFromCode()).floatValue()";
		} else if (type == Type.INTEGER) {
			return "((Number) " + nam + ".evalFromCode()).intValue()";
		}
		return nam + ".evalFromCode()";
	}

	public void setConstant(boolean constant) {
		this.constant = constant;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.parser.Atom#isConstant()
	 */
	@Override
	public boolean isConstant() {
		return constant;
	}

	/**
	 * Calc size.
	 * 
	 * @param dimensions the dimensions
	 * @return the int
	 */
	private static int calcSize(int[] dimensions) {
		int size = 1;
		for (int i : dimensions) {
			size *= (i + 1);
		}
		return size;
	}

	private static Object createEmptyArray(int[] dimensions) {
		int size = calcSize(dimensions);
		List<Object> ret = new ArrayList<Object>(size);
		for (int i = 0; i < size; i++) {
			ret.add(null);
		}
		return ret;
	}

}
