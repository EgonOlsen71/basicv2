package com.sixtyfour.extensions.graphics.commands;

import com.sixtyfour.elements.Type;
import com.sixtyfour.extensions.graphics.GraphicsDevice;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.CompilerConfig;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The PLOT command
 * 
 * @author EgonOlsen
 * 
 */
public class Font extends AbstractGraphicsCommand {

	public Font() {
		super("FONT");
	}

	@Override
	public String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		String ret = super.parse(config, linePart, lineCnt, lineNumber, linePos, lastPos, machine, 2, 1);
		checkTypes(pars, linePart, null, Type.STRING, Type.STRING);
		if (!pars.get(0).getType().equals(Type.STRING)) {
			typeMismatch(linePart);
		}
		return ret;
	}

	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
		Atom font = pars.get(0);
		Atom size = pars.get(1);
		int style = 0;
		if (pars.size() > 2) {
			Atom st = pars.get(2);
			style = VarUtils.getInt(st.eval(machine));
		}

		GraphicsDevice window = GraphicsDevice.getDevice(machine);
		if (window != null) {
			window.setFont(font.eval(machine).toString(), style, VarUtils.getInt(size.eval(machine)));
		}
		return null;
	}

}
