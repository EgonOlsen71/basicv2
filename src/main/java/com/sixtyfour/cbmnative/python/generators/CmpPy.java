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
public class CmpPy extends GeneratorBasePy {

	@Override
	public String getMnemonic() {
		return "CMP";
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
			Map<String, String> name2label) {
		Operands ops = new Operands(line, name2label);

		Operand source = ops.getSource();
		Operand target = ops.getTarget();

		String from = getOpName(source);
		String to = getOpName(target);

		nCode.add("global _zeroflag");
		nCode.add("_zeroflag=(0 if " + to + "==" + from + " else 1)");
	}

}
