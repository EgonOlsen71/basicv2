package sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import sixtyfour.elements.Type;
import sixtyfour.elements.Variable;
import sixtyfour.parser.Atom;
import sixtyfour.parser.Parser;
import sixtyfour.parser.Term;
import sixtyfour.parser.VariableAndIndex;
import sixtyfour.system.DataStore;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;

public class Read extends AbstractCommand {

	private List<Variable> vars = new ArrayList<Variable>();
	private List<Term> indexTerms = new ArrayList<Term>();

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

		int brackets = 0;
		StringBuilder sb = new StringBuilder();
		List<String> parts = new ArrayList<String>();
		for (int i = 0; i < linePart.length(); i++) {
			char c = linePart.charAt(i);
			if (c == '(') {
				brackets++;
			} else if (c == ')') {
				brackets--;
			}
			if (c != ',' || brackets != 0) {
				sb.append(c);
			}

			if (brackets == 0 && (c == ',' || i == linePart.length() - 1)) {
				parts.add(Parser.getVariableName(sb.toString()));
				sb.setLength(0);
			}
		}
		for (String part : parts) {
			Variable var = new Variable(part.trim().toUpperCase(Locale.ENGLISH), null);
			VariableAndIndex vai = Parser.getIndexTerm(var, linePart, machine, false);
			var = vai.getVariable();
			indexTerms.add(vai.getIndexTerm());
			vars.add(var);
		}
		return null;
	}

	@Override
	public ProgramCounter execute(Machine machine) {
		DataStore data = machine.getDataStore();
		for (int i = 0; i < vars.size(); i++) {
			Term indexTerm = indexTerms.get(i);
			Variable var = vars.get(i);
			var = machine.add(var);
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
					System.out.println("PAR: "+par.toString()+"/"+par.eval(machine)+"/"+par.getType()+"/"+par.getClass());
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
