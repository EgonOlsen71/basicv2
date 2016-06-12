package sixtyfour.elements.commands;

import sixtyfour.ProgramCounter;
import sixtyfour.system.Machine;

public class Stop extends AbstractCommand {

	public Stop() {
		super("STOP");
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, Machine memory) {
		super.parse(linePart, lineCnt, lineNumber, linePos, memory);
		if (linePart.trim().length() > 4) {
			throw new RuntimeException("Syntax error: " + this);
		}
		return null;
	}

	@Override
	public ProgramCounter execute(Machine memory) {
		ProgramCounter pc = new ProgramCounter(this.lineCnt, this.linePos);
		pc.setStop(true);
		return pc;
	}

}
