package com.sixtyfour.cbmnative.javascript.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.Generator;
import com.sixtyfour.cbmnative.GeneratorContext;

public class LineNumberGeneratorJs implements Generator {

    @Override
    public String getMnemonic() {
	return "";
    }

    @Override
    public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
	    Map<String, String> name2label) {
	line = line.replace(":", "");
	if (!line.equals("PROGRAMSTART")) {
	    if (!nCode.get(nCode.size()-1).startsWith("return") || nCode.get(nCode.size()-1).contains("$JUMP")) {
		nCode.add("return " + (isNumber(line)?line:("\""+line+"\"")) + ";");
	    }
	    nCode.add("} ");
	}
	nCode.add("//");
	String prefix = "";
	if (isNumber(line)) {
	    prefix = "line_";
	}
	nCode.add("this."+prefix+line+" = function() {");
    }

    private static boolean isNumber(String line) {
	try {
	    Integer.parseInt(line);
	    return true;
	} catch (Exception e) {
	    return false;
	}
    }

}
