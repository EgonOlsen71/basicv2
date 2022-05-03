package com.sixtyfour.parser;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.Pattern;

/**
 * Parses additional runtime/optimizer code and rules provided by the compiler's
 * user.
 * 
 * Format is like:
 * 
 *	#patterns
 *  (name) = (old code) ; (new code)
 *	optimized replacement = LDA #<{#24.0}, LDY #>{#24.0}, JSR TEST123 ; JSR TEST456
 *
 *	#code
 *
 * 	TEST456
 *		...<some code>
 *		RTS
 * 
 * @author EgonOlsen
 *
 */
public class RuntimeAddParser {

	private List<Pattern> patterns = new ArrayList<>();
	private List<String> code = new ArrayList<>();

	public RuntimeAddParser(String[] lines) {

		boolean patternMode = false;
		boolean codeMode = false;
		String oLine = null;

		try {
			for (String line : lines) {
				oLine = line;
				String lline = line.toUpperCase(Locale.ENGLISH).trim();
				if (lline.isEmpty()) {
					continue;
				}
				if (!patternMode && !codeMode) {
					if (lline.startsWith("#PATTERNS")) {
						patternMode = true;
					}
				} else {
					if (patternMode) {
						if (lline.startsWith("#CODE")) {
							patternMode = false;
							codeMode = true;
							continue;
						}
						int pos = line.indexOf("=");
						String name = lline.substring(0, pos).trim();
						String rule = lline.substring(pos + 1).trim();
						pos = rule.indexOf(";");
						String old = rule.substring(0, pos).trim();
						String niu = rule.substring(pos + 1).trim();

						String[] oParts = Arrays.asList(old.split(",")).stream().map(p -> p.trim()).collect(Collectors.toList()).toArray(new String[0]);
						String[] nParts = Arrays.asList(niu.split(",")).stream().map(p -> p.trim()).collect(Collectors.toList()).toArray(new String[0]);

						Pattern patty = new Pattern(true, name, nParts, oParts);
						patterns.add(patty);
					} else {
						code.add(lline.replace(":", ""));
					}
				}
			}
			Logger.log("Parsed additional runtime information: " + patterns.size() + " rules and " + code.size()
					+ " code lines!");
		} catch (Exception e) {
			Logger.log("Failed to parse additional runtime information @ " + oLine);
		}
	}

	public List<Pattern> getPatterns() {
		return patterns;
	}

	public void setPatterns(List<Pattern> patterns) {
		this.patterns = patterns;
	}

	public List<String> getCode() {
		return code;
	}

	public void setCode(List<String> code) {
		this.code = code;
	}

}
