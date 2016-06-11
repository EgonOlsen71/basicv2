package sixtyfour.elements.commands;

import sixtyfour.Machine;
import sixtyfour.elements.ProgramCounter;

public class Goto extends AbstractCommand {

	private ProgramCounter pc = new ProgramCounter(0, 0); // Recycle instance
	private int lineNumber = 0;

	public Goto() {
		super("GOTO");
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, Machine memory) {
		super.parse(linePart, lineCnt, lineNumber, linePos, memory);
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
