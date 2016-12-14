package com.sixtyfour.elements.functions;

import com.sixtyfour.elements.Type;
import com.sixtyfour.system.Machine;

/**
 * The USR function.
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
		// TODO: Support this. However, doing so would require to do a proper
		// conversion between the C64 float format and Java's.
		// I'm not sure, if this is really worth it...
		return 0f;
	}
}
