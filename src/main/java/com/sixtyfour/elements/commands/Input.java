package com.sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.Util;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.TermEnhancer;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.plugins.OutputChannel;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.util.VarUtils;

/**
 * The INPUT command.
 */
public class Input extends MultiVariableCommand {

	private static int inputCount = 0;
	/** The comment. */
	protected String comment = "";

	/**
	 * Instantiates a new input.
	 */
	public Input() {
		super("INPUT");
	}

	/**
	 * Instantiates a new input.
	 * 
	 * @param name
	 *            the name
	 */
	protected Input(String name) {
		super(name);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#getType()
	 */
	@Override
	public Type getType() {
		return Type.NONE;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String,
	 * int, int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		linePart = TermEnhancer.removeWhiteSpace(linePart);
		linePart = linePart.substring(5).trim();
		if (linePart.length() == 0) {
			syntaxError(this);
		}
		int pos = linePart.indexOf('"');
		if (pos != -1) {
			if (linePart.length() < 4 || pos != 0) {
				syntaxError(this);
			}
			int pos2 = linePart.indexOf("\";", pos + 1);
			if (pos2 == -1 || pos2 == linePart.length() - 2) {
				syntaxError(this);
			}
			comment = linePart.substring(pos + 1, pos2);
			linePart = linePart.substring(pos2 + 2);
		}
		this.fillVariables(linePart, machine);
		return null;
	}

	@Override
	public List<CodeContainer> evalToCode(Machine machine) {
		NativeCompiler compiler = NativeCompiler.getCompiler();
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();

		String labelCheck = "INPUTCHECK" + inputCount;
		String label = "INPUT" + (inputCount++);
		ccs.addAll(Util.createSingleCommand(label + ":", "JSR CLEARQUEUE", "JSR COMPACT"));
		if (comment != null) {
			ccs.addAll(Util.createSingleCommand("MOV A,#" + comment + "{STRING}", "JSR STROUT"));
		}

		for (int i = 0; i < vars.size(); i++) {
			Term indexTerm = indexTerms.get(i);
			Variable var = this.getVariable(machine, i);
			List<String> after = new ArrayList<String>();
			List<String> expr = new ArrayList<String>();
			List<String> before = null;

			if (i == 0) {
				expr.add("MOV A,#? {STRING}");
				expr.add("JSR STROUT");
			} else {
				expr.add("JSR QUEUESIZE");
				expr.add("CMP X,#0{REAL}");
				expr.add("JNE Q" + label + "_" + i);
				expr.add("MOV A,#?? {STRING}");
				expr.add("JSR STROUT");
				expr.add("Q" + label + "_" + i + ":");
			}

			if (var.getType() == Type.STRING) {
				expr.add("JSR INPUTSTR");
			} else if (var.getType() == Type.INTEGER || var.getType() == Type.REAL) {
				String label2 = label + "_" + i;
				expr.add("JSR INPUTNUMBER");
				expr.add("CMP X,#0{REAL}");
				expr.add("JE " + label2);
				expr.add("MOV A,#?redo from start{STRING}");
				expr.add("JSR STROUT");
				expr.add("JSR LINEBREAK");
				expr.add("JMP " + label);
				expr.add(label2 + ":");
			}

			if (indexTerm != null) {
				List<Atom> pars = Parser.getParameters(indexTerm);
				before = compiler.compileToPseudoCode(machine, Parser.createIndexTerm(machine, pars, var.getDimensions()));

				after.add("POP X");
				after.add("MOV G," + getVariableLabel(machine, var));
				after.add("JSR ARRAYSTORE");
			} else {
				after.add("MOV " + getVariableLabel(machine, var) + "," + (var.getType() == Type.STRING ? "A" : "Y"));
			}

			CodeContainer cc = new CodeContainer(before, expr, after);
			ccs.add(cc);
		}

		List<String> check = new ArrayList<String>();
		check.add("JSR QUEUESIZE");
		check.add("CMP X,#0{REAL}");
		check.add("JE " + labelCheck);
		check.add("JSR EXTRAIGNORED");
		check.add(labelCheck + ":");
		CodeContainer cc = new CodeContainer(null, check, null);
		ccs.add(cc);

		return ccs;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public BasicProgramCounter execute(Machine machine) {
		List<String> queue = new ArrayList<String>();
		OutputChannel out = machine.getOutputChannel();
		for (int i = 0; i < vars.size(); i++) {
			Term indexTerm = indexTerms.get(i);
			Variable var = getVariable(machine, i);
			if (i == 0) {
				if (comment != null) {
					out.print(0, comment);
				}
				out.print(0, "? ");
			} else {
				if (queue.isEmpty()) {
					out.print(0, "?? ");
				}
			}

			String input = null;
			if (queue.isEmpty()) {
				input = machine.getInputProvider().readString();
				out.println(0, "");
				if (input == null) {
					input = "";
				}
				String[] parts = input.split(",");
				if (parts.length > 1) {
					for (int p = 1; p < parts.length; p++) {
						queue.add(parts[p]);
					}
				}
				input = parts[0];
			} else {
				input = queue.remove(0);
			}

			Type varType = var.getType();

			if (indexTerm != null) {
				// array
				List<Atom> pars = Parser.getParameters(indexTerm);
				int[] pis = new int[pars.size()];
				int cnt = 0;
				for (Atom par : pars) {
					pis[cnt++] = VarUtils.getInt(par.eval(machine));
				}
				try {
					if (varType.equals(Type.STRING)) {
						var.setValue(input.toString(), pis);
					} else if (varType.equals(Type.REAL)) {
						var.setValue(Float.valueOf(input), pis);
					} else if (varType.equals(Type.INTEGER)) {
						var.setValue(Integer.valueOf(input), pis);
					}
				} catch (NumberFormatException nfe) {
					out.systemPrintln(0, "?Redo from start");
					queue.clear();
					i = -1;
				}
			} else {
				// no array
				if (varType.equals(Type.STRING)) {
					if (input != null) {
						var.setValue(input);
					}
				} else {
					if (input != null) {
						if (varType.equals(Type.INTEGER)) {
							try {
								Integer num = Integer.valueOf(input);
								var.setValue(num);
							} catch (NumberFormatException nfe) {
								out.systemPrintln(0, "?Redo from start");
								queue.clear();
								i = -1;
							}
						} else {
							try {
								Float num = Float.valueOf(input);
								var.setValue(num);
							} catch (NumberFormatException nfe) {
								out.systemPrintln(0, "?Redo from start");
								queue.clear();
								i = -1;
							}
						}
					}
				}
			}
		}
		return null;
	}
}
