/*
 * 
 */
package sixtyfour.elements.commands;

import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;

/**
 * The Class Stop.
 */
public class Stop extends AbstractCommand {

	/**
	 * Instantiates a new stop.
	 */
	public Stop() {
		super("STOP");
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String, int, int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		if (linePart.length() > 4) {
			throw new RuntimeException("Syntax error: " + this);
		}
		return null;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.Machine)
	 */
	@Override
	public ProgramCounter execute(Machine machine) {
		ProgramCounter pc = new ProgramCounter(this.lineCnt, this.linePos);
		pc.setStop(true);
		return pc;
	}

}
