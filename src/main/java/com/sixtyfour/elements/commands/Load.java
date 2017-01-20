/*
 * 
 */
package com.sixtyfour.elements.commands;

import com.sixtyfour.plugins.DeviceProvider;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.util.VarUtils;

/**
 * The LOAD command.
 */
public class Load extends FileOperation {

	/**
	 * Instantiates a new load.
	 */
	public Load() {
		super("LOAD");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public BasicProgramCounter execute(Machine machine) {
		DeviceProvider device = machine.getDeviceProvider();

		try {
			switch (pars.size()) {
			case 0:
				device.load("", 1, 0);
				break;
			case 1:
				device.load((String) pars.get(0).eval(machine), 1, 0);
				break;
			case 2:
				device.load((String) pars.get(0).eval(machine), VarUtils.getInt(pars.get(1).eval(machine)), 0);
				break;
			case 3:
				device.load((String) pars.get(0).eval(machine), VarUtils.getInt(pars.get(1).eval(machine)), VarUtils.getInt(pars.get(2).eval(machine)));
				break;
			default:
			  syntaxError(this);
			}
		} catch (ClassCastException e) {
		  syntaxError(this);
		}

		return null;
	}

}
