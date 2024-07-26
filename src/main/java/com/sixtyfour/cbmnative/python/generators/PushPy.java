package com.sixtyfour.cbmnative.python.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.GeneratorContext;
import com.sixtyfour.cbmnative.Operand;
import com.sixtyfour.cbmnative.Operands;

/**
 * @author EgonOlsen
 * 
 */
public class PushPy extends GeneratorBasePy {
	@Override
	public String getMnemonic() {
		return "PUSH";
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
			Map<String, String> name2label) {
		Operands ops = new Operands(line, name2label);
		Operand target = ops.getTarget();
		String from = getOpName(target);
		nCode.add("global _stack");
		nCode.add("_stack.append(" + from + ")");
	}
}
