package com.sixtyfour.extensions.x16.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.commands.AbstractCommand;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;

/**
 * The CHAR command.
 */
public class Char extends AbstractCommand {

	/** The pars. */
	private List<Atom> pars;

	/**
	 * Instantiates a new wait.
	 */
	public Char() {
		super("CHAR");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String, int,
	 * int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos,
			boolean lastPos, Machine machine) {
		super.parse(config, linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		term = Parser.getTerm(config, this, linePart, machine, true);
		pars = Parser.getParameters(term);

		if (pars.size() !=4) {
			syntaxError(linePart);
		}

		checkTypes(pars, linePart, Type.STRING, Type.STRING, Type.STRING, Type.REAL);
		return null;
	}


	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		Atom xc = pars.get(0);
		Atom yc = pars.get(1);
		Atom col = pars.get(2);
		Atom txt = pars.get(3);
		NativeCompiler compiler = NativeCompiler.getCompiler();
		List<String> before = new ArrayList<String>();
		List<String> after = new ArrayList<String>();
		List<String> expr = new ArrayList<String>();

		expr.addAll(compiler.compileToPseudoCode(config, machine, txt));
		expr.addAll(compiler.compileToPseudoCode(config, machine, xc));
		expr.addAll(compiler.compileToPseudoCode(config, machine, yc));
		expr.addAll(compiler.compileToPseudoCode(config, machine, col));
		after.add("POP C");
		after.add("POP Y");
		after.add("POP X");
		after.add("POP B");
		after.add("JSR PRINTCHAR");

		CodeContainer cc = new CodeContainer(before, expr, after);
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();
		ccs.add(cc);
		return ccs;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
	    Logger.log("Call to CHAR ignored by local runtime!");
		return null;
	}
}
