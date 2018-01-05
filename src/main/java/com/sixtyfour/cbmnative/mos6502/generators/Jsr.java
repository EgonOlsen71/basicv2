package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.Logger;

/**
 * @author EgonOlsen
 *
 */
public class Jsr extends GeneratorBase {

    @Override
    public String getMnemonic() {
	return "JSR";
    }

    @Override
    public void generateCode(String line, List<String> nCode, List<String> subCode, Map<String, String> name2label) {
	Logger.log(line);
	String[] parts = line.split(" ");
	String label = parts[1];
	if (Character.isDigit(label.charAt(0)) || label.startsWith("SKIP")) {
	    nCode.add("JSR LINE_" + parts[1].trim());
	} else {
	    nCode.add("JSR " + parts[1].trim());
	}
    }

}
