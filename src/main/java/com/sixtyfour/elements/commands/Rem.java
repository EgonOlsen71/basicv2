package com.sixtyfour.elements.commands;

import com.sixtyfour.Logger;
import com.sixtyfour.system.Machine;

import java.util.List;
import java.util.Locale;

import com.sixtyfour.cbmnative.Util;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.parser.assembly.InlineAssembler;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.BasicProgramCounter;

/**
 * The REM command.
 */
public class Rem extends AbstractCommand {

	/** The Constant REM_MARKER. */
	public final static String REM_MARKER = "###";
	
	public String asmCode = null;

	/**
	 * Instantiates a new rem.
	 */
	public Rem() {
		super("REM");
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
		if (config.isInlineAssembly() && linePart.length()>3) {
			String part = linePart.substring(3);
			if (part.startsWith("[") && part.endsWith("]")) {
				asmCode = part.substring(1, part.length()-1);
				InlineAssembler.trackVariables(config, asmCode, machine);
			}
		}

		if (linePart.length()>3 && linePart.contains("@")) {
			String directive = linePart.substring(3).replace("@","").trim().toUpperCase(Locale.ENGLISH);
			if (directive.contains("INTEGER")) {
				directive = directive.substring(directive.indexOf("INTEGER")+7).trim();
				String[] parts = directive.split(",");
				for (String part : parts) {
					part = part.trim().toUpperCase(Locale.ENGLISH);
					machine.addForcedInteger(part);
					Logger.log(part+ " forced to integer via REM...");
				}
			} else {
				Logger.log("Ignoring unknown directive: "+directive);
			}
		}
		
		return REM_MARKER;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.AbstractCommand#execute(sixtyfour.system.
	 * Machine)
	 */
	@Override
	public BasicProgramCounter execute(CompilerConfig config, Machine machine) {
		return null;
	}

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		if (asmCode==null) {
			return Util.createSingleCommand("NOP");
		} else {
			return Util.createSingleCommand("REM "+asmCode);
		}
	}
}
