/*
 * 
 */
package com.sixtyfour.elements.commands;

import java.util.List;

import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.plugins.DeviceProvider;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.ProgramCounter;
import com.sixtyfour.util.VarUtils;

/**
 * The Class Open.
 */
public class Open extends AbstractCommand {

	/** The pars. */
	private List<Atom> pars;

	/**
	 * Instantiates a new open.
	 */
	public Open() {
		super("OPEN");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String,
	 * int, int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		term = Parser.getTerm(this, linePart, machine, true);
		pars = Parser.getParameters(term);

		if (pars.isEmpty()) {
			throw new RuntimeException("Syntax error: " + this);
		}

		return null;
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
			case 1:
				device.open(VarUtils.getInt(pars.get(0).eval(machine)));
				break;
			case 2:
				device.open(VarUtils.getInt(pars.get(0).eval(machine)), VarUtils.getInt(pars.get(1).eval(machine)));
				break;
			case 3:
				device.open(VarUtils.getInt(pars.get(0).eval(machine)), VarUtils.getInt(pars.get(1).eval(machine)), VarUtils.getInt(pars.get(2).eval(machine)));
				break;
			case 4:
				device.open(VarUtils.getInt(pars.get(0).eval(machine)), VarUtils.getInt(pars.get(1).eval(machine)), VarUtils.getInt(pars.get(2).eval(machine)), (String) pars
						.get(3).eval(machine));
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
