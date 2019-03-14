package com.sixtyfour.cbmnative.powerscript.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.GeneratorContext;

/**
 * @author EgonOlsen
 * 
 */
public class JePs extends JumpBasePs {

	public JePs() {
		super("", null);
	}

	@Override
	public String getMnemonic() {
		return "JE";
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
			Map<String, String> name2label) {
		String[] parts = line.split(" ");
		nCode.add("if ($_zeroflag -eq 0) {");
		nCode.add("return \"" + parts[1].trim() + "\"}");
	}
}
