package com.sixtyfour.cbmnative.python.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.GeneratorContext;

/**
 * @author EgonOlsen
 * 
 */
public class BrkPy extends GeneratorBasePy {

	@Override
	public String getMnemonic() {
		return "BRK";
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
			Map<String, String> name2label) {
		nCode.add("raise Exception(\"break\")");
	}

}
