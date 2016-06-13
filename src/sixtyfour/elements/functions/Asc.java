package sixtyfour.elements.functions;

import sixtyfour.elements.Type;
import sixtyfour.system.Machine;

public class Asc extends AbstractFunction {

	public Asc() {
		super("ASC");
	}

	@Override
	public Type getType() {
		return Type.INTEGER;
	}

	@Override
	public Object eval(Machine memory) {
		if (term.getType().equals(Type.STRING)) {
			String str = (String) term.eval(memory);
			if (str == null || str.length()==0) {
				throw new RuntimeException("Illegal quantity error: "+this);
			}
			return (int) str.charAt(0);
		}
		throw new RuntimeException("Type mismatch error: " + term.getType());
	}
}
