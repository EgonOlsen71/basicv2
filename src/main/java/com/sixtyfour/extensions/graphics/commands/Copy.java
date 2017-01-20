package com.sixtyfour.extensions.graphics.commands;

import com.sixtyfour.elements.Type;
import com.sixtyfour.extensions.graphics.GraphicsDevice;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

public class Copy extends AbstractGraphicsCommand {

	public Copy() {
		super("COPY");
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		String ret= super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine, 6, 0);
    checkTypes(pars, linePart, Type.STRING, Type.STRING, Type.STRING, Type.STRING, Type.STRING, Type.STRING);
    return ret;
	}

	@Override
	public BasicProgramCounter execute(Machine machine) {
		Atom xs = pars.get(0);
		Atom ys = pars.get(1);
		Atom xe = pars.get(2);
		Atom ye = pars.get(3);
		Atom xt = pars.get(4);
		Atom yt = pars.get(5);
		GraphicsDevice window = GraphicsDevice.getDevice(machine);
		if (window != null) {
			window.copy(VarUtils.getInt(xs.eval(machine)), VarUtils.getInt(ys.eval(machine)), VarUtils.getInt(xe.eval(machine)), VarUtils.getInt(ye.eval(machine)),
					VarUtils.getInt(xt.eval(machine)), VarUtils.getInt(yt.eval(machine)));
		}
		return null;
	}

}
