package com.sixtyfour.elements.commands;

import com.sixtyfour.system.Machine;

import java.util.List;

import com.sixtyfour.cbmnative.Util;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.StackEntry;

/**
 * The RETURN command.
 */
public class Return extends AbstractCommand {

	/** The pc. */
	private BasicProgramCounter pc = new BasicProgramCounter(0, 0);

	/**
	 * Instantiates a new return.
	 */
	public Return() {
		super("RETURN");
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
		linePart = linePart.substring(6).trim();
		if (linePart.trim().length() > 0) {
			syntaxError(this);
		}
		return null;
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
		StackEntry caller = machine.getCaller();
		if (caller == null) {
			throw new RuntimeException("RETURN without GOSUB error!");
		}
		AbstractCommand gosub = (AbstractCommand) caller.getCommand();
		pc.setLineCnt(gosub.lineCnt);
		pc.setLinePos(gosub.linePos);
		return pc;
	}

	@Override
	public List<CodeContainer> evalToCode(Machine machine) {
		return Util.createSingleCommand("RTS");
	}

}
