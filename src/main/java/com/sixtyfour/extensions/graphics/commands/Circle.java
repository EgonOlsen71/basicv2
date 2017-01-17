package com.sixtyfour.extensions.graphics.commands;

import com.sixtyfour.extensions.graphics.GraphicsDevice;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The CIRCLE command
 * 
 * @author EgonOlsen
 *
 */
public class Circle extends AbstractGraphicsCommand {

	public Circle() {
		super("CIRCLE");
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		return super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine, 3, 1);
	}

	@Override
	public BasicProgramCounter execute(Machine machine) {
		Atom xs = pars.get(0);
		checkType(xs);
		Atom ys = pars.get(1);
		checkType(ys);
		Atom xr = pars.get(2);
		checkType(xr);
		Atom yr = xr;
		if (pars.size() > 3) {
			yr = pars.get(3);
			checkType(yr);
		}

		GraphicsDevice window = GraphicsDevice.getDevice(machine);
		if (window != null) {
			int xri = VarUtils.getInt(xr.eval(machine));
			window.circle(VarUtils.getInt(xs.eval(machine)), VarUtils.getInt(ys.eval(machine)), xri, xr == yr ? xri : VarUtils.getInt(yr.eval(machine)));
		}
		return null;
	}
}
