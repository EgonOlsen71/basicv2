package com.sixtyfour.elements.commands;

import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.logic.LogicParser;
import com.sixtyfour.parser.logic.LogicTerm;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.BasicProgramCounter;

/**
 * The IF command.
 */
public class If extends AbstractCommand {

	/** The logic term. */
	private LogicTerm logicTerm = null;

	/** The pc. */
	private BasicProgramCounter pc = new BasicProgramCounter(0, 0);

	/**
	 * Instantiates a new if.
	 */
	public If() {
		super("IF");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String,
	 * int, int, int, boolean, sixtyfour.system.Machine)
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public BasicProgramCounter execute(Machine machine) {
		pc.setSkip(false);
		boolean ok = logicTerm.evalToBoolean(machine);
		if (ok) {
			return null;
		}
		pc.setSkip(true);
		return pc;
	}

}
