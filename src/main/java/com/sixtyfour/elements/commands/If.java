package com.sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.TermEnhancer;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The IF command.
 */
public class If extends AbstractCommand {

	private static boolean compatibleConditionalBranches = true;
	private static int ifCount = 0;
	/** The logic term. */
	private Term logicTerm = null;

	/** The pc. */
	private BasicProgramCounter pc = new BasicProgramCounter(0, 0);

	private String conditionalTerm = null;

	/**
	 * Instantiates a new if.
	 */
	public If() {
		super("IF");
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
		linePart = TermEnhancer.removeWhiteSpace(linePart);

		String uPart = Parser.replaceStrings(linePart, '.');
		int tp = uPart.indexOf("THEN");
		int gp = uPart.indexOf("GOTO");
		if (tp == -1 && gp == -1) {
			throw new RuntimeException("Conditional block missing: " + this);
		}
		int termEnd = 99999999;
		boolean isGoto = false;
		if (tp != -1) {
			termEnd = tp;
		}
		if (gp != -1 && gp < termEnd) {
			termEnd = gp;
			isGoto = true;
		}

		conditionalTerm = linePart.substring(2, termEnd);
		logicTerm = Parser.getTerm(config, conditionalTerm, machine, false, true);

		if (isGoto) {
			return linePart.substring(termEnd);
		}

		String restTerm = linePart.substring(termEnd + 4);
		if (Parser.isInteger(restTerm)) {
			return "GOTO" + restTerm;
		}

		return restTerm;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.commands.Command#getAllTerms()
	 */
	@Override
	public List<Term> getAllTerms() {
		List<Term> ret = new ArrayList<Term>();
		ret.add(logicTerm);
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
		pc.setSkip(false);
		boolean ok = evalToBoolean(machine, logicTerm);
		if (ok) {
			return null;
		}
		pc.setSkip(true);
		return pc;
	}

	private boolean evalToBoolean(Machine machine, Term term) {
		Object res = logicTerm.eval(machine);
		if (VarUtils.isNumber(res)) {
			double ret = VarUtils.getDouble(res);
			return ret != 0;
		}
		return false;
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {

		NativeCompiler compiler = NativeCompiler.getCompiler();
		List<String> after = new ArrayList<String>();
		Term cTerm = Parser.getTerm(config, conditionalTerm, machine, false, true);

		int ic = ifCount++;
		String label = "SKIP" + ic;

		List<String> expr = compiler.compileToPseudoCode(config, machine, cTerm);
		List<String> before = null;

		String expPush = getPushRegister(expr.get(expr.size() - 1));
		expr = expr.subList(0, expr.size() - 1); // Remove trailing PUSH X/PUSH_A

		expPush = handleNoOpStrings(after, expPush);

		if (!compatibleConditionalBranches) {
			// This combination might not work on a 6502 cpu, because the
			// conditional branch target has to be within +-127/8 bytes
			after.add("CMP " + expPush + ",#0{REAL}");
			after.add("JE " + label);
			after.add(label + ":");
		} else {
			// ...but this version will work. It's slower though.
			after.add("CMP " + expPush + ",#0{REAL}");
			after.add("JNE N" + label);
			after.add("JMP " + label);
			after.add("N" + label + ":");
			after.add(label + ":");
		}
		CodeContainer cc = new CodeContainer(before, expr, after);
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();
		ccs.add(cc);
		return ccs;
	}

	public Term getLogicTerm() {
		return logicTerm;
	}

	@Override
	public boolean isConditional() {
		return true;
	}

	private String handleNoOpStrings(List<String> after, String expPush) {
		// Handle IF A$ THEN and other string "comparisons" of that kind
		// properly...quite hacky, but anyway...

		// Looks like as if the comparison is supposed to happen to a pointer register.
		// That makes no sense,
		// so it's obviously a pointer to a string (what else could it be?). We "wrap"
		// that into a LEN call
		// and compare with X instead to fix this.
		// It would be better to catch this on a higher level, but...well...who cares...
		if (expPush.equals("B") || expPush.equals("A")) {
			if (expPush.equals("A")) {
				after.add("MOV B,A");
			}
			after.add("CHGCTX #0");
			after.add("JSR LEN");
			expPush = "X";
		}
		return expPush;
	}
}
