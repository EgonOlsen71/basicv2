package com.sixtyfour.elements;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * A constant of some type.
 * 
 * @param <T> the generic type
 */
public class Constant<T> implements Atom {

	/** The value. */
	private T value;

	/** The type. */
	private Type type;

	/**
	 * Instantiates a new constant.
	 * 
	 * @param value the value
	 */
	public Constant(T value) {
		this.value = value;
		if (VarUtils.isInteger(value)) {
			type = Type.INTEGER;
		} else if (VarUtils.isFloat(value)) {
			type = Type.REAL;
		} else if (VarUtils.isString(value)) {
			type = Type.STRING;
		} else {
			throw new RuntimeException("Type mismatch error: " + value);
		}
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		List<String> ret = new ArrayList<String>();
		ret.add("#" + value.toString() + "{" + type + "}");
		List<CodeContainer> cc = new ArrayList<CodeContainer>();
		cc.add(new CodeContainer(ret));
		return cc;
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
		if (o instanceof Constant) {
			if (o == this) {
				return true;
			}
			return this.value.equals(((Constant<?>) o).value);
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
		return value.hashCode();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		return type;
	}

	@Override
	public Type getType(boolean ignoreMt) {
		return type;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public T eval(Machine machine) {
		return value;
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return value.toString();
	}

	@Override
	public String toCode(Machine machine) {
		if (VarUtils.isInteger(value)) {
			return String.valueOf(VarUtils.getInt(value));
		} else if (VarUtils.isFloat(value)) {
			return String.valueOf(VarUtils.getFloat(value));
		} else if (VarUtils.isString(value)) {
			return "\"" + value.toString() + "\"";
		} else {
			throw new RuntimeException("Type mismatch error: " + value);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.parser.Atom#isConstant()
	 */
	@Override
	public boolean isConstant() {
		return true;
	}

}
