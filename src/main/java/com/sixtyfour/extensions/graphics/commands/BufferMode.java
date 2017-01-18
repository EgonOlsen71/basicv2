package com.sixtyfour.extensions.graphics.commands;

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
public class BufferMode extends AbstractGraphicsCommand {

	public BufferMode() {
		super("BUFFERMODE");
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		return super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine, 1, 0);
	}

	@Override
	public BasicProgramCounter execute(Machine machine) {
		Atom m = pars.get(0);
		checkType(m);
		GraphicsDevice window = GraphicsDevice.getDevice(machine);
		if (window != null) {
			window.setBufferMode(VarUtils.getInt(m.eval(machine)) != 0);
		}
		return null;
	}

}
