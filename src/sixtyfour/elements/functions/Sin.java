package sixtyfour.elements.functions;

import sixtyfour.elements.Type;

public class Sin extends AbstractFunction {

	public Sin() {
		super("SIN");
	}

	@Override
	public Type getType() {
		return term.getType();
	}

	@Override
	public Object eval() {
		if (!getType().equals(Type.STRING) && !getType().equals(Type.ARRAY)) {
			return Float.valueOf((float) Math.sin(((Number) term.eval()).floatValue()));
		}
		throw new RuntimeException("Type mismatch error: " + getType());
	}

}
