package sixtyfour.elements.commands;

import java.util.List;

import sixtyfour.Memory;
import sixtyfour.Parser;
import sixtyfour.elements.Atom;
import sixtyfour.elements.ProgramCounter;
import sixtyfour.elements.Term;
import sixtyfour.elements.Type;
import sixtyfour.elements.Variable;

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
	public void parse(String linePart, int lineCnt, int lineNumber, int linePos, Memory memory) {
		super.parse(linePart, lineCnt, lineNumber, linePos, memory);
		var = Parser.getVariable(linePart, memory);
		if (var.getName().endsWith("[]")) {
			// array
			int pos = linePart.indexOf('(');
			int pos2 = linePart.lastIndexOf(')');
			if (pos != -1 && pos2 != -1) {
				Term params = Parser.getTerm(linePart.substring(pos + 1, pos2), memory);
				List<Atom> pars = Parser.getParameters(params);
				boolean dimed = memory.getVariable(var.getName()) != null;
				if (!dimed) {
					int[] pis = new int[pars.size()];
					for (int i = 0; i < pis.length; i++) {
						pis[i] = 10;
					}
					var = memory.add(new Variable(var.getName(), null, pis));
					var.clear();
				} else {
					var = memory.add(new Variable(var.getName(), null));
				}
				indexTerm = params;
			} else {
				throw new RuntimeException("Array index out of bounds error: " + this);
			}
		}
		term = Parser.getTerm(linePart, memory);
		if (!var.getType().equals(term.getType()) && !(var.getType().equals(Type.REAL) && term.getType().equals(Type.INTEGER))) {
			throw new RuntimeException("Type mismatch error: " + linePart);
		}
	}

	@Override
	public ProgramCounter execute(Memory memory) {
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
