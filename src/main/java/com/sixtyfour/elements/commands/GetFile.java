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
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The GET# command.
 */
public class GetFile extends Get {

	/** The file number. */
	private Atom fileNumber = null;

	/**
	 * Instantiates a new gets the file.
	 */
	public GetFile() {
		super("GET#");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.Get#parse(java.lang.String, int, int,
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
			syntaxError(this);
		}
		fileNumber = pars.get(0);
		checkTypes(pars, linePart, Type.STRING);
		super.parse("GET" + linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		return null;
	}

	@Override
	public List<CodeContainer> evalToCode(Machine machine) {
		NativeCompiler compiler = NativeCompiler.getCompiler();
		List<String> after = new ArrayList<String>();
		List<String> expr = null;
		List<String> before = new ArrayList<String>();

		expr = compiler.compileToPseudoCode(machine, fileNumber);

		CodeContainer cc = new CodeContainer(before, expr, after);
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();
		ccs.add(cc);
		ccs.addAll(this.evalToCodeFile(machine, "GETSTRCHANNEL", "GETNUMBERCHANNEL"));
		return ccs;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.Get#execute(sixtyfour.system.Machine)
	 */
	@Override
	public BasicProgramCounter execute(Machine machine) {
		for (int i = 0; i < vars.size(); i++) {
			Term indexTerm = indexTerms.get(i);
			Variable var = this.getVariable(machine, i);
			Character input = machine.getDeviceProvider().getChar(VarUtils.getInt(fileNumber.eval(machine)));
			if (input == 0) {
				input = ' ';
			}
			if (indexTerm != null) {
				List<Atom> pars = Parser.getParameters(indexTerm);
				int[] pis = new int[pars.size()];
				int cnt = 0;
				for (Atom par : pars) {
					pis[cnt++] = VarUtils.getInt(par.eval(machine));
				}
				if (var.getType().equals(Type.STRING)) {
					var.setValue(input.toString(), pis);
				} else {
					input = ensureNumberKey(machine, input, false);
					var.setValue(input.toString(), pis);
				}
			} else {
				if (var.getType().equals(Type.STRING)) {
					var.setValue(input.toString());
				} else {
					input = ensureNumberKey(machine, input, false);
					var.setValue(input.toString());
				}
			}
		}
		machine.getOutputChannel().setPrintConsumer(null, 0);
		return null;
	}
}
