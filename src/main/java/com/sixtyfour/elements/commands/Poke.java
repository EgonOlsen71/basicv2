package com.sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.config.CompilerConfig;
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
 * The POKE command.
 */
public class Poke extends AbstractCommand {

	protected Atom addr = null;
	protected Atom val = null;

	/**
	 * Instantiates a new poke.
	 */
	public Poke() {
		super("POKE");
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
		List <Atom> pars = Parser.getParameters(term);

		if (pars.size() != 2) {
			syntaxError(this);
		}

		checkTypes(pars, linePart, Type.STRING, Type.STRING);

		addr = pars.get(0);
		val = pars.get(1);
		
		if (val instanceof Variable) {
			val=new Term(val);
		}
		if (addr instanceof Variable) {
			addr=new Term(addr);
		}

		return null;
	}

	@Override
	public List<Term> getAllTerms() {
		List<Term> ret = new ArrayList<Term>();
		if (addr.isTerm()) {
			ret.add((Term) addr);
		} 
		
		if (val.isTerm()) {
			ret.add((Term) val);
		} 
		return ret;
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
		int vally = VarUtils.getInt(val.eval(machine));
		if (vally < 0 || vally > 255 || memAddr < 0 || memAddr > 65535) {
			throw new RuntimeException("Illegal quantity error: " + this + "/" + vally + "/" + memAddr);
		}

		machine.getRam()[memAddr] = vally;
		machine.getMemoryListener().poke(memAddr, vally);
		return null;
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		NativeCompiler compiler = NativeCompiler.getCompiler();
		List<String> after = new ArrayList<String>();
		List<String> expr = compiler.compileToPseudoCode(config, machine, val);
		List<String> before = null;

		String expPush = getPushRegister(expr.get(expr.size() - 1));
		expr = expr.subList(0, expr.size() - 1);

		if (addr.isConstant()) {
			if (expPush.equals("Y")) {
				expr.add("MOV X,Y");
			}
			after.add("MOVB " + ((Number) addr.eval(machine)).intValue() + ",X");
		} else {
			before = compiler.compileToPseudoCode(config, machine, addr);

			if (expPush.equals("Y")) {
				expr.add("MOV X,Y");
			}
			after.add("POP Y");
			after.add("MOVB (Y),X");
		}

		CodeContainer cc = new CodeContainer(before, expr, after);
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();
		ccs.add(cc);
		return ccs;
	}
}
