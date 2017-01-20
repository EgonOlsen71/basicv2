package com.sixtyfour.elements.commands;

import com.sixtyfour.system.Machine;
import com.sixtyfour.system.BasicProgramCounter;

/**
 * The Class Restore.
 */
public class Restore extends AbstractCommand {

	/**
	 * The RESTORE command.
	 */
	public Restore() {
		super("RESTORE");
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
		if (linePart.trim().length() > 7) {
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
		machine.getDataStore().restore();
		return null;
	}
}
