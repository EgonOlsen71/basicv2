package com.sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The WAIT command.
 */
public class Wait extends AbstractCommand {

	private static int waitCount = 0;

	/** The stop. */
	private boolean stop = false;

	/**
	 * Instantiates a new wait.
	 */
	public Wait() {
		super("WAIT");
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
		List<Atom> pars = Parser.getParameters(term);

		if (pars.size() < 2 || pars.size() > 3) {
			syntaxError(linePart);
		}

		checkTypes(pars, linePart, Type.STRING, Type.STRING, Type.STRING);
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#stopExecution()
	 */
	@Override
	public void stopExecution() {
		stop = true;
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		List<Atom> pars = Parser.getParameters(term);
		pars = Parser.getParameters(term);
		Atom addr = pars.get(0);
		Atom waitFor = pars.get(1);

		// System.out.println("Tröt: "+addr+"/"+waitFor);

		NativeCompiler compiler = NativeCompiler.getCompiler();
		List<String> after = new ArrayList<String>();
		List<String> expr = new ArrayList<String>();

		int wc = waitCount++;
		String label = "WAIT" + wc;

		boolean invertFound = false;
		if (pars.size() == 3) {
			invertFound = true;
			Atom inverted = pars.get(2);
			expr.addAll(compiler.compileToPseudoCode(config, machine, inverted));
		}

		expr.addAll(compiler.compileToPseudoCode(config, machine, waitFor));
		List<String> before = null;

		String expPush = getPushRegister(expr.get(expr.size() - 1));
		expr = expr.subList(0, expr.size() - 1);

		before = compiler.compileToPseudoCode(config, machine, addr);

		if (expPush.equals("Y")) {
			expr.add("MOV X,Y");
		}
		if (invertFound) {
			after.add("POP C");
		}
		after.add("POP Y");
		after.add(label + ":");
		after.add("MOV D,(Y)");
		if (invertFound) {
			after.add("XOR D,C");
		}
		after.add("AND D,X");
		after.add("CMP D,#0{INTEGER}");
		after.add("JE " + label);

		CodeContainer cc = new CodeContainer(before, expr, after);
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();
		ccs.add(cc);
		return ccs;
	}

	/*
	 * @Override public List<Term> getAllTerms() { List<Term> ret = new
	 * ArrayList<Term>(); for (Atom par : pars) { if (par.isTerm()) { ret.add((Term)
	 * par); } else if (par instanceof Variable) { ret.add(new Term(par)); } }
	 * ret.add(term); return ret; }
	 */

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
		List<Atom> pars = Parser.getParameters(term);
		Atom addr = pars.get(0);
		Atom waitFor = pars.get(1);
		int memAddr = VarUtils.getInt(addr.eval(machine));
		int vally = VarUtils.getInt(waitFor.eval(machine));
		if (vally < 0 || vally > 255 || memAddr < 0 || memAddr > 65535) {
			throw new RuntimeException("Illegal quantity error: " + this);
		}

		int invert = 0;
		boolean invertFound = false;
		if (pars.size() == 3) {
			invertFound = true;
			Atom inverted = pars.get(2);
			invert = VarUtils.getInt(inverted.eval(machine));
			if (invert < 0 || invert > 255) {
				throw new RuntimeException("Illegal quantity error: " + this);
			}
		}

		if (!invertFound && memAddr == 6502 && vally == 1) {
			machine.getOutputChannel().systemPrintln(0, "EgonOlsen!");
		}

		while (machine.getMemoryListener().wait(memAddr, vally, invert) && !stop) {
			Thread.yield();
		}
		stop = false;

		return null;

	}
}
