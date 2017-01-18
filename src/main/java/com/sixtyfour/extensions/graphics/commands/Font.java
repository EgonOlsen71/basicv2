package com.sixtyfour.extensions.graphics.commands;

import com.sixtyfour.elements.Type;
import com.sixtyfour.extensions.graphics.GraphicsDevice;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.system.BasicProgramCounter;
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
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		return super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine, 2, 1);
	}

	@Override
	public BasicProgramCounter execute(Machine machine) {
		Atom font = pars.get(0);
		if (!font.getType().equals(Type.STRING)) {
			throw new RuntimeException("Type mismatch error: " + this);
		}
		Atom size = pars.get(1);
		checkType(size);
		int style = 0;
		if (pars.size() > 2) {
			Atom st = pars.get(2);
			checkType(st);
			style = VarUtils.getInt(st.eval(machine));
		}

		GraphicsDevice window = GraphicsDevice.getDevice(machine);
		if (window != null) {
			window.setFont(font.eval(machine).toString(), style, VarUtils.getInt(size.eval(machine)));
		}
		return null;
	}

}
