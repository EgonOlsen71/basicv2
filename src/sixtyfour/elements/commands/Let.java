package sixtyfour.elements.commands;

import java.util.List;
import java.util.Locale;

import sixtyfour.ProgramCounter;
import sixtyfour.elements.Type;
import sixtyfour.elements.Variable;
import sixtyfour.parser.Atom;
import sixtyfour.parser.Parser;
import sixtyfour.parser.Term;
import sixtyfour.system.Machine;

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

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, Machine memory) {
		super.parse(linePart, lineCnt, lineNumber, linePos, memory);
		if (linePart.toUpperCase(Locale.ENGLISH).startsWith("LET")) {
			linePart = linePart.substring(3).trim();
		}
		var = Parser.getVariable(linePart, memory);
		if (var.getName().endsWith("[]")) {
			// array
			int pos = linePart.indexOf('(');
			int pos2 = linePart.lastIndexOf(')');
			if (pos != -1 && pos2 != -1) {
				Term params = Parser.getTerm(linePart.substring(pos + 1, pos2), memory, false, true);
				List<Atom> pars = Parser.getParameters(params);
				boolean dimed = memory.getVariable(var.getName()) != null;
				if (!dimed) {
					int[] pis = new int[pars.size()];
					for (int i = 0; i < pis.length; i++) {
						pis[i] = 10;
					}
					var = new Variable(var.getName(), null, pis);
					var.clear();
				}
				indexTerm = params;
			} else {
				throw new RuntimeException("Array index out of bounds error: " + this);
			}
		}
		term = Parser.getTerm(linePart, memory, true, true);
		if (!var.getType().equals(term.getType()) && !(var.getType().equals(Type.REAL) && term.getType().equals(Type.INTEGER))) {
			throw new RuntimeException("Type mismatch error: " + linePart);
		}
		return null;
	}

	@Override
	public ProgramCounter execute(Machine memory) {
		var = memory.add(var);
		if (indexTerm == null) {
			// no array
			var.setValue(term.eval(memory));
		} else {
			// array
			List<Atom> pars = Parser.getParameters(indexTerm);
			int[] pis = new int[pars.size()];
			int cnt = 0;
			for (Atom par : pars) {
				pis[cnt++] = ((Number) par.eval(memory)).intValue();
			}
			var.setValue(term.eval(memory), pis);
		}
		return null;
	}
}
