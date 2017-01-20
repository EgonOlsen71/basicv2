package com.sixtyfour.extensions.graphics.commands;

import com.sixtyfour.elements.Type;
import com.sixtyfour.extensions.graphics.GraphicsDevice;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The BUFFERMODE command
 * 
 * @author EgonOlsen
 * 
 */
public class Limit extends AbstractGraphicsCommand {

	public Limit() {
		super("LIMIT");
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		String ret = super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine, 1, 0);
		checkTypes(pars, linePart, Type.STRING);
		return ret;
	}

	@Override
	public BasicProgramCounter execute(Machine machine) {
		Atom m = pars.get(0);
		GraphicsDevice window = GraphicsDevice.getDevice(machine);
		if (window != null) {
			window.limit(VarUtils.getInt(m.eval(machine)));
		}
		return null;
	}

}
