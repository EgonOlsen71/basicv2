package sixtyfour.elements.functions;

import sixtyfour.elements.Type;
import sixtyfour.system.Machine;

public class Cos extends AbstractFunction {

	public Cos() {
		super("COS");
	}

	@Override
	public Type getType() {
		return term.getType();
	}

	@Override
	public Object eval(Machine memory) {
		if (!getType().equals(Type.STRING)) {
			return Float.valueOf((float) Math.cos(((Number) term.eval(memory)).floatValue()));
		}
		throw new RuntimeException("Type mismatch error: " + getType());
	}

}
