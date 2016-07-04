/*
 * 
 */
package sixtyfour.elements.functions;

import sixtyfour.elements.Type;
import sixtyfour.system.Machine;
import sixtyfour.util.VarUtils;

/**
 * The Class Sgn.
 */
public class Sgn extends AbstractFunction {

	/**
	 * Instantiates a new sgn.
	 */
	public Sgn() {
		super("SGN");
	}

	/* (non-Javadoc)
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		return term.getType();
	}

	/* (non-Javadoc)
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		if (!getType().equals(Type.STRING)) {
			return Float.valueOf((float) Math.signum(VarUtils.getFloat(term.eval(machine))));
		}
		throw new RuntimeException("Type mismatch error: " + getType());
	}

}
