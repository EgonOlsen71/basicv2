package com.sixtyfour.cbmnative;

import java.util.List;

import com.sixtyfour.system.Machine;

/**
 * @author EgonOlsen
 * 
 */
public interface Transformer {
	/**
	 * @param machine
	 * @return
	 */
	List<String> transform(Machine machine, PlatformProvider romProvider, List<String> code);

	void setVariableStart(int variableStart);
}
