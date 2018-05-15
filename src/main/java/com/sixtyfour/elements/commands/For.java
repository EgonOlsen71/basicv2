package com.sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.TermEnhancer;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The FOR command.
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
	 * Gets the variable used for looping.
	 * 
	 * @return the variable
	 */
	public Variable getVar() {
		return var;
	}

	/**
	 * Sets the variable used for looping.
	 * 
	 * @param var
	 *            the new variable
	 */
	public void setVar(Variable var) {
		this.var = var;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#getType()
	 */
	@Override
	public Type getType() {
		return var.getType();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.commands.Command#getAllTerms()
	 */
	@Override
	public List<Term> getAllTerms() {
		List<Term> ret = new ArrayList<Term>();
		ret.add(term);
		ret.add(endTerm);
		ret.add(stepTerm);
		return ret;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String,
	 * int, int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(config, linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		linePart = TermEnhancer.removeWhiteSpace(linePart.substring(this.name.length()));
		String uLinePart = VarUtils.toUpper(linePart);

		int posTo = uLinePart.indexOf("TO");
		int posStep = uLinePart.indexOf("STEP");

		if (posTo == -1) {
			throw new RuntimeException("FOR without TO: " + linePart);
		}

		String assignment = linePart.substring(0, posTo);
		var = Parser.getVariable(assignment, machine);
		term = Parser.getTerm(config, assignment, machine, true, true);

		if (var.getType() == Type.INTEGER) {
			syntaxError(linePart);
		}

		if (!var.getType().equals(term.getType()) && !(var.getType().equals(Type.REAL) && term.getType().equals(Type.INTEGER))) {
			typeMismatch(linePart);
		}

		String toTxt = null;
		String stepTxt = null;

		if (posStep == -1) {
			toTxt = linePart.substring(posTo + 2);
		} else {
			toTxt = linePart.substring(posTo + 2, posStep);
		}
		endTerm = Parser.getTerm(config, toTxt, machine, false, true);

		if (posStep != -1) {
			stepTxt = linePart.substring(posStep + 4);
		} else {
			stepTxt = "1";
		}
		stepTerm = Parser.getTerm(config, stepTxt, machine, false, true);

		if (!Parser.isNumberType(endTerm)) {
			typeMismatch(endTerm);
		}

		if (!Parser.isNumberType(stepTerm)) {
			typeMismatch(stepTerm);
		}

		machine.trackVariableUsage(var, false);
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
		var = machine.add(var);
		var.setValue(term.eval(machine));
		end = VarUtils.getFloat(endTerm.eval(machine));
		step = VarUtils.getFloat(stepTerm.eval(machine));

		machine.pushFor(this);
		running = true;
		return null;
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		var = machine.add(var);
		NativeCompiler compiler = NativeCompiler.getCompiler();
		List<String> after = new ArrayList<String>();
		List<String> expr = compiler.compileToPseudoCode(config, machine, endTerm);
		expr.addAll(compiler.compileToPseudoCode(config, machine, stepTerm));
		expr.addAll(compiler.compileToPseudoCode(config, machine, term));
		List<String> before = null;

		String varLabel = var.getName() + "{" + var.getType() + "}";
		String expPush = getPushRegister(expr.get(expr.size() - 1));
		expr = expr.subList(0, expr.size() - 1);

		after.add("MOV " + varLabel + "," + expPush);
		after.add("MOV A,(" + varLabel + ")");
		after.add("JSR INITFOR");

		CodeContainer cc = new CodeContainer(before, expr, after);
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();
		ccs.add(cc);
		return ccs;
	}

	/**
	 * Executes a next call for this for.
	 * 
	 * @param next
	 *            the command that is associated with this for
	 * @param machine
	 *            the current machine
	 * @return true, if there will be a another iteration. false otherwise.
	 */
	public boolean next(Next next, Machine machine) {
		if (next.getVarName() != null && !next.getVarName().equalsIgnoreCase(var.getName())) {
			throw new RuntimeException("NEXT without FOR: " + next);
		}

		if (!running) {
			return false;
		}
		float cur = var.inc(step);
		if ((step > 0 && cur <= end) || (step < 0 && cur >= end)) {
			return true;
		} else {
			if (running) {
				For these = machine.popFor(this);
				if (these == null) {
					throw new RuntimeException("Out of memory error: " + this);
				}
				running = false;
			}
			return false;
		}
	}

	/**
	 * Sets the counter to the value that it would have after finishing the loop
	 * 
	 * @param machine
	 *            the current machine
	 */
	public void setToFinalValue(Machine machine) {
		var.setValue(VarUtils.getFloat(endTerm.eval(machine)) + 1);
	}

	/**
	 * Returns the number of steps that would be needed to count from start to
	 * end using step.
	 * 
	 * @param machine
	 *            the current machine
	 * @return the steps
	 */
	public int getSteps(Machine machine) {
		float s = VarUtils.getFloat(term.eval(machine));
		float e = VarUtils.getFloat(endTerm.eval(machine));
		float stp = VarUtils.getFloat(stepTerm.eval(machine));
		return (int) Math.abs((((e - s) / stp) + 0.5));
	}
}
