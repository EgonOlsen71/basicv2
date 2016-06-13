package sixtyfour.elements.systemvars;

import sixtyfour.elements.Variable;
import sixtyfour.system.Machine;

public class Time extends Variable {
	private long start = System.currentTimeMillis();

	public Time() {
		super("TI", 0);
	}

	@Override
	public Object getValue() {
		return (int) ((float) (System.currentTimeMillis() - start) / (1000f / 60f));
	}

	@Override
	public Object eval(Machine memory) {
		return getValue();
	}
}
