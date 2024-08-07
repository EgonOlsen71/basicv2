package com.sixtyfour.cbmnative.python.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.GeneratorContext;

/**
 * @author EgonOlsen
 * 
 */
public class RtsPy extends GeneratorBasePy {

	@Override
	public String getMnemonic() {
		return "RTS";
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
			Map<String, String> name2label) {
		if (nCode.get(nCode.size() - 1).startsWith("return")) {
			return;
		}
		nCode.add("return");
	}

}
