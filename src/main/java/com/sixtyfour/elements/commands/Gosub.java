/*
 * 
 */
package com.sixtyfour.elements.commands;

import java.util.List;

import com.sixtyfour.cbmnative.Util;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;

/**
 * The GOSUB command.
 */
public class Gosub extends AbstractCommand {

	/** The pc. */
	private BasicProgramCounter pc = new BasicProgramCounter(0, 0); // Recycle
																	// instance

	/** The line number. */
	private int lineNumber = 0;

	/**
	 * Instantiates a new gosub.
	 */
	public Gosub() {
		super("GOSUB");
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
		linePart = linePart.substring(5).trim();
		try {
			this.lineNumber = Integer.parseInt(linePart);
		} catch (Exception e) {
			throw new RuntimeException("Undef'd statement error: " + this);
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
		pc.setLineNumber(lineNumber);
		machine.push(this);
		return pc;
	}

	@Override
	public List<CodeContainer> evalToCode(Machine machine) {
		return Util.createSingleCommand("JSR " + lineNumber);
	}
}
