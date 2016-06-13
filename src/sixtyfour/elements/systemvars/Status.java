package sixtyfour.elements.systemvars;

import sixtyfour.elements.Variable;
import sixtyfour.system.Machine;

public class Status extends Variable {

	public Status() {
		super("ST", 0);
	}
	
	@Override
	public Object getValue() {
		return 128;
	}

	@Override
	public Object eval(Machine memory) {
		return getValue();
	}
}
