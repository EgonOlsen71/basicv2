/*
 * 
 */
package com.sixtyfour.elements.commands;

import java.util.List;

import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.VariableAndIndex;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.util.VarUtils;

/**
 * The LET command.
 */
public class Let extends AbstractCommand {

	/** The var. */
	private Variable var;

	/** The index term. */
	private Term indexTerm;

	/**
	 * Instantiates a new let.
	 */
	public Let() {
		super("LET");
	}

	/**
	 * Gets the var.
	 * 
	 * @return the var
	 */
	public Variable getVar() {
		return var;
	}

	/**
	 * Sets the var.
	 * 
	 * @param var
	 *            the new var
	 */
	public void setVar(Variable var) {
		this.var = var;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#getType()
	 */
	@Override
	public Type getType() {
		return var.getType();
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
		if (VarUtils.toUpper(linePart).startsWith("LET")) {
			linePart = linePart.substring(3).trim();
		}
		var = Parser.getVariable(linePart, machine);
		VariableAndIndex vai = Parser.getIndexTerm(var, linePart, machine, true);
		indexTerm = vai.getIndexTerm();
		var = vai.getVariable();
		term = Parser.getTerm(linePart, machine, true, true);
		if (!var.getType().equals(term.getType()) && (var.getType().equals(Type.STRING) || term.getType().equals(Type.STRING))) {
		  typeMismatch(linePart);
		}
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
		var = machine.add(var);
		if (indexTerm == null) {
			// no array
			var.setValue(term.eval(machine));
		} else {
			// array
			List<Atom> pars = Parser.getParameters(indexTerm);
			int[] pis = new int[pars.size()];
			int cnt = 0;
			for (Atom par : pars) {
				pis[cnt++] = VarUtils.getInt(par.eval(machine));
			}
			var.setValue(term.eval(machine), pis);
		}
		return null;
	}
}
