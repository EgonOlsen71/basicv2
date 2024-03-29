package com.sixtyfour.extensions.x16.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.commands.AbstractCommand;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * @author EgonOlsen
 *
 */
public class Vpoke extends AbstractCommand {

	protected Atom addr = null;
	protected Atom val = null;
	private Atom bank = null;

	/**
	 * 
	 */
	public Vpoke() {
		super("VPOKE");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.commands.Poke#parse(com.sixtyfour.config.
	 * CompilerConfig, java.lang.String, int, int, int, boolean,
	 * com.sixtyfour.system.Machine)
	 */
	@Override
	public String parse(CompilerConfig config, String linePart, int lineCnt, int lineNumber, int linePos,
			boolean lastPos, Machine machine) {
		super.parse(config, linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		term = Parser.getTerm(config, this, linePart, machine, true);
		List<Atom> pars = Parser.getParameters(term);

		if (pars.size() != 3) {
			syntaxError(this);
		}

		checkTypes(pars, linePart, Type.STRING, Type.STRING, Type.STRING);

		bank = pars.get(0);
		addr = pars.get(1);
		val = pars.get(2);

		if (val instanceof Variable) {
			val = new Term(val);
		}
		if (bank instanceof Variable) {
			bank = new Term(bank);
		}
		if (addr instanceof Variable) {
			addr = new Term(addr);
		}

		return null;
	}

	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
		// This does nothing with the bank's value...
		int memAddr = VarUtils.getInt(addr.eval(machine));
		int vally = VarUtils.getInt(val.eval(machine));
		if (vally < 0 || vally > 255 || memAddr < 0 || memAddr > 65535) {
			throw new RuntimeException("Illegal quantity error: " + this + "/" + vally + "/" + memAddr);
		}

		machine.getRam()[memAddr] = vally;
		machine.getMemoryListener().poke(memAddr, vally);
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.commands.Poke#getAllTerms()
	 */
	@Override
	public List<Term> getAllTerms() {
		List<Term> ret = new ArrayList<Term>();

		if (addr.isTerm()) {
			ret.add((Term) addr);
		}

		if (val.isTerm()) {
			ret.add((Term) val);
		}

		if (bank.isTerm()) {
			ret.add((Term) bank);
		}

		return ret;
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		NativeCompiler compiler = NativeCompiler.getCompiler();
		List<String> after = new ArrayList<>();

		List<String> expr = new ArrayList<>();
		String expPush = "";
		int valConst = -1;
		boolean cValFlag = false;

		if (val.isConstant()) {
			valConst = ((Number) val.eval(machine)).intValue();
			valConst = valConst & 255;
			cValFlag = true;
		} else {
			expr = compiler.compileToPseudoCode(config, machine, val);
			expPush = getPushRegister(expr.get(expr.size() - 1));
			expr = expr.subList(0, expr.size() - 1);
		}

		List<String> before = new ArrayList<>();
		List<String> bankSwitch = compiler.compileToPseudoCode(config, machine, bank);

		String bankPush = getPushRegister(bankSwitch.get(bankSwitch.size() - 1));
		bankSwitch = bankSwitch.subList(0, bankSwitch.size() - 1);

		if (addr.isConstant()) {
			if (expPush.equals("Y")) {
				expr.add("MOV X,Y");
			}
			int addi = ((Number) addr.eval(machine)).intValue();
			int lo = addi & 255;
			int hi = addi >> 8;
			after.add("MOVB VERALO,#" + lo + "{INTEGER}");
			after.add("MOVB VERAMID,#" + hi + "{INTEGER}");
			if (cValFlag) {
				after.add("MOVB VERADAT,#" + valConst + "{INTEGER}");
			} else {
				after.add("MOVB VERADAT,X");
			}
		} else {
			before = compiler.compileToPseudoCode(config, machine, addr);

			if (expPush.equals("Y")) {
				expr.add("MOV X,Y");
			}
			after.add("POP Y");
			after.add("MOVB VERALO:VERAMID,Y");
			if (cValFlag) {
				after.add("MOVB VERADAT,#" + valConst + "{INTEGER}");
			} else {
				after.add("MOVB VERADAT,X");
			}
		}

		addBankSwitchingCode(machine, before, after, bankSwitch, bankPush);
		CodeContainer cc = new CodeContainer(before, expr, after);
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();
		ccs.add(cc);
		return ccs;
	}

	/**
	 * 
	 * @param machine
	 * @param before
	 * @param after
	 * @param bankSwitch
	 * @param bankPush
	 */
	private void addBankSwitchingCode(Machine machine, List<String> before, List<String> after, List<String> bankSwitch,
			String bankPush) {
		if (bank.isConstant()) {
			before.add("MOVB VERAHI,#" + ((Number) bank.eval(machine)).intValue() + "{INTEGER}");
		} else {
			if (bankPush.equals("Y")) {
				bankSwitch.add("MOV X,Y");
			}
			bankSwitch.add("MOVB VERAHI,X");
			before.addAll(0, bankSwitch);
		}
	}

}
