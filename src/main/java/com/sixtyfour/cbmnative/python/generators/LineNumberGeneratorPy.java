package com.sixtyfour.cbmnative.python.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.Generator;
import com.sixtyfour.cbmnative.GeneratorContext;
import com.sixtyfour.cbmnative.python.Pythonizer;

public class LineNumberGeneratorPy implements Generator {

	@Override
	public String getMnemonic() {
		return "";
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
			Map<String, String> name2label) {
		Pythonizer py = new Pythonizer(0);
		line = line.replace(":", "");
		if (!line.equals("PROGRAMSTART")) {
			if (!nCode.get(nCode.size() - 1).startsWith("return") || nCode.get(nCode.size() - 1).contains("$JUMP")) {
				nCode.add(py.process("return " + (isNumber(line) ? line : ("\"" + line + "\""))));
			}
		}
		py.outdent();
		nCode.add(py.process("#"));
		String prefix = "";
		if (isNumber(line)) {
			prefix = "line_";
		}
		nCode.add(py.process("def " + prefix + line + "():"));
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
