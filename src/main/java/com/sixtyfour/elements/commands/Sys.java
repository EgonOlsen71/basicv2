package com.sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.cbmnative.Util;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.util.VarUtils;

/**
 * The SYS command.
 */
public class Sys extends AbstractCommand {

	/** The pars. */
	private List<Atom> pars;
	private Atom addr;
	private List<Atom> vals;

	/**
	 * Instantiates a new sys.
	 */
	public Sys() {
		super("SYS");
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

		if (pars.isEmpty()) {
			syntaxError(linePart);
		}

		checkTypes(pars, linePart, Type.STRING);
		addr = pars.get(0);
		vals = pars.subList(1, pars.size());
		return null;
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		if (pars.size() > 1) {
			return createMultiParsCall(config, machine);
		}
		if (addr.isConstant()) {
			// Shortcut for SYS XXXX, which should be the majority of calls
			int memAddr = VarUtils.getInt(addr.eval(machine));
			if (memAddr < 0 || memAddr > 65535) {
				throw new RuntimeException("Illegal quantity error: " + this);
			}
			return Util.createSingleCommand("JSR $" + Integer.toHexString(memAddr));
		} else {
			// SYS dynamic...
			return createSingleParameterCall(config, machine, pars, "SYSTEMCALLDYN");
		}
	}

	@Override
	protected List<String> addSingleParameter(CompilerConfig config, Machine machine, NativeCompiler compiler,
			List<Atom> pars) {
		List<String> expr = compiler.compileToPseudoCode(config, machine, pars.get(0));
		String expPush = getPushRegister(expr.get(expr.size() - 1));
		expr = expr.subList(0, expr.size() - 1);
		if (expPush.equals("Y")) {
			expr.add("MOV X,Y");
		} else if (expPush.equals("A")) {
			expr.add("MOV B,A");
		}
		return expr;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
		int memAddr = VarUtils.getInt(addr.eval(machine));
		if (memAddr < 0 || memAddr > 65535) {
			throw new RuntimeException("Illegal quantity error: " + this);
		}
		Object[] params = null;
		if (!vals.isEmpty()) {
			params = new Object[vals.size()];
			int cnt = 0;
			for (Atom val : vals) {
				params[cnt++] = val.eval(machine);
			}
		}
		machine.getSystemCallListener().sys(memAddr, params);

		return null;
	}
	
	private List<CodeContainer> createMultiParsCall(CompilerConfig config, Machine machine) {
		NativeCompiler compiler = NativeCompiler.getCompiler();
		List<String> after = new ArrayList<String>();
		List<String> expr = new ArrayList<String>();
		List<String> before = new ArrayList<String>();
		before.add("JSR SETUPMULTIPARS");
		for (int i = 1; i < pars.size(); i++) {
			List<Atom> par = pars.subList(i, i + 1);
			List<String> part = addSingleParameter(config, machine, compiler, par);
			if (par.get(0).getType(true) == Type.STRING) {
				// It's a STRING (in B_REG)
				part.add("JSR COPYSTRINGPAR");
			} else {
				// It's a number (in X_REG)
				part.add("JSR COPYREALPAR");
			}
			before.addAll(part);
		}
		before.add("JSR ADDCOLON");
		after.add("JSR PULLDOWNMULTIPARS");

		if (addr.isConstant()) {
			// Shortcut for SYS XXXX, which should be the majority of calls
			int memAddr = VarUtils.getInt(addr.eval(machine));
			if (memAddr < 0 || memAddr > 65535) {
				throw new RuntimeException("Illegal quantity error: " + this);
			}
			expr.add("JSR $" + Integer.toHexString(memAddr));
		} else {
			// SYS dynamic...
			expr = addSingleParameter(config, machine, compiler, pars);
			expr.add("JSR SYSTEMCALLDYN");
		}

		CodeContainer cc = new CodeContainer(before, expr, after);
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();
		ccs.add(cc);
		return ccs;
	}


}
