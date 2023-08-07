/*
 * 
 */
package com.sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.cbmnative.Util;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;

/**
 * The GOTO command.
 */
public class Goto extends AbstractCommand implements Jump {

	/** The pc. */
	private BasicProgramCounter pc = new BasicProgramCounter(0, 0); // Recycle
																	// instance

	private int targetLineNumber = 0;

	/**
	 * Instantiates a new goto.
	 */
	public Goto() {
		super("GOTO");
	}

	public Goto(int targetLineNumber) {
		super("GOTO");
		this.targetLineNumber = targetLineNumber;
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String, int,
	 * int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos,
			boolean lastPos, Machine machine) {
		super.parse(config, linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		linePart = linePart.substring(4).trim();
		if (linePart.isEmpty()) {
			linePart = "0";
		}
		try {
			this.targetLineNumber = Integer.parseInt(linePart);
		} catch (Exception e) {
			throw new RuntimeException("Undef'd statement error: " + this);
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
		pc.setLineNumber(targetLineNumber);
		return pc;
	}

	public int getTargetLineNumber() {
		return targetLineNumber;
	}

	public void setTargetLineNumber(int targetLineNumber) {
		this.targetLineNumber = targetLineNumber;
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		return Util.createSingleCommand("JMP " + targetLineNumber);
	}

	@Override
	public List<Integer> getTargetLineNumbers() {
		List<Integer> ret = new ArrayList<>();
		ret.add(targetLineNumber);
		return ret;
	}
}
