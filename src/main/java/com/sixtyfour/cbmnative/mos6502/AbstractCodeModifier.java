package com.sixtyfour.cbmnative.mos6502;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 
 * @author EgonOlsen
 *
 */
public abstract class AbstractCodeModifier implements CodeModifier {

	protected List<List<String>> parts;
	protected List<String> cleaned;

	@Override
	public List<String> modify(IntPattern pattern, List<String> input) {
		parts = pattern.split(input);
		cleaned = parts.get(1).stream().filter(p -> !p.startsWith(";")).collect(Collectors.toList());
		if (cleaned==null) {
			throw new RuntimeException("No input code extracted!");
		}
		return input;
	}

	protected List<String> combine(IntPattern pattern, List<String> rep) {
		rep.add("; " + pattern.getName());
		for (int p = rep.size(); p < parts.get(1).size(); p++) {
			rep.add(";");
		}
		List<String> input = new ArrayList<>(parts.get(0));
		input.addAll(rep);
		input.addAll(parts.get(2));
		pattern.reset();
		pattern.incUsage();
		return input;
	}

}
