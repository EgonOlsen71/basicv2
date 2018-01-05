package com.sixtyfour.elements.commands;

import java.util.List;

import com.sixtyfour.cbmnative.Util;
import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.util.VarUtils;

/**
 * The SYS command.
 */
public class Sys extends AbstractCommand {

	/** The pars. */
	private List<Atom> pars;
	private Atom addr;
	private List<Atom> vals;

	/**
	 * Instantiates a new sys.
	 */
	public Sys() {
		super("SYS");
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
		term = Parser.getTerm(this, linePart, machine, true);
		pars = Parser.getParameters(term);

		if (pars.isEmpty()) {
			syntaxError(linePart);
		}

		checkTypes(pars, linePart, Type.STRING);
		addr = pars.get(0);
		vals = pars.subList(1, pars.size());
		return null;
	}

	@Override
	public List<CodeContainer> evalToCode(Machine machine) {
		int memAddr = VarUtils.getInt(addr.eval(machine));
		if (memAddr < 0 || memAddr > 65535) {
			throw new RuntimeException("Illegal quantity error: " + this);
		}
		return Util.createSingleCommand("JSR $" + Integer.toHexString(memAddr));
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
		int memAddr = VarUtils.getInt(addr.eval(machine));
		if (memAddr < 0 || memAddr > 65535) {
			throw new RuntimeException("Illegal quantity error: " + this);
		}
		Object[] params = null;
		if (!vals.isEmpty()) {
			params = new Object[vals.size()];
			int cnt = 0;
			for (Atom val : vals) {
				params[cnt++] = val.eval(machine);
			}
		}
		machine.getSystemCallListener().sys(memAddr, params);

		return null;

	}

}
