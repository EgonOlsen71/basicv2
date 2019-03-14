package com.sixtyfour.cbmnative;

import java.util.List;
import java.util.Map;

/**
 * Interface for a Generator. A generator is a class to transform a single
 * command from the intermediate language into the actual target language.
 * 
 * @author EgonOlsen
 * 
 */
public interface Generator {

	/**
	 * Returns the mnemonic which this generator can handle.
	 * 
	 * @return the mnemonic
	 */
	String getMnemonic();

	/**
	 * Generates code for the target platform from intermediate code.
	 * 
	 * @param context    the generator context
	 * @param line       the line of intermediate code
	 * @param nCode      the generated native code so far
	 * @param subCode    the runtime code
	 * @param name2label a mapping between names and labels
	 */
	void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
			Map<String, String> name2label);
}
