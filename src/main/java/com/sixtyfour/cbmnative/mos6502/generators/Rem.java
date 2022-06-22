package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.GeneratorContext;
import com.sixtyfour.parser.assembly.InlineAssembler;

/**
 * @author EgonOlsen
 * 
 */
public class Rem extends GeneratorBase {

	@Override
	public String getMnemonic() {
		return "REM";
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
			Map<String, String> name2label) {
		// Logger.log(line);
		
		nCode.addAll(InlineAssembler.extract(context.getCompilerConfig(), line, context.getMachine()));
	}

}
