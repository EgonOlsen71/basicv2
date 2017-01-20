package com.sixtyfour.extensions.graphics.commands;

import com.sixtyfour.elements.Type;
import com.sixtyfour.extensions.graphics.GraphicsDevice;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The ROTATESHAPE command. This is similar to DRAWSHAPE but supports rotation.
 * On the other hand, it's (unlike DRAWSHAPE) limited to uniform scaling.
 * 
 * @author Foerster-H
 * 
 */
public class RotateShape extends AbstractGraphicsCommand {

	public RotateShape() {
		super("ROTATESHAPE");
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		String ret = super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine, 5, 0);
		checkTypes(pars, linePart, Type.STRING, Type.STRING, Type.STRING, Type.STRING, Type.STRING);
		return ret;
	}

	@Override
	public BasicProgramCounter execute(Machine machine) {
		Atom id = pars.get(0);
		Atom x = pars.get(1);
		Atom y = pars.get(2);
		Atom d = pars.get(3);
		float zoom = VarUtils.getFloat(d.eval(machine));
		d = pars.get(4);
		float rot = VarUtils.getFloat(d.eval(machine));
		GraphicsDevice window = GraphicsDevice.getDevice(machine);
		if (window != null) {
			window.drawRotatedShape(VarUtils.getInt(id.eval(machine)), VarUtils.getInt(x.eval(machine)), VarUtils.getInt(y.eval(machine)), zoom, rot);
		}
		return null;
	}

}
