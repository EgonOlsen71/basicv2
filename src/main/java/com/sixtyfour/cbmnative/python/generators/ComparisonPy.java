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
public abstract class ComparisonPy extends GeneratorBasePy {

	private String mnemonic;
	private String operator;

	ComparisonPy(String mnemonic, String operator) {
		this.mnemonic = mnemonic;
		this.operator = operator;
	}

	@Override
	public String getMnemonic() {
		return mnemonic;
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
			Map<String, String> name2label) {
		Operands ops = new Operands(line, name2label);

		Operand source = ops.getSource();
		Operand target = ops.getTarget();

		String from = getOpName(source);
		String to = getOpName(target);
		nCode.add(to + "= (-1 if " + to + operator + from + " else 0)");
	}

}
