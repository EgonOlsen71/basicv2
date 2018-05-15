package com.sixtyfour.parser;

import java.util.Map;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.system.Machine;

/**
 * Interface for a term builder. Used to seperate the Parser's implementation
 * from the TermOptimizers request for this.
 * 
 * @author EgonOlsen
 * 
 */
public interface TermBuilder {

	/**
	 * Builds the actual term content of a prefilled term.
	 * 
	 * @param t
	 *            the prefilled term
	 * @param termMap
	 *            the term map
	 * @param machine
	 *            the machine
	 * @return the final term
	 */
	Term build(CompilerConfig config, Term t, Map<String, Term> termMap, Machine machine);
}
