/*
 * 
 */
package com.sixtyfour.elements.functions;

import com.sixtyfour.elements.Type;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The Class Int.
 */
public class Int extends AbstractFunction {

	/**
	 * Instantiates a new int.
	 */
	public Int() {
		super("INT");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		return Type.INTEGER;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		if (term.getType().equals(Type.STRING)) {
			throw new RuntimeException("Type mismatch error: " + term.getType());
		}
		return VarUtils.getInt(term.eval(machine));
	}

}
