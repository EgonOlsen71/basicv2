/*
 * 
 */
package sixtyfour.elements.functions;

import sixtyfour.elements.Type;
import sixtyfour.system.Machine;

/**
 * The Class Sqr.
 */
public class Sqr extends AbstractFunction {

	/**
	 * Instantiates a new sqr.
	 */
	public Sqr() {
		super("SQR");
	}

	/* (non-Javadoc)
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		return Type.REAL;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine memory) {
		if (!term.getType().equals(Type.STRING)) {
			float val=((Number) term.eval(memory)).floatValue();
			if (val<0) {
				throw new RuntimeException("Illegal quantity error: "+val);
			}
			return Float.valueOf((float) Math.sqrt(val));
		}
		throw new RuntimeException("Type mismatch error: " + term.getType());
	}

}
