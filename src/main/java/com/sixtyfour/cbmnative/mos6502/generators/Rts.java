package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;
import java.util.Map;

/**
 * @author EgonOlsen
 * 
 */
public class Rts extends GeneratorBase {

	@Override
	public String getMnemonic() {
		return "RTS";
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode, Map<String, String> name2label) {
		// Logger.log(line);
		nCode.add("RTS");
	}

}
