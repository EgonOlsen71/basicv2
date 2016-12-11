package com.sixtyfour.elements.commands;

import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.util.VarUtils;

/**
 * The DEF command.
 */
public class Def extends AbstractCommand {

	/** The var name. */
	private String varName = null;

	/** The fn name. */
	private String fnName = null;

	/**
	 * Instantiates a new def.
	 */
	public Def() {
		super("DEF");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#getType()
	 */
	@Override
	public Type getType() {
		return term.getType();
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
		linePart = Parser.removeWhiteSpace(linePart);
		int pos = linePart.indexOf('(');
		int pos2 = linePart.indexOf(')');
		if (pos == -1 || pos2 == -1 || pos > pos2) {
			throw new RuntimeException("Syntax error: " + this);
		}
		fnName = VarUtils.toUpper(linePart.substring(3, pos));
		if (!fnName.startsWith("FN")) {
			throw new RuntimeException("Syntax error: " + this);
		}
		fnName = fnName.substring(2);
		if (fnName.length() > 2) {
			fnName = fnName.substring(0, 2);
		}
		varName = VarUtils.toUpper(linePart.substring(pos + 1, pos2));
		if (varName.length() == 0) {
			throw new RuntimeException("Syntax error: " + this);
		}
		if (linePart.length() < pos2 + 2 && linePart.charAt(pos2 + 1) != '=') {
			throw new RuntimeException("Syntax error: " + this);
		}
		String term = linePart.substring(pos2 + 2);

		StringBuilder sb = new StringBuilder();
		boolean inString = false;
		term = term + " ";
		String modTerm = VarUtils.toUpper(term).replace("OR", "##").replace("AND", "###").replace("NOT", "###");
		for (int i = 0; i < modTerm.length(); i++) {
			char c = modTerm.charAt(i);
			if (c == '"') {
				inString = !inString;
			}
			if (!inString) {
				if (Character.isAlphabetic(c) || Character.isDigit(c)) {
					sb.append(c);
				} else {
					String tmp = VarUtils.toUpper(sb.toString());
					if (tmp.equals(varName)) {
						String add = "_" + varName + fnName;
						term = term.substring(0, i - varName.length()) + add + term.substring(i);
						modTerm = modTerm.substring(0, i - varName.length()) + add + modTerm.substring(i);
						i += add.length();
					}
					sb.setLength(0);
				}
			}
		}

		varName = "_" + varName + fnName;
		// System.out.println("New DEF-Term: " + term + " - " + fnName + " - " +
		// varName);
		this.term = Parser.getTerm(term, machine, false, true, null);
		machine.add(new Variable(varName, 0f));
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * sixtyfour.elements.commands.AbstractCommand#eval(sixtyfour.system.Machine
	 * )
	 */
	@Override
	public Object eval(Machine machine) {
		return term.eval(machine);
	}

	/**
	 * Gets the var name.
	 * 
	 * @return the var name
	 */
	public String getVarName() {
		return varName;
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
		machine.setFunction(fnName, this);
		return null;
	}
}
