/*
 * 
 */
package com.sixtyfour.elements.functions;

import com.sixtyfour.elements.Type;
import com.sixtyfour.system.Machine;

/**
 * The Class Len.
 */
public class Len extends AbstractFunction {

	/**
	 * Instantiates a new len.
	 */
	public Len() {
		super("Len");
	}

	/* (non-Javadoc)
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		return Type.INTEGER;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		if (term.getType().equals(Type.STRING)) {
			String str = (String) term.eval(machine);
			if (str == null) {
				return 0;
			}
			return str.length();
		}
		throw new RuntimeException("Type mismatch error: " + term.getType());
	}
}
