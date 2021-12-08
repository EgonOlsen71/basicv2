package com.sixtyfour.cbmnative.mos6502;

import java.util.List;

import com.sixtyfour.cbmnative.Pattern;

/**
 * 
 * @author EgonOlsen
 *
 */
public class IntPattern extends Pattern {

	private CodeModifier modifier;
	private int usage;

	public IntPattern(boolean simple, String name, String[] parts, CodeModifier modifier) {
		super(simple, name, new String[] {}, parts);
		this.modifier = modifier;
	}
	
	public List<String> modify(List<String> input) {
		return modifier.modify(this, input);
	}

	public int getUsage() {
		return usage;
	}

	public void setUsage(int usage) {
		this.usage = usage;
	}
	
	public void incUsage() {
		usage++;
	}
}
