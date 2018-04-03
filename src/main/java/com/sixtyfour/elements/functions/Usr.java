package com.sixtyfour.elements.functions;

import java.util.List;

import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.cbmnative.CodeContainer;
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
		return machine.getSystemCallListener().usr(term.eval(machine));
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.sixtyfour.elements.functions.AbstractFunction#evalToCode(com.sixtyfour
	 * .system.Machine)
	 */
	@Override
	public List<CodeContainer> evalToCode(Machine machine) {
		List<Atom> pars = Parser.getParameters(term);
		if (pars.size() != 1) {
			throw new RuntimeException("USR in compiled code only supports 1 numeric parameter!");
		}
		if (pars.get(0).getType() == Type.STRING) {
			throw new RuntimeException("Parameter for USR in compiled has to be numeric!");
		}

		return super.evalToCode(machine);
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
}
