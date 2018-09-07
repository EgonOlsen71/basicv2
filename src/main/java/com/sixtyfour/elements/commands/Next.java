/*
 * 
 */
package com.sixtyfour.elements.commands;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.util.VarUtils;

/**
 * The NEXT command.
 */
public class Next extends AbstractCommand {

	/** The var name. */
	private String varName = null;

	/** The pc. */
	private BasicProgramCounter pc = new BasicProgramCounter(0, 0); // Recycle
																	// instance

	/**
	 * Instantiates a new next.
	 */
	public Next() {
		super("NEXT");
	}

	/**
	 * Gets the variables name.
	 * 
	 * @return the variables name
	 */
	public String getVarName() {
		return varName;
	}

	/**
	 * Sets the variables name.
	 * 
	 * @param varName
	 *            the new variables name
	 */
	public void setVarName(String varName) {
		this.varName = varName;
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
		linePart = VarUtils.toUpper(linePart.substring(4)).trim();

		String ret = null;
		String[] vars = linePart.split(",");

		// Handle the i,j,k...case by returning an artifical, new command that
		// includes only j,k...
		if (vars.length > 1) {
			linePart = vars[0];
			ret = "NEXT";
			for (int i = 1; i < vars.length; i++) {
				if (i > 1) {
					ret += ",";
				}
				ret += vars[i];
			}
		}
		varName = Parser.getVariableName(linePart);
		if (varName != null && varName.length() == 0) {
			varName = null;
		}
		return ret;
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
		For myFor = machine.peekFor(this.varName);
		if (myFor == null) {
			throw new RuntimeException("NEXT without FOR error ("+varName+"): " + this);
		}
		boolean iterate = myFor.next(this, machine);
		if (iterate) {
			pc.setLineCnt(myFor.lineCnt);
			pc.setLinePos(myFor.linePos);
			return pc;
		}
		return null;
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		// NativeCompiler compiler = NativeCompiler.getCompiler();
		List<String> after = new ArrayList<String>();
		List<String> expr = new ArrayList<String>();
		List<String> before = null;

		if (varName == null) {
			after.add("MOV A,#0{INTEGER}");
		} else {
			after.add("MOV A,(" + varName + "{})");
		}
		after.add("JSR NEXT");
		after.add("CMP A,#0{INTEGER}");
		after.add("JE ($JUMP)");

		CodeContainer cc = new CodeContainer(before, expr, after);
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();
		ccs.add(cc);
		return ccs;
	}

}
