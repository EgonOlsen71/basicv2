package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;

import com.sixtyfour.cbmnative.Generator;
import com.sixtyfour.cbmnative.Operand;

/**
 * @author EgonOlsen
 * 
 */
public abstract class GeneratorBase implements Generator {

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
			nCode.add("LDY STATUS");
			nCode.add("; Byte in Y to FAC");
			nCode.add("JSR BYTEFAC");
			nCode.add("LDX #<" + source.getAddress());
			nCode.add("LDY #>" + source.getAddress());
			nCode.add("JSR FACMEM");
		} else if (source.getAddress().equals("VAR_TI")) {
			nCode.add("SEI");
			nCode.add("LDY TIMEADDR");
			nCode.add("LDX TIMEADDR+1");
			nCode.add("LDA TIMEADDR+2");
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
