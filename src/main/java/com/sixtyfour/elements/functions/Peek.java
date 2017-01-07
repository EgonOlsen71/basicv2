package com.sixtyfour.elements.functions;

import com.sixtyfour.elements.Type;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The PEEK function.
 */
public class Peek extends AbstractFunction {

	/**
	 * Instantiates a new peek.
	 */
	public Peek() {
		super("PEEK");
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		if (!getType().equals(Type.STRING)) {
			int addr = VarUtils.getInt(term.eval(machine));
			int peeked = Integer.valueOf(machine.getRam()[addr]) & 0xff;
			Integer peekedAsWell = machine.getMemoryListener().peek(addr);
			if (peekedAsWell != null) {
				peeked = peekedAsWell.intValue() & 0xff;
			}
			return peeked;
		}
		throw new RuntimeException("Type mismatch error: " + getType());
	}
}
