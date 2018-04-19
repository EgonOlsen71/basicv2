package com.sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.VariableAndIndex;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * An abstract base class for commands that can have multiple variables like
 * READ.
 * 
 * @author EgonOlsen
 */
public abstract class MultiVariableCommand extends AbstractCommand {

	/** The vars. */
	protected List<Variable> vars = new ArrayList<Variable>();

	/** The index terms. */
	protected List<Term> indexTerms = new ArrayList<Term>();

	/**
	 * Instantiates a new multi variable command.
	 * 
	 * @param name
	 *            the name
	 */
	public MultiVariableCommand(String name) {
		super(name);
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
		ret.addAll(this.indexTerms);
		return ret;
	}

	final protected List<CodeContainer> evalToCode(Machine machine, String strCall, String numberCall) {
		NativeCompiler compiler = NativeCompiler.getCompiler();
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();
		boolean added=false;
		
		for (int i = 0; i < vars.size(); i++) {
			Term indexTerm = indexTerms.get(i);
			Variable var = this.getVariable(machine, i);
			List<String> after = new ArrayList<String>();
			List<String> expr = new ArrayList<String>();
			List<String> before = new ArrayList<String>();;

			if (var.getType() == Type.STRING) {
				expr.add("JSR " + strCall);
				if (!added) {
					//before.add(0, "JSR COMPACT"); // Shouldn't be needed here...
					added=true;
				}
			} else if (var.getType() == Type.INTEGER || var.getType() == Type.REAL) {
				expr.add("JSR " + numberCall);
			}

			if (indexTerm != null) {
				List<Atom> pars = Parser.getParameters(indexTerm);
				before.addAll(compiler.compileToPseudoCode(machine, Parser.createIndexTerm(machine, pars, var.getDimensions())));

				after.add("POP X");
				after.add("MOV G," + getVariableLabel(machine, var));
				after.add("JSR ARRAYSTORE");
			} else {
				after.add("MOV " + getVariableLabel(machine, var) + "," + (var.getType() == Type.STRING ? "A" : "Y"));
			}

			CodeContainer cc = new CodeContainer(before, expr, after);
			ccs.add(cc);
		}
		return ccs;
	}

	final protected List<CodeContainer> evalToCodeFile(Machine machine, String strCall, String numberCall) {
		NativeCompiler compiler = NativeCompiler.getCompiler();
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();

		for (int i = 0; i < vars.size(); i++) {
			Term indexTerm = indexTerms.get(i);
			Variable var = this.getVariable(machine, i);
			List<String> after = new ArrayList<String>();
			List<String> expr = new ArrayList<String>();
			List<String> before = new ArrayList<String>();

			before = saveG(before);

			if (var.getType() == Type.STRING) {
				before.add("JSR " + strCall);
			} else if (var.getType() == Type.INTEGER || var.getType() == Type.REAL) {
				before.add("JSR " + numberCall);
			}

			if (i != vars.size() - 1) {
				before.add("PUSH G");
			}

			if (indexTerm != null) {
				List<Atom> pars = Parser.getParameters(indexTerm);
				expr = compiler.compileToPseudoCode(machine, Parser.createIndexTerm(machine, pars, var.getDimensions()));

				after.add("POP X");
				after.add("MOV G," + getVariableLabel(machine, var));
				after.add("JSR ARRAYSTORE");
			} else {
				after.add("MOV " + getVariableLabel(machine, var) + "," + (var.getType() == Type.STRING ? "A" : "Y"));
			}

			CodeContainer cc = new CodeContainer(before, expr, after);
			ccs.add(cc);
		}
		return ccs;
	}

	/**
	 * Gets the variable at a position.
	 * 
	 * @param machine
	 *            the machine
	 * @param i
	 *            the position
	 * @return the variable
	 */
	final protected Variable getVariable(Machine machine, int i) {
		Variable var = vars.get(i);
		Variable oldVar = var;
		var = machine.add(var);
		if (var != oldVar) {
			vars.set(i, var);
		}
		return var;
	}

	/**
	 * Only lets characters pass that can be part of numbers.
	 * 
	 * @param machine
	 *            the machine
	 * @param input
	 *            the input character
	 * @param checkColon
	 *            if true, : will cause an ?Extra ignored message. Otherwise, it
	 *            will cause an exception.
	 * @return the character
	 */
	final protected Character ensureNumberKey(Machine machine, Character input, boolean checkColon) {
		if (input == '+' || input == '-' || input == '.' || input == ',' || input == 'e') {
			input = '0';
		}
		if (checkColon && input == ':') {
			machine.getOutputChannel().systemPrintln(0, "?Extra ignored:" + this);
			input = '0';
		}
		if (input < '0' || input > '9') {
			syntaxError(this);
		}
		return input;
	}

	/**
	 * Creates the variables needed based on the input string.
	 * 
	 * @param linePart
	 *            the string that defines the variables
	 * @param machine
	 *            the machine
	 */
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
			Variable var = new Variable(VarUtils.toUpper(varNames.get(cnt++).trim()), null);
			VariableAndIndex vai = Parser.getIndexTerm(var, part, machine, false);
			var = vai.getVariable();
			indexTerms.add(vai.getIndexTerm());
			vars.add(var);
			machine.trackVariableUsage(var, false);
		}
	}

}
