package com.sixtyfour.cbmnative.powerscript.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.GeneratorContext;

/**
 * @author EgonOlsen
 * 
 */
public class JmpPs extends JumpBasePs {

	public JmpPs() {
		super("", null);
	}

	@Override
	public String getMnemonic() {
		return "JMP";
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
			Map<String, String> name2label) {
		String[] parts = line.split(" ");
		String p1 = parts[1].trim();
		nCode.add(("return " + (isNumber(p1) ? p1 : ("\"" + p1 + "\""))).trim());
	}
}
