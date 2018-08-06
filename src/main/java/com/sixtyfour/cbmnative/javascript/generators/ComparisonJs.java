package com.sixtyfour.cbmnative.javascript.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.GeneratorContext;
import com.sixtyfour.cbmnative.Operand;
import com.sixtyfour.cbmnative.Operands;

public abstract class ComparisonJs extends GeneratorBaseJs{

    private String mnemonic;
    private String operator;
    
    ComparisonJs(String mnemonic, String operator) {
	this.mnemonic=mnemonic;
	this.operator=operator;
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
	nCode.add(to + "=(" + to + operator + from + "?-1:0);");
    }
    
}
