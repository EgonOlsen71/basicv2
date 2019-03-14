package com.sixtyfour.cbmnative.powerscript.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.GeneratorContext;
import com.sixtyfour.cbmnative.Operand;
import com.sixtyfour.cbmnative.Operands;

/**
 * @author EgonOlsen
 * 
 */
public class PopPs extends GeneratorBasePs {
	@Override
	public String getMnemonic() {
		return "POP";
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
			Map<String, String> name2label) {
		Operands ops = new Operands(line, name2label);
		Operand target = ops.getTarget();
		String to = getOpName(target);
		nCode.add(to + "= first $global:_stack");
		nCode.add("$global:_stack=pop $global:_stack");
	}
}
