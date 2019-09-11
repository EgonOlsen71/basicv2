package com.sixtyfour.cbmnative.mos6502;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author EgonOlsen
 *
 */
public class OptimizationResult {

    private List<String> code;

    private Map<String, Integer> type2count;

    public List<String> getCode() {
	return code;
    }

    public OptimizationResult(List<String> code, Map<String, Integer> type2count) {
	this.code = new ArrayList<>(code);
	this.type2count = new HashMap<>(type2count);
    }

    public void setCode(List<String> code) {
	this.code = code;
    }

    public Map<String, Integer> getType2count() {
	return type2count;
    }

    public void setType2count(Map<String, Integer> type2count) {
	this.type2count = type2count;
    }

}
