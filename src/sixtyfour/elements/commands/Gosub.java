package sixtyfour.elements.commands;

import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;

public class Gosub extends AbstractCommand {

	private ProgramCounter pc = new ProgramCounter(0, 0); // Recycle instance
	private int lineNumber = 0;

	public Gosub() {
		super("GOSUB");
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, machine);
		linePart = linePart.substring(5).trim();
		try {
			this.lineNumber = Integer.parseInt(linePart);
		} catch (Exception e) {
			throw new RuntimeException("Undef'd statement error: " + this);
		}
		return null;
	}

	@Override
	public ProgramCounter execute(Machine machine) {
		pc.setLineNumber(lineNumber);
		machine.push(this);
		return pc;
	}

}
