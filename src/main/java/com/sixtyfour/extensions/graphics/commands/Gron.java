package com.sixtyfour.extensions.graphics.commands;

import com.sixtyfour.elements.Type;
import com.sixtyfour.extensions.graphics.GraphicsDevice;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.CompilerConfig;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The GRON command, which enables graphics output.
 * 
 * @author EgonOlsen
 * 
 */
public class Gron extends AbstractGraphicsCommand {

	public Gron() {
		super("GRON");
	}

	@Override
	public String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		String ret = super.parse(config, linePart, lineCnt, lineNumber, linePos, lastPos, machine, 2, 0);
		checkTypes(pars, linePart, Type.STRING, Type.STRING);
		return ret;
	}

	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
		Atom x = pars.get(0);
		Atom y = pars.get(1);
		GraphicsDevice.openDevice(machine, VarUtils.getInt(x.eval(machine)), VarUtils.getInt(y.eval(machine)));
		return null;
	}

}
