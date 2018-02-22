package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.elements.Type;

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
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode, Map<String, String> name2label) {
		if (line.equals("JSR INITFOR")) {
			String name = "FORLOOP" + (forCnt++);
			nCode.add("LDA #<" + name);
			nCode.add("STA JUMP_TARGET");
			nCode.add("LDA #>" + name);
			nCode.add("STA JUMP_TARGET+1");
			super.generateCode(context, line, nCode, subCode, name2label);
			nCode.add(name + ":");
		} else if (line.equals("JSR ARRAYACCESS") || line.equals("JSR ARRAYSTORE")) {
			Type type = context.getLastMoveSource().getType();
			line += "_" + type.toString();
			super.generateCode(context, line, nCode, subCode, name2label);
		} else if (line.equals("JSR COPYSTR")) {
			nCode.add(";ignored: JSR COPYSTR");
		} else if (line.equals("JSR COMPACT")) {
			nCode.add(";ignored: JSR COMPACT");
		} else {
			super.generateCode(context, line, nCode, subCode, name2label);
		}
	}
}
