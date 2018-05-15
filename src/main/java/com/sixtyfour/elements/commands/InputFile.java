package com.sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.plugins.DeviceProvider;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.CompilerConfig;
import com.sixtyfour.system.Machine;
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
	public String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		linePart = linePart.substring(this.name.length());
		int pos = linePart.indexOf(',');
		if (pos == -1) {
			pos = linePart.length();
		}
		term = Parser.getTerm(config, linePart.substring(0, pos), machine, false, true);
		linePart = pos != linePart.length() ? linePart.substring(pos + 1) : "";
		List<Atom> pars = Parser.getParameters(term);
		if (pars.size() != 1) {
			syntaxError(this);
		}
		fileNumber = pars.get(0);
		checkTypes(pars, linePart, Type.STRING);
		super.parse(config, "INPUT" + linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		if (comment != null && !comment.isEmpty()) {
			syntaxError(this);
		}
		return null;
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		NativeCompiler compiler = NativeCompiler.getCompiler();
		List<String> after = new ArrayList<String>();
		List<String> expr = null;
		List<String> before = new ArrayList<String>();

		expr = compiler.compileToPseudoCode(config, machine, fileNumber);

		CodeContainer cc = new CodeContainer(before, expr, after);
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();
		ccs.add(cc);
		ccs.addAll(this.evalToCodeFile(config, machine, "INPUTSTRCHANNEL", "INPUTNUMBERCHANNEL"));
		return ccs;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.Input#execute(sixtyfour.system.Machine)
	 */
	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
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
