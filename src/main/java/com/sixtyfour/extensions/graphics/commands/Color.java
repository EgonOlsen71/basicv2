package com.sixtyfour.extensions.graphics.commands;

import com.sixtyfour.elements.Constant;
import com.sixtyfour.elements.Type;
import com.sixtyfour.extensions.graphics.GraphicsDevice;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The COLOR command
 * 
 * @author EgonOlsen
 * 
 */
public class Color extends AbstractGraphicsCommand {

	public Color() {
		super("COLOR");
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		String ret= super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine, 3, 1);
    checkTypes(pars, linePart, Type.STRING, Type.STRING, Type.STRING, Type.STRING);
    return ret;
	}

	@Override
	public BasicProgramCounter execute(Machine machine) {
		Atom r = pars.get(0);
		Atom g = pars.get(1);
		Atom b = pars.get(2);
		Atom a = null;
		if (pars.size() > 3) {
			a = pars.get(3);
		} else {
			a = new Constant<Integer>(255);
		}

		GraphicsDevice window = GraphicsDevice.getDevice(machine);
		if (window != null) {
			window.color(VarUtils.getInt(r.eval(machine)), VarUtils.getInt(g.eval(machine)), VarUtils.getInt(b.eval(machine)), VarUtils.getInt(a.eval(machine)));
		}
		return null;
	}
}
