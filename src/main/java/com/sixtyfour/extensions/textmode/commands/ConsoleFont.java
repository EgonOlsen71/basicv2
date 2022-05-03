package com.sixtyfour.extensions.textmode.commands;

import java.util.List;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.extensions.graphics.commands.AbstractGraphicsCommand;
import com.sixtyfour.extensions.textmode.ConsoleDevice;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * Sets a font. ATM, only lower and upper case versions of the default CBM font
 * are supported.
 * 
 * @author EgonOlsen
 * 
 */
public class ConsoleFont extends AbstractGraphicsCommand {

	public ConsoleFont() {
		super("CONSOLEFONT");
	}

	@Override
	public String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos,
			boolean lastPos, Machine machine) {
		String ret = super.parse(config, linePart, lineCnt, lineNumber, linePos, lastPos, machine, 1, 0);
		List<Atom> pars = Parser.getParameters(term);
		checkTypes(pars, linePart, Type.STRING);
		return ret;
	}

	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
		List<Atom> pars = Parser.getParameters(term);
		Atom m = pars.get(0);
		ConsoleDevice window = ConsoleDevice.getDevice(machine);
		int val = VarUtils.getInt(m.eval(machine));
		if (val >= 0) {
			window.setFontMode(val == 0);
		} else {
			window.toggleFontMode();
		}
		return null;
	}

}
