package sixtyfour.elements.commands;

import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;

public class Run extends AbstractCommand {

	private ProgramCounter pc = new ProgramCounter(0, 0); // Recycle instance
	private int lineNumber = -1;

	public Run() {
		super("RUN");
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, machine);
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

	@Override
	public ProgramCounter execute(Machine machine) {
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
