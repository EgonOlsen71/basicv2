package com.sixtyfour.util.rommap;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author EgonOlsen71
 *
 */
public class Mapping {

	private Map<String, String> map = null;

	private List<String> farCalls = new ArrayList<>();

	public Map<String, String> getMap() {
		return map;
	}

	public void setMap(Map<String, String> map) {
		this.map = map;
	}

	public List<String> getFarCalls() {
		return farCalls;
	}

	public void setFarCalls(List<String> farCalls) {
		this.farCalls = farCalls;
	}

}
