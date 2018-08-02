package com.sixtyfour.cbmnative;

import java.util.List;
import java.util.Map;

/**
 * @author EgonOlsen
 * 
 */
public interface Generator {
	String getMnemonic();

	void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode, Map<String, String> name2label);
}
