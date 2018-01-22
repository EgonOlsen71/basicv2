package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;
import java.util.Map;

/**
 * @author EgonOlsen
 * 
 */
public class Jsr extends JumpBase {

	private static int forCnt = 0;

	public Jsr() {
		super("JSR", null);
	}

	@Override
	public String getMnemonic() {
		return "JSR";
	}

	@Override
	public void generateCode(String line, List<String> nCode, List<String> subCode, Map<String, String> name2label) {
		if (line.equals("JSR INITFOR")) {
			String name = "FORLOOP" + (forCnt++);
			nCode.add("LDA #<" + name);
			nCode.add("STA JUMP_TARGET");
			nCode.add("LDA #>" + name);
			nCode.add("STA JUMP_TARGET+1");
			super.generateCode(line, nCode, subCode, name2label);
			nCode.add(name + ":");
		} else {
			super.generateCode(line, nCode, subCode, name2label);
		}
	}
}
