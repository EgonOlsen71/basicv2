package sixtyfour.elements.commands;

import java.util.Locale;

import sixtyfour.parser.Parser;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;

public class Next extends AbstractCommand {
	private String varName = null;
	private ProgramCounter pc = new ProgramCounter(0, 0); // Recycle instance

	public Next() {
		super("NEXT");
	}

	public String getVarName() {
		return varName;
	}

	public void setVarName(String varName) {
		this.varName = varName;
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine memory) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, memory);
		linePart = linePart.substring(4).toUpperCase(Locale.ENGLISH).trim();

		String ret = null;
		String[] vars = linePart.split(",");

		// Handle the i,j,k...case by returning an artifical, new command and
		// includes only j,k...
		if (vars.length > 1) {
			linePart = vars[0];
			ret = "NEXT";
			for (int i = 1; i < vars.length; i++) {
				if (i > 1) {
					ret += ",";
				}
				ret += vars[i];
			}
		}
		varName = Parser.getVariableName(linePart);
		if (varName != null && varName.length() == 0) {
			varName = null;
		}
		return ret;
	}

	@Override
	public ProgramCounter execute(Machine machine) {
		For myFor = machine.peekFor();
		if (myFor == null) {
			throw new RuntimeException("NEXT without FOR error: " + this);
		}
		boolean iterate = myFor.next(this, machine);
		if (iterate) {
			pc.setLineCnt(myFor.lineCnt);
			pc.setLinePos(myFor.linePos);
			return pc;
		}
		return null;
	}

}
