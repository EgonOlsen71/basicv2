package com.sixtyfour.elements.commands;

import com.sixtyfour.system.Machine;
import com.sixtyfour.system.BasicProgramCounter;

/**
 * The RUN command.
 */
public class Run extends AbstractCommand {

	/** The pc. */
	private BasicProgramCounter pc = new BasicProgramCounter(0, 0); // Recycle instance

	/** The line number. */
	private int lineNumber = -1;

	/**
	 * Instantiates a new run.
	 */
	public Run() {
		super("RUN");
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
		linePart = linePart.substring(3).trim();
		if (linePart.trim().length() > 0) {
			try {
				this.lineNumber = Integer.parseInt(linePart);
			} catch (Exception e) {
				throw new RuntimeException("Undef'd statement error: " + this);
			}
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
		machine.resetMemory();
		pc.setLinePos(-1);
		if (lineNumber != -1) {
			pc.setLineNumber(lineNumber);
		} else {
			pc.setLineNumber(-1);
			pc.setLineCnt(0);
		}
		return pc;
	}
}
