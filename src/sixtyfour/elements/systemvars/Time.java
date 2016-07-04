/*
 * 
 */
package sixtyfour.elements.systemvars;

import sixtyfour.elements.Variable;
import sixtyfour.system.Machine;

/**
 * The Class Time.
 */
public class Time extends Variable {
	
	/** The start. */
	private long start = System.currentTimeMillis();

	/**
	 * Instantiates a new time.
	 */
	public Time() {
		super("TI", 0);
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.Variable#getValue()
	 */
	@Override
	public Object getValue() {
		return (int) ((float) (System.currentTimeMillis() - start) / (1000f / 60f));
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.Variable#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine memory) {
		return getValue();
	}
}
