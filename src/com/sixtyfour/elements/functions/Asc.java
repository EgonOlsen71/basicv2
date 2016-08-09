/*
 * 
 */
package com.sixtyfour.elements.functions;

import com.sixtyfour.elements.Type;
import com.sixtyfour.system.Machine;

/**
 * The Class Asc.
 */
public class Asc extends AbstractFunction {

	/**
	 * Instantiates a new asc.
	 */
	public Asc() {
		super("ASC");
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
			String str = (String) term.eval(machine);
			if (str == null || str.length() == 0) {
				throw new RuntimeException("Illegal quantity error: " + this);
			}
			return (int) str.charAt(0);
		}
		throw new RuntimeException("Type mismatch error: " + term.getType());
	}
}
