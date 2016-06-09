package sixtyfour.elements.functions;

import sixtyfour.Memory;
import sixtyfour.elements.Type;

public class Cos extends AbstractFunction {

	public Cos() {
		super("COS");
	}

	@Override
	public Type getType() {
		return term.getType();
	}

	@Override
	public Object eval(Memory memory) {
		if (!getType().equals(Type.STRING) && !getType().equals(Type.ARRAY)) {
			return Float.valueOf((float) Math.cos(((Number) term.eval(memory)).floatValue()));
		}
		throw new RuntimeException("Type mismatch error: " + getType());
	}

}
