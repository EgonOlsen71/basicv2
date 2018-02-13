package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;

/**
 * @author EgonOlsen
 * 
 */
public abstract class GeneratorBase implements Generator {

	// Zeropage address for temp. data, actually ARG/FAC1
	protected final static int TMP_ZP = 105;

	protected String createAddress(String addr, int offset) {
		try {
			int ia = Integer.parseInt(addr);
			ia += offset;
			return String.valueOf(ia);
		} catch (Exception e) {
			return addr + "+" + offset;
		}
	}
	
	protected void checkSpecialVars(List<String> nCode, Operand source) {
	    if (source.getAddress().equals("VAR_ST")) {
	        nCode.add("LDY $90");
	        nCode.add("; Byte in Y to FAC");
	        nCode.add("JSR $B3A2");
	        nCode.add("LDX #<" + source.getAddress());
	        nCode.add("LDY #>" + source.getAddress());
	        nCode.add("JSR $BBD7");
	    }
	}

}
