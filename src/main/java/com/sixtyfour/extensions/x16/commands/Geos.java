package com.sixtyfour.extensions.x16.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.Logger;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.commands.AbstractCommand;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;

/**
 * @author Foerster-H
 *
 */
public class Geos extends AbstractCommand {

	public Geos() {
		super("GEOS");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.commands.AbstractCommand#parse(com.sixtyfour.
	 * config.CompilerConfig, java.lang.String, int, int, int, boolean,
	 * com.sixtyfour.system.Machine)
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
	 * @see com.sixtyfour.elements.commands.AbstractCommand#execute(com.sixtyfour.
	 * config.CompilerConfig, com.sixtyfour.system.Machine)
	 */
	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
		Logger.log("Call to GEOS ignored by local runtime!");
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.sixtyfour.elements.commands.AbstractCommand#evalToCode(com.sixtyfour.
	 * config.CompilerConfig, com.sixtyfour.system.Machine)
	 */
	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		List<String> expr = new ArrayList<String>();

		expr.add("JMP GEOS");

		CodeContainer cc = new CodeContainer(null, expr, null);
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();
		ccs.add(cc);
		return ccs;
	}

}
