package sixtyfour.elements.functions;

import sixtyfour.elements.Type;
import sixtyfour.system.Machine;

public class Abs extends AbstractFunction {
	public Abs() {
		super("ABS");
	}

	@Override
	public Type getType() {
		return term.getType();
	}

	@Override
	public Object eval(Machine memory) {
		if (!term.getType().equals(Type.STRING)) {
			float val = Math.abs(((Number) term.eval(memory)).floatValue());
			if (term.getType().equals(Type.REAL)) {
				return val;
			} else {
				return (int) val;
			}
		}
		throw new RuntimeException("Formula too complex error: " + this);
	}

}
