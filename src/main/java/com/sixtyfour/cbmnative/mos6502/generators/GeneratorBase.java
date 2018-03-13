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

	protected boolean checkSpecialWriteVars(List<String> nCode, Operand target) {
		if (target.getAddress().equals("VAR_TI$")) {
			nCode.add("JSR WRITETID");
			return true;
		}
		return false;
	}

	protected void checkSpecialReadVars(List<String> nCode, Operand source) {
		if (source.getAddress().equals("VAR_ST")) {
			nCode.add("LDY $90");
			nCode.add("; Byte in Y to FAC");
			nCode.add("JSR BYTEFAC");
			nCode.add("LDX #<" + source.getAddress());
			nCode.add("LDY #>" + source.getAddress());
			nCode.add("JSR FACMEM");
		} else if (source.getAddress().equals("VAR_TI")) {
			nCode.add("SEI");
			nCode.add("LDY $A0");
			nCode.add("LDX $A1");
			nCode.add("LDA $A2");
			nCode.add("CLI");
			nCode.add("SEC");
			nCode.add("JSR COPYTIME");
			nCode.add("JSR GETTIME");
			nCode.add("LDX #<" + source.getAddress());
			nCode.add("LDY #>" + source.getAddress());
			nCode.add("JSR FACMEM");
		} else if (source.getAddress().equals("VAR_TI$")) {
			nCode.add("JSR READTID");
		}
	}

}
