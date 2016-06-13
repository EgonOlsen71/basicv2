package sixtyfour.elements.systemvars;

import java.text.SimpleDateFormat;

import sixtyfour.elements.Variable;
import sixtyfour.system.Machine;

public class TimeDate extends Variable {

	private SimpleDateFormat sdf = new SimpleDateFormat("HHmmss");

	public TimeDate() {
		super("TI$", "");
	}

	@Override
	public Object getValue() {
		return sdf.format(new java.util.Date());
	}
	
	@Override
	public Object eval(Machine memory) {
		return getValue();
	}
}
