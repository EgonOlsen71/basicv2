package sixtyfour.elements.commands;

import sixtyfour.parser.Parser;
import sixtyfour.parser.logic.LogicParser;
import sixtyfour.parser.logic.LogicTerm;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;

/**
 * The Class If.
 */
public class If extends AbstractCommand {

	/** The logic term. */
	private LogicTerm logicTerm = null;
	
	/** The pc. */
	private ProgramCounter pc = new ProgramCounter(0, 0);

	/**
	 * Instantiates a new if.
	 */
	public If() {
		super("IF");
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String, int, int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		linePart = Parser.removeWhiteSpace(linePart);

		String uPart = Parser.replaceStrings(linePart, '.');
		int tp = uPart.indexOf("THEN");
		int gp = uPart.indexOf("GOTO");
		if (tp == -1 && gp == -1) {
			throw new RuntimeException("Conditional block missing: " + this);
		}
		int termEnd = 99999999;
		boolean isGoto = false;
		if (tp != -1) {
			termEnd = tp;
		}
		if (gp != -1 && gp < termEnd) {
			termEnd = gp;
			isGoto = true;
		}
		String firstTerm = linePart.substring(2, termEnd);

		logicTerm = LogicParser.getTerm(firstTerm, machine);
		if (isGoto) {
			return linePart.substring(termEnd);
		}
		String restTerm = linePart.substring(termEnd + 4);
		if (Parser.isInteger(restTerm)) {
			return "GOTO" + restTerm;
		}
		return restTerm;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.Machine)
	 */
	@Override
	public ProgramCounter execute(Machine machine) {
		pc.setSkip(false);
		boolean ok = logicTerm.evalToBoolean(machine);
		if (ok) {
			return null;
		}
		pc.setSkip(true);
		return pc;
	}

}
