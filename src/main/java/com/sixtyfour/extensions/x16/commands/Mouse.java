package com.sixtyfour.extensions.x16.commands;

import java.util.List;

import com.sixtyfour.Logger;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.commands.AbstractCommand;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;

/**
 * The CLOSE command.
 */
public class Mouse extends AbstractCommand {

	/** The pars. */
	private List<Atom> pars;

	/**
	 * Instantiates a new close.
	 */
	public Mouse() {
		super("MOUSE");
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
		term = Parser.getTerm(config, this, linePart, machine, true);
		pars = Parser.getParameters(term);

		if (pars.size() != 1) {
			syntaxError(this);
		}

		checkTypes(pars, linePart, Type.STRING);
		return null;
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		return this.createSingleParameterCall(config, machine, pars, "MOUSEMODE");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
		Logger.log("Call to MOUSE ignored by local runtime!");
		return null;
	}

}
