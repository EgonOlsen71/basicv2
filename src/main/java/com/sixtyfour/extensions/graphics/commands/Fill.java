package com.sixtyfour.extensions.graphics.commands;

import com.sixtyfour.extensions.graphics.GraphicsDevice;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The FILL command
 * 
 * @author EgonOlsen
 * 
 */
public class Fill extends AbstractGraphicsCommand {

	public Fill() {
		super("FILL");
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		return super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine, 2, 0);
	}

	@Override
	public BasicProgramCounter execute(Machine machine) {
		Atom x = pars.get(0);
		checkType(x);
		Atom y = pars.get(1);
		checkType(y);
		GraphicsDevice window = GraphicsDevice.getDevice(machine);
		if (window != null) {
			window.fill(VarUtils.getInt(x.eval(machine)), VarUtils.getInt(y.eval(machine)));
		}
		return null;
	}

}
