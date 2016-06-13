package sixtyfour.elements.functions;

import sixtyfour.elements.Type;
import sixtyfour.system.Machine;

public class Len extends AbstractFunction {

	public Len() {
		super("Len");
	}

	@Override
	public Type getType() {
		return Type.INTEGER;
	}

	@Override
	public Object eval(Machine memory) {
		if (term.getType().equals(Type.STRING)) {
			String str = (String) term.eval(memory);
			if (str == null) {
				return 0;
			}
			return str.length();
		}
		throw new RuntimeException("Type mismatch error: " + term.getType());
	}
}
