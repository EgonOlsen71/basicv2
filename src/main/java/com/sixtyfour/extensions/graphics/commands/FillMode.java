package com.sixtyfour.extensions.graphics.commands;

import com.sixtyfour.elements.Type;
import com.sixtyfour.extensions.graphics.GraphicsDevice;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The FILLMODE command
 * 
 * @author EgonOlsen
 * 
 */
public class FillMode extends AbstractGraphicsCommand {

	public FillMode() {
		super("FILLMODE");
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		String ret= super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine, 1, 0);
		checkTypes(pars, linePart, Type.STRING);
    return ret;
	}

	@Override
	public BasicProgramCounter execute(Machine machine) {
		Atom m = pars.get(0);
		GraphicsDevice window = GraphicsDevice.getDevice(machine);
		if (window != null) {
			window.setFillMode(VarUtils.getInt(m.eval(machine)) != 0);
		}
		return null;
	}

}
