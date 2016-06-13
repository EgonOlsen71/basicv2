package sixtyfour.elements.commands;

import java.util.Locale;

import sixtyfour.elements.Type;
import sixtyfour.elements.Variable;
import sixtyfour.parser.Parser;
import sixtyfour.parser.Term;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;
import sixtyfour.system.StackEntry;

public class For extends AbstractCommand {
	private Variable var;
	private Term endTerm;
	private Term stepTerm;
	private float end;
	private float step = 1f;
	private boolean running = false;
	private Next next;

	public For() {
		super("FOR");
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
		linePart = Parser.removeWhiteSpace(linePart.substring(this.name.length()));
		String uLinePart = linePart.toUpperCase(Locale.ENGLISH);

		int posTo = uLinePart.indexOf("TO");
		int posStep = uLinePart.indexOf("STEP");

		if (posTo == -1) {
			throw new RuntimeException("FOR without TO: " + linePart);
		}

		String assignment = linePart.substring(0, posTo);
		var = Parser.getVariable(assignment, memory);
		term = Parser.getTerm(assignment, memory, true, true);
		if (!var.getType().equals(term.getType()) && !(var.getType().equals(Type.REAL) && term.getType().equals(Type.INTEGER))) {
			throw new RuntimeException("Type mismatch error: " + linePart);
		}

		String toTxt = null;
		String stepTxt = null;

		if (posStep == -1) {
			toTxt = linePart.substring(posTo + 2);
		} else {
			toTxt = linePart.substring(posTo + 2, posStep);
		}
		endTerm = Parser.getTerm(toTxt, memory, false, true);

		if (posStep != -1) {
			stepTxt = linePart.substring(posStep + 4);
		} else {
			stepTxt = "1";
		}
		stepTerm = Parser.getTerm(stepTxt, memory, false, true);

		if (!Parser.isNumberType(endTerm)) {
			throw new RuntimeException("Type mismatch error: " + endTerm);
		}

		if (!Parser.isNumberType(stepTerm)) {
			throw new RuntimeException("Type mismatch error: " + stepTerm);
		}
		return null;
	}

	@Override
	public ProgramCounter execute(Machine machine) {
		if (next == null) {
			throw new RuntimeException("For without next error: " + this);
		}
		var = machine.add(var);
		var.setValue(term.eval(machine));
		end = ((Number) endTerm.eval(machine)).floatValue();
		step = ((Number) stepTerm.eval(machine)).floatValue();

		machine.push(this);
		running = true;
		return null;
	}

	public boolean next(Next next, Machine memory) {
		if (!next.getVarName().equalsIgnoreCase(var.getName())) {
			throw new RuntimeException("Next without for: " + next);
		}

		if (!running) {
			return false;
		}
		var.inc(step);
		float cur = ((Number) var.getValue()).floatValue();
		if ((step < 0 && cur >= end) || (step > 0 && cur <= end)) {
			return true;
		} else {
			if (running) {
				StackEntry se = memory.pop();
				if (se.getCommand() != this) {
					throw new RuntimeException("Out of memory error: " + this);
				}
				running = false;
			}

			return false;
		}
	}

	public Next getNext() {
		return next;
	}

	public void setNext(Next next) {
		this.next = next;
	}

}
