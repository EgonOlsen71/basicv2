package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.GeneratorContext;

/**
 * @author EgonOlsen
 * 
 */
public abstract class JumpBase extends GeneratorBase {

	protected static int CNT = 0;
	protected String cmd = "";
	protected String antiCmd = "";

	JumpBase(String cmd, String antiCmd) {
		this.cmd = cmd;
		this.antiCmd = antiCmd;
	}

	public boolean mightBeSystemCallFromBasic() {
		return false;
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
			Map<String, String> name2label) {
		// Logger.log(line);
		String[] parts = line.split(" ");
		String label = parts[1];
		if (label.equals("($JUMP)") && antiCmd != null) {
			nCode.add(antiCmd + " R" + cmd + "_" + CNT);
			nCode.add("JMP (JUMP_TARGET)");
			nCode.add("R" + cmd + "_" + CNT + ":");
			CNT++;
		} else {
			if (Character.isDigit(label.charAt(0)) || label.startsWith("SKIP") || label.startsWith("NSKIP")) {
				nCode.add(cmd + " LINE_" + parts[1].trim());
			} else {

				if (mightBeSystemCallFromBasic() && parts[1].startsWith("$")) {
					int val = Integer.parseInt(parts[1].trim().substring(1), 16);
					nCode.add("LDA #<" + val);
					nCode.add("STA TMP_ZP");
					nCode.add("LDA #>" + val);
					nCode.add("STA TMP_ZP+1");
					nCode.add("JSR SYSTEMCALL");
				} else {
					nCode.add(cmd + " " + parts[1].trim());
				}
			}
		}
	}
}
