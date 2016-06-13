package sixtyfour.elements.functions;

import sixtyfour.elements.Type;
import sixtyfour.system.Machine;

public class Fre extends AbstractFunction {
	public Fre() {
		super("FRE");
	}

	@Override
	public Type getType() {
		return Type.INTEGER;
	}

	@Override
	public Object eval(Machine memory) {
		return (int) Runtime.getRuntime().freeMemory();
	}
}
