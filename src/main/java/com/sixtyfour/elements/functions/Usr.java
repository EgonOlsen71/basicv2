/*
 * 
 */
package com.sixtyfour.elements.functions;

import com.sixtyfour.elements.Type;
import com.sixtyfour.system.Machine;

/**
 * The Class Usr.
 */
public class Usr extends AbstractFunction {

	/**
	 * Instantiates a new usr.
	 */
	public Usr() {
		super("USR");
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		return 0f;
	}
}
