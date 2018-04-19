package com.sixtyfour.elements.functions;

import com.sixtyfour.elements.Type;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The TAB function.
 */
public class Tab extends Spc {

	/**
	 * Instantiates a new tab.
	 */
	public Tab() {
		super("TAB");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.functions.Spc#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		ensureContext(machine);
		if (term.getType().equals(Type.STRING)) {
			typeMismatch(this);
		}
		int num = VarUtils.getInt(term.eval(machine));
		if (num < 0 || num > 255) {
			throw new RuntimeException("Illegal quantity error: " + this + "/" + num);
		}
		num -= machine.getOutputChannel().getCursor();
		num = Math.max(0, num);
		return SPACES.substring(0, num);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.functions.AbstractFunction#isDeterministic()
	 */
	@Override
	public boolean isDeterministic() {
		return false;
	}

}
