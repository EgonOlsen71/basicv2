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

public class Dim extends AbstractCommand {

	private List<Variable> vars;
	private Map<String, List<Atom>> terms;

	public Dim() {
		super("DIM");
	}

	public List<Variable> getVars() {
		return vars;
	}

	public void setVar(List<Variable> vars) {
		this.vars = vars;
	}

	@Override
	public Type getType() {
		return Type.NONE;
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, Machine memory) {
		super.parse(linePart, lineCnt, lineNumber, linePos, memory);
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
