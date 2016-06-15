package sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import sixtyfour.elements.Type;
import sixtyfour.elements.Variable;
import sixtyfour.parser.Parser;
import sixtyfour.system.DataStore;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;

public class Read extends AbstractCommand {

	private List<Variable> vars = new ArrayList<Variable>();

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

		String[] parts = linePart.split(",");
		for (String part : parts) {
			Variable var = new Variable(part.trim().toUpperCase(Locale.ENGLISH), null);
			vars.add(var);
		}
		return null;
	}

	@Override
	public ProgramCounter execute(Machine machine) {
		DataStore data = machine.getDataStore();
		for (int i = 0; i < vars.size(); i++) {
			Variable var = vars.get(i);
			var = machine.add(var);
			Object obj = data.read();
			if (obj == null) {
				throw new RuntimeException("Out of data error: " + this);
			}
			Type varType = var.getType();
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
		return null;
	}

}
