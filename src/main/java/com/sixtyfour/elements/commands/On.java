package com.sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The ON command.
 */
public class On extends AbstractCommand {

	private static int onCount = 0;

	/** The pc. */
	private BasicProgramCounter pc = new BasicProgramCounter(0, 0); // Recycle
																	// instance

	public List<Integer> getLineNumbers() {
		return lineNumbers;
	}

	/** The line numbers. */
	private List<Integer> lineNumbers = new ArrayList<Integer>();

	/** The gosub. */
	private boolean gosub = false;

	/**
	 * Instantiates a new on.
	 */
	public On() {
		super("ON");
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
		linePart = linePart.substring(2).trim();
		String uPart = VarUtils.toUpper(linePart);
		int pos = uPart.lastIndexOf("GO");
		if (pos == -1) {
			syntaxError(this);
		}
		term = Parser.getTerm(config, linePart.substring(0, pos), machine, false, true);

		if (term.getType().equals(Type.STRING)) {
			typeMismatch(linePart);
		}

		gosub = uPart.indexOf("GOSUB") != -1;

		int numPos = -1;
		String lines = linePart.substring(pos);
		for (int i = 0; i < lines.length(); i++) {
			char c = lines.charAt(i);
			if (Character.isDigit(c)) {
				numPos = i;
				break;
			}
		}
		if (numPos == -1) {
			syntaxError(this);
		}
		String[] parts = lines.substring(numPos).split(",");
		for (String part : parts) {
			try {
				if (part.length() == 0) {
					lineNumbers.add(0);
				} else {
					Integer li = Integer.valueOf(part.trim());
					lineNumbers.add(li);
				}
			} catch (Exception e) {
				syntaxError(this);
			}
		}
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
		int index = VarUtils.getInt(term.eval(machine));
		if (index <= 0 || index > lineNumbers.size()) {
			return null;
		}
		pc.setLineNumber(lineNumbers.get(index - 1));
		if (gosub) {
			machine.push(this);
		}
		return pc;
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		NativeCompiler compiler = NativeCompiler.getCompiler();
		List<String> after = new ArrayList<String>();
		List<String> expr = compiler.compileToPseudoCode(config, machine, term);
		List<String> before = null;

		String expPush = getPushRegister(expr.get(expr.size() - 1));
		expr = expr.subList(0, expr.size() - 1);

		int oc = onCount++;

		String label = "SKIPON" + oc;

		after.add("INT " + expPush + "," + expPush);
		for (int i = 0; i < lineNumbers.size(); i++) {
			after.add("ON" + oc + "SUB" + i + ":");
			after.add("CMP " + expPush + ",#" + (i + 1) + "{INTEGER}");
			if (this.gosub) {
				after.add("JNE " + ((i == lineNumbers.size() - 1) ? label : ("ON" + oc + "SUB" + (i + 1))));
				after.add("JSR GOSUB");
				after.add("JSR " + lineNumbers.get(i));
				after.add("JMP " + label);
			} else {
				String al = "AFTER" + oc + "SUB" + i;
				after.add("JNE " + al);
				after.add("JMP " + lineNumbers.get(i));
				after.add(al + ":");
			}
		}
		after.add(label + ":");

		CodeContainer cc = new CodeContainer(before, expr, after);
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();
		ccs.add(cc);
		return ccs;
	}

}
