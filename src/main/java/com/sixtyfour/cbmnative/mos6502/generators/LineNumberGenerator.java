package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.GeneratorContext;

/**
 * @author EgonOlsen
 * 
 */
public class LineNumberGenerator extends GeneratorBase {

	@Override
	public String getMnemonic() {
		return "";
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode, Map<String, String> name2label) {
		nCode.add(";");
		nCode.add("LINE_" + line);
		nCode.add(";");
	}

}
