/*
 * 
 */
package com.sixtyfour.elements.commands;

import com.sixtyfour.system.Machine;
import com.sixtyfour.system.ProgramCounter;

/**
 * The Class Goto.
 */
public class Goto extends AbstractCommand {

	/** The pc. */
	private ProgramCounter pc = new ProgramCounter(0, 0); // Recycle instance
	
	/** The line number. */
	private int lineNumber = 0;

	/**
	 * Instantiates a new goto.
	 */
	public Goto() {
		super("GOTO");
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String, int, int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		linePart = linePart.substring(4).trim();
		try {
			this.lineNumber = Integer.parseInt(linePart);
		} catch (Exception e) {
			throw new RuntimeException("Undef'd statement error: " + this);
		}
		return null;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.Machine)
	 */
	@Override
	public ProgramCounter execute(Machine machine) {
		pc.setLineNumber(lineNumber);
		return pc;
	}

}
