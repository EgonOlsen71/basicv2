package com.sixtyfour.cbmnative.javascript.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.GeneratorContext;

/**
 * @author EgonOlsen
 * 
 */
public class JeJs extends JumpBaseJs {

    public JeJs() {
	super("", null);
    }

    @Override
    public String getMnemonic() {
	return "JE";
    }

    @Override
    public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
	    Map<String, String> name2label) {
	String[] parts = line.split(" ");
	nCode.add("if (this._zeroflag==0) {");
	nCode.add("return \""+parts[1].trim() + "\";}");
    }
}
