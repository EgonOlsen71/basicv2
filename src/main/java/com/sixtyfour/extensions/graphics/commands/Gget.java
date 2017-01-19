package com.sixtyfour.extensions.graphics.commands;

import java.util.List;

import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.extensions.graphics.GraphicsDevice;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.VariableAndIndex;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The GGET command. This is similar to GET in BASIC V2, but queries the
 * graphics device instead of the input provider.
 * 
 * @author Foerster-H
 * 
 */
public class Gget extends AbstractGraphicsCommand {
	private Variable var = null;
	private Term indexTerm = null;
	private String allowedChars = null;

	public Gget() {
		super("Gget");
	}

	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		String ret = super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine, 1, 0);
		this.fillVariable(linePart.substring(4).trim(), machine);
		return ret;
	}

	private void fillVariable(String linePart, Machine machine) {
		int brackets = 0;
		StringBuilder sb = new StringBuilder();
		String part = null;
		String varName = null;
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
			if (c == ',') {
				throw new RuntimeException("Snytax error " + this);
			}

			if (brackets == 0 && (i == linePart.length() - 1)) {
				String pa = sb.toString();
				varName = Parser.getVariableName(pa);
				part = pa;
				sb.setLength(0);
				break;
			}
		}
		Variable var = new Variable(VarUtils.toUpper(varName.trim()), null);
		VariableAndIndex vai = Parser.getIndexTerm(var, part, machine, false);
		var = vai.getVariable();
		indexTerm = vai.getIndexTerm();
		this.var = var;
	}

	private Variable getVariable(Machine machine) {
		return machine.add(var);
	}

	private Character ensureNumberKey(Machine machine, Character input, boolean checkColon) {
		if (input == '+' || input == '-' || input == '.' || input == ',' || input == 'e') {
			input = '0';
		}
		if (checkColon && input == ':') {
			machine.getOutputChannel().systemPrintln(0, "?Extra ignored:" + this);
			input = '0';
		}
		if (input < '0' || input > '9') {
			throw new RuntimeException("Syntax error: " + this);
		}
		return input;
	}

	@Override
	public BasicProgramCounter execute(Machine machine) {
		GraphicsDevice window = GraphicsDevice.getDevice(machine);
		if (window != null) {
			Variable var = this.getVariable(machine);
			Character input = window.gget(allowedChars);
			if (indexTerm != null) {
				List<Atom> pars = Parser.getParameters(indexTerm);
				int[] pis = new int[pars.size()];
				int cnt = 0;
				for (Atom par : pars) {
					pis[cnt++] = VarUtils.getInt(par.eval(machine));
				}
				if (var.getType().equals(Type.STRING)) {
					if (allowedChars == null) {
						allowedChars = var.getValue(pis).toString();
						if (input != null && allowedChars.indexOf(input) == -1) {
							input = null;
						}
					}
					if (input == null) {
						var.setValue("", pis);
					} else {
						var.setValue(input.toString(), pis);
					}
				} else {
					if (input == null) {
						var.setValue(0, pis);
					} else {
						input = ensureNumberKey(machine, input, true);
						var.setValue(Integer.valueOf(input.toString()), pis);
					}
				}
			} else {
				if (var.getType().equals(Type.STRING)) {
					if (allowedChars == null) {
						allowedChars = var.getValue().toString();
						if (input != null && allowedChars.indexOf(input) == -1) {
							input = null;
						}
					}
					if (input == null) {
						var.setValue("");
					} else {
						var.setValue(input.toString());
					}
				} else {
					if (input == null) {
						var.setValue(0);
					} else {
						input = ensureNumberKey(machine, input, true);
						var.setValue(Integer.valueOf(input.toString()));
					}
				}
			}
		}
		return null;
	}
}
