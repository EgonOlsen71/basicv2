package com.sixtyfour.elements.commands;

import java.util.List;

import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.util.VarUtils;

/**
 * The GET command.
 */
public class Get extends MultiVariableCommand {

	/**
	 * Instantiates a new gets the.
	 */
	public Get() {
		super("GET");
	}

	/**
	 * Instantiates a new gets the.
	 * 
	 * @param name
	 *            the name
	 */
	protected Get(String name) {
		super(name);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#getType()
	 */
	@Override
	public Type getType() {
		return Type.NONE;
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
		linePart = linePart.substring(3).trim();
		if (linePart.length() == 0) {
			syntaxError(this);
		}
		this.fillVariables(linePart, machine);
		return null;
	}

	@Override
	public List<CodeContainer> evalToCode(Machine machine) {
		return this.evalToCode(machine, "GETSTR", "GETNUMBER");
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
		for (int i = 0; i < vars.size(); i++) {
			Term indexTerm = indexTerms.get(i);
			Variable var = this.getVariable(machine, i);
			Character input = machine.getInputProvider().readKey();
			if (indexTerm != null) {
				List<Atom> pars = Parser.getParameters(indexTerm);
				int[] pis = new int[pars.size()];
				int cnt = 0;
				for (Atom par : pars) {
					pis[cnt++] = VarUtils.getInt(par.eval(machine));
				}
				if (var.getType().equals(Type.STRING)) {
					if (input == null) {
						var.setValue("", pis);
					} else {
						var.setValue(input.toString(), pis);
					}
				} else {
					if (input == null) {
						var.setValue(0, pis);
					} else {
						input = ensureNumberKey(machine, input, true);
						var.setValue(Integer.valueOf(input.toString()), pis);
					}
				}
			} else {
				if (var.getType().equals(Type.STRING)) {
					if (input == null) {
						var.setValue("");
					} else {
						var.setValue(input.toString());
					}
				} else {
					if (input == null) {
						var.setValue(0);
					} else {
						input = ensureNumberKey(machine, input, true);
						var.setValue(Integer.valueOf(input.toString()));
					}
				}
			}
		}
		machine.getOutputChannel().setPrintConsumer(null, 0);
		return null;
	}
}
