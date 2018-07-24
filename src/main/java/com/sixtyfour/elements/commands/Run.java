package com.sixtyfour.elements.commands;

import com.sixtyfour.system.Machine;

import java.util.List;

import com.sixtyfour.cbmnative.Util;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.BasicProgramCounter;

/**
 * The RUN command.
 */
public class Run extends AbstractCommand {

	/** The pc. */
	private BasicProgramCounter pc = new BasicProgramCounter(0, 0); // Recycle
																	// instance

	/** The line number. */
	private int targetLineNumber = -1;

	/**
	 * Instantiates a new run.
	 */
	public Run() {
		super("RUN");
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		return Util.createSingleCommand("JSR RUN");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String,
	 * int, int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(config, linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		linePart = linePart.substring(3).trim();
		if (linePart.trim().length() > 0) {
			try {
				this.targetLineNumber = Integer.parseInt(linePart);
			} catch (Exception e) {
				throw new RuntimeException("Undef'd statement error: " + this);
			}
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
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
		machine.resetMemory();
		machine.getDataStore().restore();
		pc.setLinePos(-1);
		if (targetLineNumber != -1) {
			pc.setLineNumber(targetLineNumber);
		} else {
			pc.setLineNumber(-1);
			pc.setLineCnt(0);
		}
		return pc;
	}
}
