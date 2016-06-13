package sixtyfour.elements.functions;

import sixtyfour.elements.Type;
import sixtyfour.system.Machine;

public class Chr extends AbstractFunction {

	public Chr() {
		super("CHR$");
	}

	@Override
	public Type getType() {
		return Type.STRING;
	}

	@Override
	public Object eval(Machine memory) {
		if (term.getType().equals(Type.STRING)) {
			throw new RuntimeException("Type mismatch error: " + term.getType());
		}
		Integer num = ((Number) term.eval(memory)).intValue();
		if (num < 0 || num > 255) {
			throw new RuntimeException("Illegal quantity error: " + num);
		}
		return Character.toString((char) num.intValue());

	}
}
