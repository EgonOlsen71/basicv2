package sixtyfour.elements.commands;

import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;

public class Cont extends AbstractCommand {

	public Cont() {
		super("CONT");
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine memory) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, memory);
		if (linePart.trim().length() > 4) {
			throw new RuntimeException("Syntax error: " + this);
		}
		return null;
	}

	@Override
	public ProgramCounter execute(Machine memory) {
		throw new RuntimeException("Can't continue error: " + this);
	}
}
