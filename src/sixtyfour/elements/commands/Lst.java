package sixtyfour.elements.commands;

import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;

public class Lst extends AbstractCommand {
	public Lst() {
		super("LIST");
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		if (linePart.trim().length() > 4) {
			throw new RuntimeException("Syntax error: " + this);
		}
		return null;
	}

	@Override
	public ProgramCounter execute(Machine machine) {
		ProgramCounter pc = new ProgramCounter(0, 0);
		pc.setList(true);
		return pc;
	}
}
