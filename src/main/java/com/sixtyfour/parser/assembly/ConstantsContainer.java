package com.sixtyfour.parser.assembly;

import java.util.HashMap;
import java.util.Map;

/**
 * A container for constants.
 * 
 * @author EgonOlsen
 * 
 */
public class ConstantsContainer {

	private Map<String, ConstantValue> constants = new HashMap<String, ConstantValue>();

	/**
	 * Puts a constant into the container.
	 * 
	 * @param val
	 *            the new constant
	 */
	public void put(ConstantValue val) {
		constants.put(val.getName(), val);
	}

	/**
	 * Gets a constant from the container or null, if it doesn't exist.
	 * 
	 * @param name
	 *            the name of the constant
	 * @return the constant or null
	 */
	public ConstantValue get(String name) {
		return constants.get(name);
	}

}
