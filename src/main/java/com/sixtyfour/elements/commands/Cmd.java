package com.sixtyfour.elements.commands;

import java.util.List;

import com.sixtyfour.cbmnative.Util;
import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.util.VarUtils;

/**
 * The CMD command.
 */
public class Cmd extends AbstractCommand {

	/** The file number. */
	private Atom fileNumber = null;

	/**
	 * Instantiates a new cmd.
	 */
	public Cmd() {
		super("CMD");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String,
	 * int, int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		linePart = linePart.substring(this.name.length());
		int pos = linePart.indexOf(',');
		if (pos == -1) {
			pos = linePart.length();
		}
		term = Parser.getTerm(linePart.substring(0, pos), machine, false, true);
		linePart = pos != linePart.length() ? linePart.substring(pos + 1) : "";
		List<Atom> pars = Parser.getParameters(term);
		if (pars.size() != 1) {
			syntaxError(this);
		}
		fileNumber = pars.get(0);
		checkTypes(pars, linePart, Type.STRING);
		return "PRINT" + linePart;
	}

	@Override
	public List<CodeContainer> evalToCode(Machine machine) {
		int fn = VarUtils.getInt(fileNumber.eval(machine));
		return Util.createSingleCommand("MOV X," + fn, "JSR CMD");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public BasicProgramCounter execute(Machine machine) {
		int fn = VarUtils.getInt(fileNumber.eval(machine));
		if (!machine.getDeviceProvider().isOpen(fn)) {
			throw new RuntimeException("File not open error: " + this);
		}
		machine.getOutputChannel().setPrintConsumer(machine.getDeviceProvider(), fn);
		return null;
	}
}
