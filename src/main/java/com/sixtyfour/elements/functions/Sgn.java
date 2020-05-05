package com.sixtyfour.elements.functions;

import com.sixtyfour.elements.Type;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The SGN function.
 */
public class Sgn extends AbstractFunction {

	/**
	 * Instantiates a new sgn.
	 */
	public Sgn() {
		super("SGN");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		return term.getType();
	}

	@Override
	public Type getParameterType() {
		return Type.REAL;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		if (!getType().equals(Type.STRING)) {
			return Float.valueOf((float) Math.signum(VarUtils.getFloat(term.eval(machine))));
		}
		throw new RuntimeException("Type mismatch error: " + getType());
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.functions.AbstractFunction#getParameterCount()
	 */
	public int getParameterCount() {
		return 1;
	}

}
