package com.sixtyfour.parser.assembly;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sixtyfour.system.Machine;

/**
 * A container for constants.
 * 
 * @author EgonOlsen
 * 
 */
public class ConstantsContainer {

	private Map<String, ConstantValue> constants = new HashMap<>();
	private List<DelayedData> datas = new ArrayList<>();

	/**
	 * Puts a constant into the container.
	 * 
	 * @param val the new constant
	 */
	public void put(ConstantValue val) {
		constants.put(val.getName(), val);
	}

	/**
	 * Gets a constant from the container or null, if it doesn't exist.
	 * 
	 * @param name the name of the constant
	 * @return the constant or null
	 */
	public ConstantValue get(String name) {
		return constants.get(name);
	}

	/**
	 * Adds new delayed data to the list.
	 * 
	 * @param data the data
	 */
	public void addData(DelayedData data) {
		datas.add(data);
	}

	/**
	 * Insert all the delayded data.
	 * 
	 * @param machine the machine
	 */
	public void applyDelayedData(Machine machine) {
		for (DelayedData data : datas) {
			data.apply(machine, this);
		}
	}

}
