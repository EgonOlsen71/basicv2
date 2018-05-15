package com.sixtyfour.elements.commands;

import com.sixtyfour.system.Machine;

import java.util.List;

import com.sixtyfour.cbmnative.Util;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.CompilerConfig;

/**
 * The REM command.
 */
public class Rem extends AbstractCommand {

	/** The Constant REM_MARKER. */
	public final static String REM_MARKER = "###";

	/**
	 * Instantiates a new rem.
	 */
	public Rem() {
		super("REM");
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
		return REM_MARKER;
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
		return null;
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		return Util.createSingleCommand("NOP");
	}
}
