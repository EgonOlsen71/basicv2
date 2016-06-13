package sixtyfour.elements.functions;

import sixtyfour.elements.Type;
import sixtyfour.system.Machine;

public class Sqr extends AbstractFunction {

	public Sqr() {
		super("SQR");
	}

	@Override
	public Type getType() {
		return Type.REAL;
	}

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
