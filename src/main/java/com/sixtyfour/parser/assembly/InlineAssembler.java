package com.sixtyfour.parser.assembly;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.mnemonics.Mnemonic;


/**
 * 
 * @author EgonOlsen
 *
 */
public class InlineAssembler {

	public static List<String> extract(CompilerConfig conf, String asmCode) {
		if (asmCode.startsWith("REM")) {
			asmCode = asmCode.substring(3).trim();
		}
		String[] lines = asmCode.split(";");
		List<String> code = new ArrayList<>();
		Arrays.stream(lines).forEach(p -> add(conf, code, p));
		return code;
	}

	private static void add(CompilerConfig conf, List<String> code, String line) {
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
				if (mnm.isJump() && !part.isBlank()) {
					// There might be a label following...
					char first = part.charAt(0);
					if (Character.isAlphabetic(first)) {
						// Looks like a label...
						if (!part.endsWith("!")) {
							// ! at the end means no label translation...
							part = "inllbl_"+part;
						}
					} else {
						// it's something else...
						if (first == '!') {
							// It's a jump to a BASIC line...
							part = "LINE_"+part.substring(1);
						} else {
							// No, it's not...nothing to do then
						}
					}
				}
				code.add(maybeCmd+" "+part);
			} else {
				// A label
				code.add("inllbl_"+line);
			}
		}
	}

}
