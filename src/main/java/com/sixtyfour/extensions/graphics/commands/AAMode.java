package com.sixtyfour.extensions.graphics.commands;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.extensions.graphics.GraphicsDevice;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The AAMODE command
 * 
 * @author EgonOlsen
 * 
 */
public class AAMode extends AbstractGraphicsCommand {

	public AAMode() {
		super("AAMODE");
	}

	@Override
	public String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		String ret = super.parse(config, linePart, lineCnt, lineNumber, linePos, lastPos, machine, 1, 0);
		checkTypes(pars, linePart, Type.STRING);
		return ret;
	}

	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
		Atom m = pars.get(0);
		GraphicsDevice window = GraphicsDevice.getDevice(machine);
		if (window != null) {
			window.setAAMode(VarUtils.getInt(m.eval(machine)) != 0);
		}
		return null;
	}

}
