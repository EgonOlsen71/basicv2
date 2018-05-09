package com.sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The PRINT# command.
 */
public class PrintFile extends Print {

	/** The file number. */
	private Atom fileNumber = null;

	/**
	 */
	public PrintFile() {
		super("PRINT#");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.Print#parse(java.lang.String, int, int,
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
		super.parse("PRINT" + linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		return null;
	}

	@Override
	public List<CodeContainer> evalToCode(Machine machine) {
		NativeCompiler compiler = NativeCompiler.getCompiler();
		List<String> after = new ArrayList<String>();
		List<String> expr = null;
		List<String> before = new ArrayList<String>();

		expr = compiler.compileToPseudoCode(machine, fileNumber);

		String expPush = expr.get(expr.size() - 1);
		expr = expr.subList(0, expr.size() - 1);
		expPush=expPush.replace("X", "G").replace("Y", "G");
		expr.add(expPush);

		CodeContainer cc = new CodeContainer(before, expr, after);
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();
		ccs.add(cc);
		ccs.addAll(this.evalToCode(machine, "CHANNEL"));
		return ccs;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.Print#execute(sixtyfour.system.Machine)
	 */
	@Override
	public BasicProgramCounter execute(Machine machine) {
		int fn = VarUtils.getInt(fileNumber.eval(machine));
		return execute(machine, machine.getDeviceProvider(), fn);
	}

}
