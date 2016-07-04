/*
 * 
 */
package sixtyfour.elements.systemvars;

import java.text.SimpleDateFormat;

import sixtyfour.elements.Variable;
import sixtyfour.system.Machine;

/**
 * The Class TimeDate.
 */
public class TimeDate extends Variable {

	/** The sdf. */
	private SimpleDateFormat sdf = new SimpleDateFormat("HHmmss");

	/**
	 * Instantiates a new time date.
	 */
	public TimeDate() {
		super("TI$", "");
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.Variable#getValue()
	 */
	@Override
	public Object getValue() {
		return sdf.format(new java.util.Date());
	}
	
	/* (non-Javadoc)
	 * @see sixtyfour.elements.Variable#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		return getValue();
	}
}
