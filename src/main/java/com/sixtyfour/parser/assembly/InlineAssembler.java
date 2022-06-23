package com.sixtyfour.parser.assembly;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.mnemonics.Mnemonic;
import com.sixtyfour.system.Machine;

/**
 * A simple inline assembler which allows for writing assembly code directly in
 * BASIC. It has access to BASIC variables and can jump to BASIC lines as well.
 * Be aware, that you can really screw things up when interfering with the way
 * in which the compiler and its runtime work with this feature.
 * 
 * @author EgonOlsen
 *
 */
public class InlineAssembler {

	private static final String INLINE_LABEL_PREFIX = "inllbl_";

	/**
	 * Tracks usage of a BASIC variable in assembly code to prevent the optimizer
	 * from removing it, if it's not used otherwise.
	 * 
	 * @param conf
	 * @param asmCode
	 * @param machine
	 */
	public static void trackVariables(CompilerConfig conf, String asmCode, Machine machine) {
		extract(conf, asmCode, machine, true);
	}

	/**
	 * Creates the actual assembly code.
	 * 
	 * @param conf
	 * @param asmCode
	 * @param machine
	 * @param parserStage
	 * @return
	 */
	public static AssemblyLine extract(CompilerConfig conf, String asmCode, Machine machine, boolean parserStage) {
		if (asmCode.toUpperCase(Locale.ENGLISH).startsWith("REM")) {
			asmCode = asmCode.substring(3).trim();
		}
		AssemblyLine asmLine = new AssemblyLine();
		String[] lines = asmCode.split(";");
		List<String> code = new ArrayList<>();
		Set<String> vars = new HashSet<>();
		Arrays.stream(lines).forEach(p -> add(conf, code, vars, p, machine, parserStage));
		asmLine.setCode(code);
		asmLine.setVarNames(vars);
		return asmLine;
	}

	private static void add(CompilerConfig conf, List<String> code, Set<String> vars, String line, Machine machine,
			boolean parserStage) {
		if (line.length() == 3) {
			code.add(line);
		} else {
			String maybeCmd = line.substring(0, 3);
			Mnemonic mnm = AssemblyParser.getMnemonic(conf, maybeCmd);
			if (mnm != null) {
				String part = "";
				if (line.length() > 3) {
					part = line.substring(3).trim();
				}
				// Some command...
				String[] parts = split(part);
				part = parts[1];
				if (!part.isBlank()) {
					// There might be a label following...
					char last = part.charAt(part.length() - 1);
					char first = part.charAt(0);
					// System.out.println(line + " / " + part + "/" + last + "/" + first);
					if (Character.isAlphabetic(first)) {
						// Looks like a label...
						if (last != '!') {
							// ! at the end means no label translation...
							part = INLINE_LABEL_PREFIX + part;
						} else {
							if (mnm.isJump()) {
								// It's a jump, then it's a label...
								part = part.replace("!", "");
							} else {
								// If it's not, we handle it as a BASIC variable
								// ...it might be a label of the runtime as well, but we ignore this for now...
								String varName = part.replace("!", "").toUpperCase(Locale.ENGLISH);
								part = "VAR_" + varName;
								if (!parserStage && machine.getVariableUpperCase(varName) == null) {
									throw new RuntimeException(varName
											+ " not found, check variable name or consider disabling constant folding: "
											+ line);
								}
								if (parserStage) {
									// Track usage in parser stage, so that we don't optimize that variable away
									Variable tmpVar = new Variable(varName, null);
									machine.trackVariableUsage(tmpVar, false);
									machine.addVariableInAsm(varName);
								}
							}
						}
					} else {
						// it's something else...
						if (last == '!') {
							// It's a jump to a BASIC line...
							part = "LINE_" + part.replace("!", "");
						} else {
							// No, it's not...nothing to do then
						}
					}
				}
				code.add(maybeCmd + " " + parts[0] + part + parts[2]);
			} else {
				if (line.startsWith(".")) {
					// A value in memory
					code.add(line);
				} else {
					// A label
					if (line.startsWith("*")) {
						code.add(line);
					} else {
						if (line.contains("=")) {
							int pos = line.indexOf("=");
							String left = line.substring(0, pos).trim();
							String right = line.substring(pos + 1).trim();
							if (!right.isEmpty()) {
								char c = right.charAt(0);
								if (Character.isAlphabetic(c)) {
									right = INLINE_LABEL_PREFIX + right;
								}
							}
							code.add(INLINE_LABEL_PREFIX + left + "=" + right);
						} else {
							code.add(INLINE_LABEL_PREFIX + line);
						}
					}
				}
			}
		}
	}

	private static String[] split(String line) {
		String[] res = { "", "", "" };
		int idx = 0;
		for (int i = 0; i < line.length(); i++) {
			char c = line.charAt(i);
			if (idx == 0) {
				if (!Character.isDigit(c) && !Character.isAlphabetic(c) && c != '$') {
					res[idx] = res[idx] + c;
				} else {
					idx++;
				}
			}
			if (idx == 1) {
				if (Character.isDigit(c) || Character.isAlphabetic(c) || c == '$' || c == '_' || c == '!' || c == '%') {
					res[idx] = res[idx] + c;
				} else {
					idx++;
				}
			}
			if (idx == 2) {
				res[idx] = res[idx] + c;
			}
		}
		return res;
	}

}
