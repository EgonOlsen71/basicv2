package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.Logger;

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
	public void generateCode(String line, List<String> nCode, List<String> subCode, Map<String, String> name2label) {
		Logger.log(line);
	}

}
