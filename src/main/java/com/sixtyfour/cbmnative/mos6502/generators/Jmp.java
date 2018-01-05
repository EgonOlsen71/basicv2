package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.Logger;

public class Jmp extends GeneratorBase {

    @Override
    public String getMnemonic() {
	return "JMP";
    }

    @Override
    public void generateCode(String line, List<String> nCode, List<String> subCode, Map<String, String> name2label) {
	Logger.log(line);
	String[] parts=line.split(" ");
	nCode.add("JMP LINE_"+parts[1].trim());
    }

}
