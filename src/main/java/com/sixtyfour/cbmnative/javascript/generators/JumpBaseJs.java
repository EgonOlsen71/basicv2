package com.sixtyfour.cbmnative.javascript.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.GeneratorContext;

/**
 * @author EgonOlsen
 * 
 */
public abstract class JumpBaseJs extends GeneratorBaseJs {

	protected static int CNT = 0;
	protected String cmd = "";
	protected String antiCmd = "";

	JumpBaseJs(String cmd, String antiCmd) {
		this.cmd = cmd;
		this.antiCmd = antiCmd;
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode, Map<String, String> name2label) {
		// Logger.log(line);
		String[] parts = line.split(" ");
		String label = parts[1];
		if (label.equals("($JUMP)") && antiCmd != null) {
			nCode.add(antiCmd + " R" + cmd + "_" + CNT);
			nCode.add("return JUMP_TARGET;");
			nCode.add("R" + cmd + "_" + CNT + ":");
			CNT++;
		} else {
			if (Character.isDigit(label.charAt(0)) || label.startsWith("SKIP") || label.startsWith("NSKIP")) {
				nCode.add((cmd + " line_" + parts[1].trim()+(cmd.isEmpty()?"();":";")).trim());
			} else {
				nCode.add((cmd + " " + parts[1].trim()+(cmd.isEmpty()?"();":";")).trim());
			}
		}
	}
}
