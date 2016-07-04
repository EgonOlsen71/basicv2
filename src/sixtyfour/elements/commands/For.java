package sixtyfour.elements.commands;

import java.util.Locale;

import sixtyfour.elements.Type;
import sixtyfour.elements.Variable;
import sixtyfour.parser.Parser;
import sixtyfour.parser.Term;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;

/**
 * The Class For.
 */
public class For extends AbstractCommand {
	
	/** The var. */
	private Variable var;
	
	/** The end term. */
	private Term endTerm;
	
	/** The step term. */
	private Term stepTerm;
	
	/** The end. */
	private float end;
	
	/** The step. */
	private float step = 1f;
	
	/** The running. */
	private boolean running = false;

	/**
	 * Instantiates a new for.
	 */
	public For() {
		super("FOR");
	}

	/**
	 * Gets the var.
	 * 
	 * @return the var
	 */
	public Variable getVar() {
		return var;
	}

	/**
	 * Sets the var.
	 * 
	 * @param var
	 *            the new var
	 */
	public void setVar(Variable var) {
		this.var = var;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.commands.AbstractCommand#getType()
	 */
	@Override
	public Type getType() {
		return var.getType();
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String, int, int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine memory) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, memory);
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

	/* (non-Javadoc)
	 * @see sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.Machine)
	 */
	@Override
	public ProgramCounter execute(Machine machine) {
		var = machine.add(var);
		var.setValue(term.eval(machine));
		//System.out.println(this.lineNumber+"/"+endTerm+"/"+endTerm.getType()+"/"+endTerm.eval(machine).getClass()+"/"+endTerm.eval(machine));
		end = ((Number) endTerm.eval(machine)).floatValue();
		step = ((Number) stepTerm.eval(machine)).floatValue();

		machine.pushFor(this);
		running = true;
		return null;
	}

	/**
	 * Next.
	 * 
	 * @param next
	 *            the next
	 * @param memory
	 *            the memory
	 * @return true, if successful
	 */
	public boolean next(Next next, Machine memory) {
		if (next.getVarName() != null && !next.getVarName().equalsIgnoreCase(var.getName())) {
			throw new RuntimeException("NEXT without FOR: " + next);
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
				For these = memory.popFor(this);
				if (these == null) {
					throw new RuntimeException("Out of memory error: " + this);
				}
				running = false;
			}
			return false;
		}
	}
}
