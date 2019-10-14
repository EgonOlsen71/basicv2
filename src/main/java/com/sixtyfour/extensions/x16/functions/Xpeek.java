package com.sixtyfour.extensions.x16.functions;

import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.functions.AbstractFunction;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The XPEEK function....in preparation of an extended PEEK for the X16...
 * Currently, it's not used...
 */
public class Xpeek extends AbstractFunction {

	/**
	 * Instantiates a new peek.
	 */
	public Xpeek() {
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

	@Override
	public boolean isOverride() {
		return true;
	}

	@Override
	public String getNativeFunctionName() {
		return getName();
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.functions.AbstractFunction#isDeterministic()
	 */
	@Override
	public boolean isDeterministic() {
		return false;
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
