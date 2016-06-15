package sixtyfour.elements.commands;

import java.util.List;
import java.util.Locale;

import sixtyfour.elements.Type;
import sixtyfour.elements.Variable;
import sixtyfour.parser.Atom;
import sixtyfour.parser.Parser;
import sixtyfour.parser.Term;
import sixtyfour.parser.VariableAndIndex;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;

public class Let extends AbstractCommand {
	private Variable var;
	private Term indexTerm;

	public Let() {
		super("LET");
	}

	public Variable getVar() {
		return var;
	}

	public void setVar(Variable var) {
		this.var = var;
	}

	@Override
	public Type getType() {
		return var.getType();
	}

	// rm$(lb)=rm$(lb)+CHR$(13)+"A sign here says:  LIMBO, find right    exit "

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		if (linePart.toUpperCase(Locale.ENGLISH).startsWith("LET")) {
			linePart = linePart.substring(3).trim();
		}
		var = Parser.getVariable(linePart, machine);
		VariableAndIndex vai = Parser.getIndexTerm(var, linePart, machine, true);
		indexTerm=vai.getIndexTerm();
		var=vai.getVariable();
		term = Parser.getTerm(linePart, machine, true, true);
		if (!var.getType().equals(term.getType()) && (var.getType().equals(Type.STRING) || term.getType().equals(Type.STRING))) {
			throw new RuntimeException("Type mismatch error: " + linePart);
		}
		return null;
	}

	@Override
	public ProgramCounter execute(Machine machine) {
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
				pis[cnt++] = ((Number) par.eval(machine)).intValue();
			}
			var.setValue(term.eval(machine), pis);
		}
		return null;
	}
}
