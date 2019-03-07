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
public abstract class CalculationPs  extends GeneratorBasePs {

    private String mnemonic;
    private String calcString;
    
    CalculationPs(String mnemonic, String calcString) {
	this.mnemonic=mnemonic;
	this.calcString=calcString;
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
	nCode.add(to +"="+calcString.replace("{to}", to).replace("{from}", from));
	truncInteger(nCode, target);

    }
    
}
