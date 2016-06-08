package sixtyfour;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import sixtyfour.elements.Type;
import sixtyfour.elements.Variable;

public class Memory {
	private Map<String, Variable> strings = new HashMap<String, Variable>();
	private Map<String, Variable> ints = new HashMap<String, Variable>();
	private Map<String, Variable> reals = new HashMap<String, Variable>();

	public Variable add(Variable var) {
		Variable ret = getVariable(var.getName());
		if (ret == null) {
			if (var.getType().equals(Type.STRING)) {
				strings.put(var.getName(), var);
			} else if (var.getType().equals(Type.INTEGER)) {
				ints.put(var.getName(), var);
			} else if (var.getType().equals(Type.REAL)) {
				reals.put(var.getName(), var);
			}
			if (var.getType().equals(Type.ARRAY)) {
				throw new RuntimeException("Not supported yet!");
			}
			ret = var;
		}
		return ret;
	}

	public Variable getVariable(String name) {
		if (name == null) {
			throw new RuntimeException("Null variable found!");
		}

		name = name.toUpperCase(Locale.ENGLISH);

		char c = name.charAt(name.length() - 1);
		if (c == '$') {
			return strings.get(name);
		} else if (c == '%') {
			return ints.get(name);
		} else if (Character.isAlphabetic(c) || Character.isDigit(c)) {
			return reals.get(name);
		}
		if (c == ']') {
			throw new RuntimeException("Not supported yet!");
		}
		return null;
	}
}
