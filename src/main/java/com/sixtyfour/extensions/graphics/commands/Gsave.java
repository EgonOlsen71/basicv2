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
		String ret= super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine, 1, 0);
		System.out.println(pars.get(0).getType()+"/"+pars.get(0));
		if (!pars.get(0).getType().equals(Type.STRING)) {
      typeMismatch(linePart);
    }
		return ret;
	}

	@Override
	public BasicProgramCounter execute(Machine machine) {
		Atom name = pars.get(0);
		GraphicsDevice window = GraphicsDevice.getDevice(machine);
		if (window != null) {
			window.save(machine, name.eval(machine).toString());
		}
		return null;
	}
}
