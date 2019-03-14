package com.sixtyfour.elements.commands;

import com.sixtyfour.system.Machine;

import java.util.List;

import com.sixtyfour.cbmnative.Util;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.BasicProgramCounter;

/**
 * The CONT command.
 */
public class Cont extends AbstractCommand {

	/**
	 * Instantiates a new cont.
	 */
	public Cont() {
		super("CONT");
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
		if (linePart.trim().length() > 4) {
			syntaxError(this);
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
		throw new RuntimeException("Can't continue error: " + this);
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		return Util.createSingleCommand("NOP");
	}
}
