package com.sixtyfour.elements.functions;

import com.sixtyfour.elements.Type;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The TAN function.
 */
public class Tan extends AbstractFunction {

	/**
	 * Instantiates a new tan.
	 */
	public Tan() {
		super("TAN");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		return Type.REAL;
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
		if (!term.getType().equals(Type.STRING)) {
			return Float.valueOf((float) Math.tan(VarUtils.getFloat(term.eval(machine))));
		}
		throw new RuntimeException("Type mismatch error: " + term.getType());
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.functions.AbstractFunction#toCode(com.sixtyfour
	 * .system.Machine)
	 */
	@Override
	public String toCode(Machine machine) {
		String inter = term.toCode(machine);
		if (inter == null) {
			return null;
		}
		return "(float) Math.tan(" + inter + ")";
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
