package com.sixtyfour.elements.commands;

import java.util.List;

import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.system.Machine;

/**
 * A virtual command for file operations.
 */
public abstract class FileOperation extends AbstractCommand {

	/** The pars. */
	protected List<Atom> pars;

	/**
	 * Instantiates a new file operation.
	 * 
	 * @param name
	 *            the name
	 */
	public FileOperation(String name) {
		super(name);
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
		linePart = linePart.substring(this.name.length());
		term = Parser.getTerm(linePart, machine, false, true);
		pars = Parser.getParameters(term);
		if (pars.size() > 0 && !pars.get(0).getType().equals(Type.STRING)) {
			syntaxError(this);
		}
		if (pars.size() > 1 && pars.get(1).getType().equals(Type.STRING)) {
			syntaxError(this);
		}
		if (pars.size() > 2 && pars.get(2).getType().equals(Type.STRING)) {
			syntaxError(this);
		}
		return null;
	}

}
