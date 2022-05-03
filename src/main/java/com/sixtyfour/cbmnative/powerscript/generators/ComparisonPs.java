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
public abstract class ComparisonPs extends GeneratorBasePs {

	private String mnemonic;
	private String operator;

	ComparisonPs(String mnemonic, String operator) {
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
		nCode.add("if (" + to + operator + from + " -eq $True) {" + to + "=-1} else {" + to + "=0}");
	}

}
