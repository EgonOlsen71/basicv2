package com.sixtyfour.cbmnative.powerscript.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.GeneratorContext;
import com.sixtyfour.elements.Type;

/**
 * @author EgonOlsen
 * 
 */
public class JsrPs extends JumpBasePs {

    public JsrPs() {
	super("", null);
    }

    @Override
    public String getMnemonic() {
	return "JSR";
    }

    @Override
    public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
	    Map<String, String> name2label) {
	if (line.equals("JSR ARRAYACCESS") || line.equals("JSR ARRAYSTORE")) {
	    Type type = context.getLastMoveSource().getType();
	    line += "_" + type.toString();
	    super.generateCode(context, line, nCode, subCode, name2label);
	} else if (line.equals("JSR COPYSTR")) {
	    // nCode.add(";ignored: JSR COPYSTR");
	} else if (line.equals("JSR START")) {
	    line = "JSR STARTPRG";
	    super.generateCode(context, line, nCode, subCode, name2label);
	} else {
	    super.generateCode(context, line, nCode, subCode, name2label);
	}
    }
}
