package sixtyfour.elements.commands;

import java.util.List;

import sixtyfour.elements.Type;
import sixtyfour.elements.Variable;
import sixtyfour.parser.Atom;
import sixtyfour.parser.Parser;
import sixtyfour.parser.Term;
import sixtyfour.system.DataStore;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;

public class Read extends MultiVariableCommand {
	public Read() {
		super("READ");
	}

	@Override
	public Type getType() {
		return Type.NONE;
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		linePart = Parser.removeWhiteSpace(linePart);
		linePart = linePart.substring(4).trim();
		if (linePart.length() == 0) {
			throw new RuntimeException("Syntax error: " + this);
		}
		this.fillVariables(linePart, machine);
		return null;
	}

	@Override
	public ProgramCounter execute(Machine machine) {
		DataStore data = machine.getDataStore();
		for (int i = 0; i < vars.size(); i++) {
			Term indexTerm = indexTerms.get(i);
			Variable var = this.getVariable(machine, i);
			Object obj = data.read();
			Type varType = var.getType();
			if (obj == null) {
				throw new RuntimeException("Out of data error: " + this);
			}
			if (indexTerm != null) {
				// array
				List<Atom> pars = Parser.getParameters(indexTerm);
				int[] pis = new int[pars.size()];
				int cnt = 0;
				for (Atom par : pars) {
					pis[cnt++] = ((Number) par.eval(machine)).intValue();
				}
				if (varType.equals(Type.STRING)) {
					var.setValue(obj.toString(), pis);
				} else if (varType.equals(Type.REAL)) {
					if (obj instanceof Float || obj instanceof Integer) {
						var.setValue(((Number) obj).floatValue(), pis);
					} else {
						throw new RuntimeException("Type mismatch error: " + this);
					}
				} else if (varType.equals(Type.INTEGER)) {
					if (obj instanceof Integer) {
						var.setValue(((Integer) obj).intValue(), pis);
					} else {
						throw new RuntimeException("Type mismatch error: " + this);
					}
				}
			} else {
				// no array
				if (varType.equals(Type.STRING)) {
					var.setValue(obj.toString());
				} else if (varType.equals(Type.REAL)) {
					if (obj instanceof Float || obj instanceof Integer) {
						var.setValue(((Number) obj).floatValue());
					} else {
						throw new RuntimeException("Type mismatch error: " + this);
					}
				} else if (varType.equals(Type.INTEGER)) {
					if (obj instanceof Integer) {
						var.setValue(((Integer) obj).intValue());
					} else {
						throw new RuntimeException("Type mismatch error: " + this);
					}
				}
			}
		}
		return null;
	}

}
