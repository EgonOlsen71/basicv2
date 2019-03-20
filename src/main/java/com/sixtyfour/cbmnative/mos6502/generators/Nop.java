package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.GeneratorContext;

/**
 * @author EgonOlsen
 * 
 */
public class Nop extends GeneratorBase {

	@Override
	public String getMnemonic() {
		return "NOP";
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
			Map<String, String> name2label) {
		nCode.add("NOP");
		// Logger.log(line);
	}

}
