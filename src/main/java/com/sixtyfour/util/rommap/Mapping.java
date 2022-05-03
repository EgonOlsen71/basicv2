package com.sixtyfour.util.rommap;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * A mapping between labels and addresses. This isn't much more than a glorified
 * wrapper around a hash map.
 * 
 * @author EgonOlsen71
 *
 */
public class Mapping {

	private Map<String, String> map = null;

	private List<String> farCalls = new ArrayList<>();

	/**
	 * Returns the mapping. The internal map is given; it's not protected in any
	 * way.
	 * 
	 * @return the mapping
	 */
	public Map<String, String> getMap() {
		return map;
	}

	/**
	 * Sets a new mapping. The given map is assigned directly, no copy is being
	 * made.
	 * 
	 * @param map the new mapping
	 */
	public void setMap(Map<String, String> map) {
		this.map = map;
	}

	/**
	 * Returns a list of calls that are supposed to be JSRFAR calls on the X16.
	 * 
	 * @return the far calls
	 */
	public List<String> getFarCalls() {
		return farCalls;
	}

	/**
	 * Sets a new list of calls.
	 * 
	 * @param farCalls the new calls.
	 */
	public void setFarCalls(List<String> farCalls) {
		this.farCalls = farCalls;
	}

}
