package com.sixtyfour.parser.assembly;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.mnemonics.Mnemonic;
import com.sixtyfour.system.Machine;

/**
 * 
 * @author EgonOlsen
 *
 */
public class InlineAssembler {

	public static List<String> extract(CompilerConfig conf, String asmCode, Machine machine) {
		if (asmCode.startsWith("REM")) {
			asmCode = asmCode.substring(3).trim();
		}
		String[] lines = asmCode.split(";");
		List<String> code = new ArrayList<>();
		Arrays.stream(lines).forEach(p -> add(conf, code, p, machine));
		return code;
	}

	private static void add(CompilerConfig conf, List<String> code, String line, Machine machine) {
		if (line.length()==3) {
			code.add(line);
		} else {
			String maybeCmd=line.substring(0, 3);
			Mnemonic mnm = AssemblyParser.getMnemonic(conf, maybeCmd);
			if (mnm!=null) {
				String part = "";
				if (line.length()>3) {
					part = line.substring(3).trim();
				}
				// Some command...
				String[] parts = split(part);
				part = parts[1];
				if (!part.isBlank()) {
					// There might be a label following...
					char last = part.charAt(part.length()-1);
					char first = part.charAt(0);
					//System.out.println(line+" / "+part+"/"+last+"/"+first);
					if (Character.isAlphabetic(first)) {
						// Looks like a label...
						if (last!='!') {
							// ! at the end means no label translation...
							part = "inllbl_"+part;
						} else {
							if (mnm.isJump()) {
								// It's a jump, then it's a label...
								part = part.replace("!", "");
							} else {
								// If it's not, we handle it as a BASIC variable
								// ...it might be a label of the runtime as well, but we ignore this for now...
								String varName = part.replace("!", "").toUpperCase(Locale.ENGLISH);
								part = "VAR_"+varName;
								if (machine.getVariableUpperCase(varName)==null) {
									throw new RuntimeException(varName+" not found, check variable name or consider disabling constant folding: "+line);
								}
							}
						}
					} else {
						// it's something else...
						if (last == '!') {
							// It's a jump to a BASIC line...
							part = "LINE_"+ part.replace("!", "");
						} else {
							// No, it's not...nothing to do then
						}
					}
				} 
				code.add(maybeCmd+" "+parts[0]+part+parts[2]);
			} else {
				if (line.startsWith(".")) {
					// A value in memory
					code.add(line);
				} else {
					// A label
					code.add("inllbl_"+line);
				}
			}
		}
	}

	private static String[] split(String line) {
		String[] res = {"", "", ""};
		int idx = 0;
		for (int i=0; i<line.length(); i++) {
			char c=line.charAt(i);
			if (idx==0) {
				if (!Character.isDigit(c) && !Character.isAlphabetic(c) && c!='$') {
					res[idx]=res[idx]+c;
				} else {
					idx++;
				}
			}
			if (idx==1) {
				if (Character.isDigit(c) || Character.isAlphabetic(c) || c=='$' || c=='_' || c=='!' || c=='%') {
					res[idx]=res[idx]+c;
				} else {
					idx++;
				}
			}
			if (idx==2) {
				res[idx]=res[idx]+c;
			}
		}
		return res;
	}
	
}
