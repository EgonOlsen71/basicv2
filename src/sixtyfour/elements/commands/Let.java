package sixtyfour.elements.commands;

import sixtyfour.Parser;
import sixtyfour.Memory;
import sixtyfour.elements.Term;
import sixtyfour.elements.Type;
import sixtyfour.elements.Variable;

public class Let extends AbstractCommand {
	private Variable var;
	private Term value;

	public Let() {
		super("LET");
	}

	public Variable getVar() {
		return var;
	}

	public void setVar(Variable var) {
		this.var = var;
	}

	public Term getValue() {
		return value;
	}

	public void setValue(Term value) {
		this.value = value;
	}

	@Override
	public Type getType() {
		return var.getType();
	}

	@Override
	public void parse(String linePart, Memory memory) {
		var = Parser.getVariable(linePart, memory);
		term = Parser.getTerm(linePart, memory);
		if (!var.getType().equals(term.getType()) && !(var.getType().equals(Type.REAL) && term.getType().equals(Type.INTEGER))) {
			throw new RuntimeException("Type mismatch error: " + linePart);
		}
	}

	@Override
	public void execute(Memory memory) {
		Variable v = memory.add(var);
		v.setValue(term.eval());
	}

}
