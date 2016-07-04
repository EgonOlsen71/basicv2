/*
 * 
 */
package sixtyfour.elements.commands;

import sixtyfour.parser.Parser;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;
import sixtyfour.util.VarUtils;

/**
 * The Class Next.
 */
public class Next extends AbstractCommand {
	
	/** The var name. */
	private String varName = null;
	
	/** The pc. */
	private ProgramCounter pc = new ProgramCounter(0, 0); // Recycle instance

	/**
	 * Instantiates a new next.
	 */
	public Next() {
		super("NEXT");
	}

	/**
	 * Gets the var name.
	 * 
	 * @return the var name
	 */
	public String getVarName() {
		return varName;
	}

	/**
	 * Sets the var name.
	 * 
	 * @param varName
	 *            the new var name
	 */
	public void setVarName(String varName) {
		this.varName = varName;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String, int, int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		linePart = VarUtils.toUpper(linePart.substring(4)).trim();

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

	/* (non-Javadoc)
	 * @see sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.Machine)
	 */
	@Override
	public ProgramCounter execute(Machine machine) {
		For myFor = machine.peekFor(this.varName);
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
