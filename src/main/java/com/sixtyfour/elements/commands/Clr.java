package com.sixtyfour.elements.commands;

import com.sixtyfour.system.Machine;

import java.util.List;

import com.sixtyfour.cbmnative.Util;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.BasicProgramCounter;

/**
 * The CLR command.
 */
public class Clr extends AbstractCommand {

	/**
	 * Instantiates a new clr.
	 */
	public Clr() {
		super("CLR");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String,
	 * int, int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		if (linePart.trim().length() > 3) {
			syntaxError(this);
		}
		return null;
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
		machine.clearVars();
		machine.getDataStore().restore();
		return null;
	}

	@Override
	public List<CodeContainer> evalToCode(Machine machine) {
		return Util.createSingleCommand("JSR CLR");
	}

}
