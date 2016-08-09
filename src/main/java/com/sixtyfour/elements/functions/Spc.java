/*
 * 
 */
package com.sixtyfour.elements.functions;

import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.commands.Print;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The Class Spc.
 */
public class Spc extends AbstractFunction {

	/** The Constant SPACES. */
	protected final static String SPACES;

	static {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < 255; i++) {
			sb.append(' ');
		}
		SPACES = sb.toString();
	}

	/**
	 * Instantiates a new spc.
	 * 
	 * @param name
	 *            the name
	 */
	protected Spc(String name) {
		super(name);
	}

	/**
	 * Instantiates a new spc.
	 */
	public Spc() {
		super("SPC");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		return Type.STRING;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		ensureContext(machine);
		if (term.getType().equals(Type.STRING)) {
			throw new RuntimeException("Type mismatch error: " + this);
		}
		int num = VarUtils.getInt(term.eval(machine));
		if (num < 0 || num > 255) {
			throw new RuntimeException("Illegal quantity error: " + this);
		}
		return SPACES.substring(0, num);
	}

	/**
	 * Ensure context.
	 * 
	 * @param machine
	 *            the machine
	 */
	protected void ensureContext(Machine machine) {
		if (!(machine.getCurrentCommand() instanceof Print) || !machine.getCurrentOperator().isNop()) {
			throw new RuntimeException("Systax error: " + this);
		}
	}
}
