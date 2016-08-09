/*
 * 
 */
package com.sixtyfour.elements.commands;

import com.sixtyfour.plugins.DeviceProvider;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.ProgramCounter;
import com.sixtyfour.util.VarUtils;

/**
 * The Class Save.
 */
public class Save extends FileOperation {

	/**
	 * Instantiates a new save.
	 */
	public Save() {
		super("SAVE");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public ProgramCounter execute(Machine machine) {
		DeviceProvider device = machine.getDeviceProvider();

		try {
			switch (pars.size()) {
			case 0:
				device.save("", 1, 0);
				break;
			case 1:
				device.save((String) pars.get(0).eval(machine), 1, 0);
				break;
			case 2:
				device.save((String) pars.get(0).eval(machine), VarUtils.getInt(pars.get(1).eval(machine)), 0);
				break;
			case 3:
				device.save((String) pars.get(0).eval(machine), VarUtils.getInt(pars.get(1).eval(machine)), VarUtils.getInt(pars.get(2).eval(machine)));
				break;
			default:
				throw new RuntimeException("Syntax error: " + this);
			}
		} catch (ClassCastException e) {
			throw new RuntimeException("Syntax error: " + this);
		}

		return null;
	}

}
