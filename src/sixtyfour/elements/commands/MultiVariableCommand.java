package sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import sixtyfour.elements.Variable;
import sixtyfour.parser.Parser;
import sixtyfour.parser.Term;
import sixtyfour.parser.VariableAndIndex;
import sixtyfour.system.Machine;

public abstract class MultiVariableCommand extends AbstractCommand {
	protected List<Variable> vars = new ArrayList<Variable>();
	protected List<Term> indexTerms = new ArrayList<Term>();

	public MultiVariableCommand(String name) {
		super(name);
	}

	final protected Variable getVariable(Machine machine, int i) {
		Variable var = vars.get(i);
		Variable oldVar = var;
		var = machine.add(var);
		if (var != oldVar) {
			vars.set(i, var);
		}
		return var;
	}

	final protected Character ensureNumberKey(Machine machine, Character input, boolean checkColon) {
		if (input == '+' || input == '-' || input == '.' || input == ',' || input == 'e') {
			input = '0';
		}
		if (checkColon && input == ':') {
			machine.getOutputChannel().println(0, "?Extra ignored:" + this);
			input = '0';
		}
		if (input < '0' || input > '9') {
			throw new RuntimeException("Syntax error: " + this);
		}
		return input;
	}

	final protected void fillVariables(String linePart, Machine machine) {
		int brackets = 0;
		StringBuilder sb = new StringBuilder();
		List<String> parts = new ArrayList<String>();
		List<String> varNames = new ArrayList<String>();
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
				String pa = sb.toString();
				varNames.add(Parser.getVariableName(pa));
				parts.add(pa);
				sb.setLength(0);
			}
		}
		int cnt = 0;
		for (String part : parts) {
			Variable var = new Variable(varNames.get(cnt++).trim().toUpperCase(Locale.ENGLISH), null);
			VariableAndIndex vai = Parser.getIndexTerm(var, part, machine, false);
			var = vai.getVariable();
			indexTerms.add(vai.getIndexTerm());
			vars.add(var);
		}
	}

}
