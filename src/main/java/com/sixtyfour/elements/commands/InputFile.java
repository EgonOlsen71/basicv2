package com.sixtyfour.elements.commands;

import java.util.List;

import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.plugins.DeviceProvider;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.util.VarUtils;

/**
 * The INPUT# command.
 */
public class InputFile extends Input {

	/** The file number. */
	private Atom fileNumber = null;

	/**
	 * Instantiates a new input file.
	 */
	public InputFile() {
		super("INPUT#");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.Input#parse(java.lang.String, int, int,
	 * int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		linePart = linePart.substring(this.name.length());
		int pos = linePart.indexOf(',');
		if (pos == -1) {
			pos = linePart.length();
		}
		term = Parser.getTerm(linePart.substring(0, pos), machine, false, true);
		linePart = pos != linePart.length() ? linePart.substring(pos + 1) : "";
		List<Atom> pars = Parser.getParameters(term);
		if (pars.size() != 1) {
			throw new RuntimeException("Syntax error: " + this);
		}
		fileNumber = pars.get(0);
		if (fileNumber.getType().equals(Type.STRING)) {
			throw new RuntimeException("Type mismatch error: " + this);
		}
		super.parse("INPUT" + linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		if (comment != null && !comment.isEmpty()) {
			throw new RuntimeException("Syntax error: " + this);
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.Input#execute(sixtyfour.system.Machine)
	 */
	@Override
	public BasicProgramCounter execute(Machine machine) {
		int fn = VarUtils.getInt(fileNumber.eval(machine));
		DeviceProvider device = machine.getDeviceProvider();
		for (int i = 0; i < vars.size(); i++) {
			Term indexTerm = indexTerms.get(i);
			Variable var = this.getVariable(machine, i);
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
						var.setValue(device.inputString(fn), pis);
					} else if (varType.equals(Type.REAL)) {
						var.setValue(device.inputNumber(fn), pis);
					} else if (varType.equals(Type.INTEGER)) {
						var.setValue(device.inputNumber(fn).intValue(), pis);
					}
				} catch (Exception nfe) {
					throw new RuntimeException("Bad data error: " + this);
				}
			} else {
				// no array
				if (varType.equals(Type.STRING)) {
					var.setValue(device.inputString(fn));
				} else {
					if (varType.equals(Type.INTEGER)) {
						try {
							Integer num = device.inputNumber(fn).intValue();
							var.setValue(num);
						} catch (Exception nfe) {
							throw new RuntimeException("Bad data error: " + this);
						}
					} else {
						try {
							Float num = device.inputNumber(fn);
							var.setValue(num);
						} catch (Exception nfe) {
							throw new RuntimeException("Bad data error: " + this);
						}
					}
				}
			}
		}
		return null;
	}
}
