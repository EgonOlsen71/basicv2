package com.sixtyfour.cbmnative.powerscript.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.GeneratorContext;

/**
 * @author EgonOlsen
 * 
 */
public class NopPs extends GeneratorBasePs {

	@Override
	public String getMnemonic() {
		return "NOP";
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
			Map<String, String> name2label) {
		nCode.add("#");
	}

}
