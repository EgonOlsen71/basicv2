package com.sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.TermEnhancer;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.util.VarUtils;

/**
 * The DEF command.
 */
public class Def extends AbstractCommand {

	private static int DEF_COUNT = 0;
	/** The var name. */
	private String varName = null;

	/** The fn name. */
	private String fnName = null;

	private int count = 0;

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
	public String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(config, linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		linePart = TermEnhancer.removeWhiteSpace(linePart);
		int pos = linePart.indexOf('(');
		int pos2 = linePart.indexOf(')');
		if (pos == -1 || pos2 == -1 || pos > pos2) {
			syntaxError(this);
		}
		fnName = VarUtils.toUpper(linePart.substring(3, pos));
		if (!fnName.startsWith("FN")) {
			syntaxError(this);
		}
		fnName = fnName.substring(2);
		if (fnName.length() > 2) {
			fnName = fnName.substring(0, 2);
		}
		varName = VarUtils.toUpper(linePart.substring(pos + 1, pos2));
		if (varName.length() == 0) {
			syntaxError(this);
		}
		if (linePart.length() < pos2 + 2 && linePart.charAt(pos2 + 1) != '=') {
			syntaxError(this);
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
				if (Character.isLetter(c) || Character.isDigit(c)) {
					sb.append(c);
				} else {
					String tmp = VarUtils.toUpper(sb.toString());
					if (tmp.equals(varName)) {
						String add = "_" + varName + fnName;
						term = term.substring(0, i - varName.length()) + add + term.substring(i);
						modTerm = modTerm.substring(0, i - varName.length()) + add + modTerm.substring(i);
						i += add.length() - 1;
					}
					sb.setLength(0);
				}
			}
		}

		varName = "_" + varName + fnName;
		// System.out.println("New DEF-Term: " + term + " - " + fnName + " - " +
		// varName);
		this.term = Parser.getTerm(config, term, machine, false, true, null);
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

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		Command cmd = machine.getFunction(fnName);
		if (cmd != null && !cmd.getTerm().toString().equals(this.getTerm().toString())) {
			throw new RuntimeException("Redef'd function error: " + fnName);
		}
		machine.setFunction(fnName, this);
		NativeCompiler compiler = NativeCompiler.getCompiler();
		List<String> after = new ArrayList<String>();
		List<String> expr = compiler.compileToPseudoCode(config, machine, term);
		List<String> before = new ArrayList<String>();

		count = DEF_COUNT++;

		String label = "DEF" + count;
		after.add("RTS");
		after.add("END" + label + ":");
		before.add("JMP END" + label);
		before.add(label + ":");
		before.add("POP X");
		before.add("MOV " + varName + "{" + term.getType() + "},X");

		CodeContainer cc = new CodeContainer(before, expr, after);
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();
		ccs.add(cc);
		return ccs;
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
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
		machine.setFunction(fnName, this);
		return null;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
}
