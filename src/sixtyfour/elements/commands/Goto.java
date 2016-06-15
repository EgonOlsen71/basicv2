package sixtyfour.elements.commands;

import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;

public class Goto extends AbstractCommand {

	private ProgramCounter pc = new ProgramCounter(0, 0); // Recycle instance
	private int lineNumber = 0;

	public Goto() {
		super("GOTO");
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine memory) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, memory);
		linePart = linePart.substring(4).trim();
		try {
			this.lineNumber = Integer.parseInt(linePart);
		} catch (Exception e) {
			throw new RuntimeException("Undef'd statement error: " + this);
		}
		return null;
	}

	@Override
	public ProgramCounter execute(Machine memory) {
		pc.setLineNumber(lineNumber);
		return pc;
	}

}
