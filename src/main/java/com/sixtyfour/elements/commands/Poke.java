package com.sixtyfour.elements.commands;

import java.util.List;

import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The POKE command.
 */
public class Poke extends AbstractCommand {

	/** The pars. */
	private List<Atom> pars;

	private Atom addr = null;
	private Atom val = null;

	/**
	 * Instantiates a new poke.
	 */
	public Poke() {
		super("POKE");
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

		if (pars.size() != 2) {
			syntaxError(this);
		}

		checkTypes(pars, linePart, Type.STRING, Type.STRING);

		addr = pars.get(0);
		val = pars.get(1);

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
	public BasicProgramCounter execute(Machine machine) {
		int memAddr = VarUtils.getInt(addr.eval(machine));
		int vally = VarUtils.getInt(val.eval(machine));
		if (vally < 0 || vally > 255 || memAddr < 0 || memAddr > 65535) {
			throw new RuntimeException("Illegal quantity error: " + this + "/" + vally + "/" + memAddr);
		}

		machine.getRam()[memAddr] = vally;
		machine.getMemoryListener().poke(memAddr, vally);
		return null;

	}
}
