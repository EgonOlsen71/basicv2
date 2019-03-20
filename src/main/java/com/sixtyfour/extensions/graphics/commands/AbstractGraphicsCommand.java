package com.sixtyfour.extensions.graphics.commands;

import java.util.List;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.commands.AbstractCommand;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.system.Machine;

/**
 * @author EgonOlsen
 * 
 */
public abstract class AbstractGraphicsCommand extends AbstractCommand {

	protected List<Atom> pars;

	public AbstractGraphicsCommand(String name) {
		super(name);
	}

	public String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos,
			boolean lastPos, Machine machine, int parCount, int addPars) {
		super.parse(config, linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		term = Parser.getTerm(config, this, linePart, machine, true);
		pars = Parser.getParameters(term);

		if (pars.size() < parCount || pars.size() > parCount + addPars) {
			syntaxError(linePart);
		}

		return null;
	}

}
