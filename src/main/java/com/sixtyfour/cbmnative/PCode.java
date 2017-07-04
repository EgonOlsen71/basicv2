package com.sixtyfour.cbmnative;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sixtyfour.parser.Line;

public class PCode {
	private Map<Integer, Line> lines = new HashMap<Integer, Line>();

	private List<Integer> lineNumbers = new ArrayList<Integer>();

	public PCode(List<Integer> lineNumbers, Map<Integer, Line> lines) {
		this.lineNumbers.addAll(lineNumbers);
		this.lines.putAll(lines);
	}

	public Map<Integer, Line> getLines() {
		return lines;
	}

	public List<Integer> getLineNumbers() {
		return lineNumbers;
	}

}
