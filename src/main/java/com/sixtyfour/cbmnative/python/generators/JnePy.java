package com.sixtyfour.cbmnative.python.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.GeneratorContext;

/**
 * @author EgonOlsen
 * 
 */
public class JnePy extends JumpBasePy {

	public JnePy() {
		super("", null);
	}

	@Override
	public String getMnemonic() {
		return "JNE";
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
			Map<String, String> name2label) {
		String[] parts = line.split(" ");
		nCode.add("global _zeroflag");
		nCode.add("if _zeroflag==1:");
		nCode.add("    return \"" + parts[1].trim() + "\"");
	}
}
