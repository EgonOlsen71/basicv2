package sixtyfour.elements.commands;

import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;

public class Restore extends AbstractCommand {

	public Restore() {
		super("RESTORE");
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		if (linePart.trim().length() > 7) {
			throw new RuntimeException("Syntax error: " + this);
		}
		return null;
	}

	@Override
	public ProgramCounter execute(Machine machine) {
		machine.getDataStore().restore();
		return null;
	}
}
