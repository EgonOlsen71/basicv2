package com.sixtyfour.elements.commands;

import java.util.List;

import com.sixtyfour.cbmnative.Util;
import com.sixtyfour.config.CompilerConfig;
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
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String, int,
	 * int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos,
			boolean lastPos, Machine machine) {
		super.parse(config, linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		term = Parser.getTerm(config, this, linePart, machine, true);
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
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		if (addr.isConstant()) {
			// Shortcut for SYS XXXX, which should be the majority of calls
			int memAddr = VarUtils.getInt(addr.eval(machine));
			if (memAddr < 0 || memAddr > 65535) {
				throw new RuntimeException("Illegal quantity error: " + this);
			}
			return Util.createSingleCommand("JSR $" + Integer.toHexString(memAddr));
		} else {
			// SYS dynamic...
			return createSingleParameterCall(config, machine, pars, "SYSTEMCALLDYN");
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
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
