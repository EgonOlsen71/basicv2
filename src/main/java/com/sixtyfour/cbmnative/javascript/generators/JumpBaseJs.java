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
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
			Map<String, String> name2label) {
		// Logger.log(line);
		String[] parts = line.split(" ");
		String label = parts[1];
		if (label.equals("($JUMP)") && antiCmd != null) {
			nCode.add(antiCmd + " R" + cmd + "_" + CNT);
			nCode.add("return this.JUMP_TARGET;");
			nCode.add("R" + cmd + "_" + CNT + ":");
			CNT++;
		} else {
			String p1 = parts[1].trim();
			if (Character.isDigit(label.charAt(0)) || label.startsWith("SKIP") || label.startsWith("NSKIP")) {
				nCode.add(("return " + parts[1].trim() + ";").trim());
			} else {
				String pre = "this.";
				if (p1.equals("RETURN")) {
					pre = "return this.";
				}
				nCode.add(pre + (cmd + " " + p1 + ((cmd.isEmpty() && !p1.endsWith(")")) ? "();" : ";")).trim());
			}
		}
	}
}
