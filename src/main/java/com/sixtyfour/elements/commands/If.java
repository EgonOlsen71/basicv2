package com.sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.cbmnative.NativeCompiler;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.parser.logic.LogicParser;
import com.sixtyfour.parser.logic.LogicTerm;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;

/**
 * The IF command.
 */
public class If extends AbstractCommand {

	private static boolean compatibleConditionalBranches = true;
	private static int ifCount = 0;
	/** The logic term. */
	private LogicTerm logicTerm = null;

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
	 * @see sixtyfour.elements.commands.AbstractCommand#parse(java.lang.String,
	 * int, int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		super.parse(linePart, lineCnt, lineNumber, linePos, lastPos, machine);
		linePart = Parser.removeWhiteSpace(linePart);

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
		String firstTerm = linePart.substring(2, termEnd);
		conditionalTerm = firstTerm;

		logicTerm = LogicParser.getTerm(firstTerm, machine);

		// System.out.println("Logic term: "+logicTerm+"/"+logicTerm.getFirstOperation()+"/"+Parser.replaceLogicOperators(firstTerm));

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
	 * @see
	 * sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public BasicProgramCounter execute(Machine machine) {
		pc.setSkip(false);
		boolean ok = logicTerm.evalToBoolean(machine);
		if (ok) {
			return null;
		}
		pc.setSkip(true);
		return pc;
	}

	@Override
	public List<CodeContainer> evalToCode(Machine machine) {
		NativeCompiler compiler = NativeCompiler.getCompiler();
		List<String> after = new ArrayList<String>();
		// System.out.println(conditionalTerm+"    /    "+Parser.getTerm(conditionalTerm,
		// machine, false, true));
		List<String> expr = compiler.compileToPseudoCode(machine, Parser.getTerm(conditionalTerm, machine, false, true));
		List<String> before = null;

		String expPush = getPushRegister(expr.get(expr.size() - 1));
		expr = expr.subList(0, expr.size() - 1); // Remove trailing PUSH
													// X/PUSH_A
		int ic = ifCount++;
		String label = "SKIP" + ic;

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

	@Override
	public boolean isConditional() {
		return true;
	}
}
