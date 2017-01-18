package com.sixtyfour.extensions.graphics.commands;

import java.util.List;

import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.commands.Print;
import com.sixtyfour.extensions.graphics.GraphicsDevice;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.plugins.PrintConsumer;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The GPRINT command, a print command for the graphics screen. In addition to
 * the PRINT command, it takes the output position as the first two parameters.
 * The rest is identical to PRINT.
 * 
 * @author EgonOlsen
 * 
 */
public class Gprint extends Print {

	private List<Atom> pars;

	public Gprint() {
		super("GPRINT");
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		this.lineCnt = lineCnt;
		this.linePos = linePos;
		this.lineNumber = lineNumber;

		String[] partys = linePart.substring(6).split(",");
		if (partys.length < 3) {
			throw new RuntimeException("Syntax error: " + this);
		}

		int dif = linePart.indexOf(',', linePart.indexOf(',') + 1);
		String terms = linePart.substring(0, dif);
		term = Parser.getTerm(this, terms, machine, true);
		pars = Parser.getParameters(term);

		linePart = linePart.substring(dif + 1);
		List<PrintPart> parts = getParts(linePart);
		if (parts.size() == 0) {
			PrintPart newLine = new PrintPart("\"\"", ' ');
			parts.add(newLine);
		}
		for (PrintPart part : parts) {
			part.term = Parser.getTerm(part.part, machine, false, true);
		}
		this.parts = parts;
		return null;
	}

	@Override
	protected BasicProgramCounter execute(Machine machine, PrintConsumer consumer, int printId) {
		GraphicsDevice window = GraphicsDevice.getDevice(machine);
		if (window != null) {
			Atom x = pars.get(0);
			checkType(x);
			Atom y = pars.get(1);
			checkType(y);
			window.setCursor(VarUtils.getInt(x.eval(machine)), VarUtils.getInt(y.eval(machine)));
			return super.execute(machine, window, printId);
		}
		return null;
	}

	private void checkType(Atom x) {
		if (x.getType().equals(Type.STRING)) {
			throw new RuntimeException("Type mismatch error: " + this);
		}
	}
}
