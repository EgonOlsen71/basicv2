/*
 * 
 */
package sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import sixtyfour.elements.Type;
import sixtyfour.elements.Variable;
import sixtyfour.parser.Atom;
import sixtyfour.parser.Parser;
import sixtyfour.parser.VariableAndTerms;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;

/**
 * The Class Dim.
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

	/* (non-Javadoc)
	 * @see sixtyfour.elements.commands.AbstractCommand#getType()
	 */
	@Override
	public Type getType() {
		return Type.NONE;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String, int, int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine memory) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, memory);
		List<VariableAndTerms> vars = Parser.getArrayVariables(linePart, memory);
		terms = new HashMap<String, List<Atom>>();
		this.vars = new ArrayList<Variable>();
		for (VariableAndTerms var : vars) {
			terms.put(var.getVarName(), var.getTerms());
			// Some placeholder vars...
			this.vars.add(new Variable(var.getVarName(), null));
		}
		return null;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.Machine)
	 */
	@Override
	public ProgramCounter execute(Machine memory) {
		for (int i = 0; i < vars.size(); i++) {
			Variable var = vars.get(i);
			if (!var.isArray()) {
				List<Atom> pars = terms.get(var.getName());
				int[] pis = new int[pars.size()];
				int cnt = 0;
				for (Atom par : pars) {
					pis[cnt++] = ((Number) par.eval(memory)).intValue();
				}
				Variable vary = new Variable(var.getName(), null, pis);
				if (memory.getVariable(vary.getName()) != null) {
					throw new RuntimeException("Redim'd array error: " + var.getName() + "/" + this);
				}
				memory.add(vary);
				vars.set(i, vary);
				var = vary;
			}
			var.clear();
		}
		return null;
	}

}
