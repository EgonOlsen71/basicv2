package sixtyfour.elements;

import sixtyfour.parser.Atom;
import sixtyfour.system.Machine;
import sixtyfour.util.VarUtils;

/**
 * The Class Constant.
 * 
 * @param <T>
 *            the generic type
 */
public class Constant<T> implements Atom {
	
	/** The value. */
	private T value;
	
	/** The type. */
	private Type type;

	/**
	 * Instantiates a new constant.
	 * 
	 * @param value
	 *            the value
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

	/* (non-Javadoc)
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		return type;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public T eval(Machine machine) {
		return value;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.parser.Atom#isTerm()
	 */
	@Override
	public boolean isTerm() {
		return false;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return value.toString();
	}

}
