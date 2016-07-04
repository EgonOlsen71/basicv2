/*
 * 
 */
package sixtyfour.elements.functions;

import sixtyfour.elements.Type;
import sixtyfour.system.Machine;

/**
 * The Class Tab.
 */
public class Tab extends Spc {

	/**
	 * Instantiates a new tab.
	 */
	public Tab() {
		super("TAB");
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.functions.Spc#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine memory) {
		ensureContext(memory);
		if (term.getType().equals(Type.STRING)) {
			throw new RuntimeException("Type mismatch error: " + this);
		}
		int num = ((Number) term.eval(memory)).intValue();
		if (num < 0 || num > 255) {
			throw new RuntimeException("Illegal quantity error: " + this);
		}
		num -= memory.getOutputChannel().getCursor();
		num = Math.max(0, num);
		return SPACES.substring(0, num);
	}

}
