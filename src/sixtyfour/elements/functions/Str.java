package sixtyfour.elements.functions;

import sixtyfour.elements.Type;
import sixtyfour.system.Machine;

public class Str extends AbstractFunction {

	public Str() {
		super("STR$");
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
		Float num = ((Number) term.eval(memory)).floatValue();
		String str = num.toString();
		if (num.floatValue() == (int) num.floatValue()) {
			str = str.substring(0, str.length() - 2);
		}
		if (num > 0) {
			str = " " + str;
		}
		return str;
	}
}
