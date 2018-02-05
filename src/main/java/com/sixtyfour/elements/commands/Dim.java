package com.sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.VariableAndTerms;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The DIM command.
 */
public class Dim extends AbstractCommand {

	/** The vars. */
	private List<Variable> vars;

	/** The terms. */
	private Map<String, List<Atom>> terms;

	/**
	 * Instantiates a new dim.
	 */
	public Dim() {
		super("DIM");
	}

	/**
	 * Gets the vars.
	 * 
	 * @return the vars
	 */
	public List<Variable> getVars() {
		return vars;
	}

	/**
	 * Sets the var.
	 * 
	 * @param vars
	 *            the new var
	 */
	public void setVar(List<Variable> vars) {
		this.vars = vars;
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
		List<VariableAndTerms> vars = Parser.getArrayVariables(linePart, machine);
		terms = new HashMap<String, List<Atom>>();
		this.vars = new ArrayList<Variable>();
		if (vars != null) {
			for (VariableAndTerms var : vars) {
				terms.put(var.getVarName(), var.getTerms());
				// Some placeholder vars...
				this.vars.add(new Variable(var.getVarName(), null));
			}
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
		for (int i = 0; i < vars.size(); i++) {
			Variable var = vars.get(i);
			if (!var.isArray()) {
				List<Atom> pars = terms.get(var.getName());
				int[] pis = new int[pars.size()];
				int cnt = 0;
				for (Atom par : pars) {
					pis[cnt++] = VarUtils.getInt(par.eval(machine));
				}
				Variable vary = new Variable(var.getName(), null, pis);
				if (machine.getVariable(vary.getName()) != null) {
					Variable av = machine.getVariable(vary.getName());
					if (!av.isArray()) {
						redimed(var);
					} else {
						int[] edims = av.getDimensions();
						if (edims.length != pis.length) {
							redimed(var);
						}
						for (int ii = 0; ii < edims.length; ii++) {
							if (edims[ii] != pis[ii]) {
								redimed(var);
							}
						}
					}
				}
				machine.add(vary);
				vars.set(i, vary);
				var = vary;
			}
			var.clear();
		}
		return null;
	}

	private void redimed(Variable var) {
		throw new RuntimeException("Redim'd array error: " + var.getName() + "/" + this);
	}

	@Override
	public List<CodeContainer> evalToCode(Machine machine) {
		// Just make sure that the machine has access to the arrays...there's no
		// actual native code needed here.
		this.execute(machine);

		for (int i = 0; i < vars.size(); i++) {
			Variable var = vars.get(i);
			List<Atom> pars = terms.get(var.getName());
			for (Atom par : pars) {
				if (((Number) par.eval(machine)).intValue() == 0) {
					throw new RuntimeException("Arrays have to defined static and can't have a zero size!");
				}
			}
		}

		return new ArrayList<CodeContainer>();
	}

}
