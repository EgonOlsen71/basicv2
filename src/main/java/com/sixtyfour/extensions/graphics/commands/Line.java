package com.sixtyfour.extensions.graphics.commands;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.extensions.graphics.GraphicsDevice;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The LINE command
 * 
 * @author EgonOlsen
 * 
 */
public class Line extends AbstractGraphicsCommand {

	public Line() {
		super("LINE");
	}

	@Override
	public String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos,
			boolean lastPos, Machine machine) {
		String ret = super.parse(config, linePart, lineCnt, lineNumber, linePos, lastPos, machine, 4, 0);
		checkTypes(pars, linePart, Type.STRING, Type.STRING, Type.STRING, Type.STRING);
		return ret;
	}

	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
		Atom xs = pars.get(0);
		Atom ys = pars.get(1);
		Atom xe = pars.get(2);
		Atom ye = pars.get(3);
		GraphicsDevice window = GraphicsDevice.getDevice(machine);
		if (window != null) {
			window.line(VarUtils.getInt(xs.eval(machine)), VarUtils.getInt(ys.eval(machine)),
					VarUtils.getInt(xe.eval(machine)), VarUtils.getInt(ye.eval(machine)));
		}
		return null;
	}
}
