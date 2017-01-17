package com.sixtyfour.extensions.graphics.commands;

import com.sixtyfour.elements.Type;
import com.sixtyfour.extensions.graphics.GraphicsDevice;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;

/**
 * @author EgonOlsen
 * 
 */
public class Gsave extends AbstractGraphicsCommand {

	public Gsave() {
		super("GSAVE");
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		return super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine, 1, 0);
	}

	@Override
	public BasicProgramCounter execute(Machine machine) {
		Atom name = pars.get(0);
		if (!name.getType().equals(Type.STRING)) {
			throw new RuntimeException("Type mismatch error: " + this);
		}
		GraphicsDevice window = GraphicsDevice.getDevice(machine);
		if (window != null) {
			window.save(machine, name.eval(machine).toString());
		}
		return null;
	}
}
