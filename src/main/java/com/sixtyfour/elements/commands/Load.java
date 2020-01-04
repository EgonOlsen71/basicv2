/*
 * 
 */
package com.sixtyfour.elements.commands;

import java.util.List;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.parser.cbmnative.CodeContainer;
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

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		return super.evalToCode(config, machine, "LOAD");
	}
	
	@Override
	protected boolean isLoad() {
		return true;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
		DeviceProvider device = machine.getDeviceProvider();

		try {
			switch (pars.size()) {
			case 0:
				device.load(config, "", 1, 0);
				break;
			case 1:
				device.load(config, (String) pars.get(0).eval(machine), 1, 0);
				break;
			case 2:
				device.load(config, (String) pars.get(0).eval(machine), VarUtils.getInt(pars.get(1).eval(machine)), 0);
				break;
			case 3:
				device.load(config, (String) pars.get(0).eval(machine), VarUtils.getInt(pars.get(1).eval(machine)),
						VarUtils.getInt(pars.get(2).eval(machine)));
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
