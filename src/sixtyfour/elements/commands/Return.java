package sixtyfour.elements.commands;

import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;
import sixtyfour.system.StackEntry;

public class Return extends AbstractCommand {

	private ProgramCounter pc = new ProgramCounter(0, 0);

	public Return() {
		super("RETURN");
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		linePart = linePart.substring(6).trim();
		if (linePart.trim().length() > 0) {
			throw new RuntimeException("Syntax error: " + this);
		}
		return null;
	}

	@Override
	public ProgramCounter execute(Machine machine) {
		StackEntry caller = machine.getCaller();
		if (caller == null) {
			throw new RuntimeException("RETURN without GOSUB error!");
		}
		AbstractCommand gosub = (AbstractCommand) caller.getCommand();
		pc.setLineCnt(gosub.lineCnt);
		pc.setLinePos(gosub.linePos);
		return pc;
	}

}
