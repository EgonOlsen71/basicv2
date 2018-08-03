package com.sixtyfour.cbmnative.javascript.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.GeneratorContext;
import com.sixtyfour.cbmnative.Operand;
import com.sixtyfour.cbmnative.Operands;

/**
 * @author EgonOlsen
 * 
 */
public class SubJs extends GeneratorBaseJs {

    @Override
    public String getMnemonic() {
	return "SUB";
    }

    @Override
    public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
	    Map<String, String> name2label) {
	Operands ops = new Operands(line, name2label);

	Operand source = ops.getSource();
	Operand target = ops.getTarget();

	String from = getOpName(source);
	String to = getOpName(target);
	nCode.add(to + "=" + to + "-" + from + ";");
	truncInteger(nCode, target);
    }

}
