package com.sixtyfour.cbmnative.mos6502.x16;

import java.util.List;

import com.sixtyfour.cbmnative.Operand;

/**
 * @author EgonOlsen
 *
 */
public interface X16Defaults {

	default void checkSpecialReadVarsX16(List<String> nCode, Operand source) {
		String addr = source.getAddress();
		boolean add = false;
		if (addr.equals("VAR_MX")) {
			nCode.add("LDY MOUSEX");
			nCode.add("LDA MOUSEX+1");
			add = true;
		} else if (addr.equals("VAR_MY")) {
			nCode.add("LDY MOUSEY");
			nCode.add("LDA MOUSEY+1");
			add = true;
		} else if (addr.equals("VAR_MB")) {
			nCode.add("LDY MOUSEBT");
			nCode.add("LDA #0");
			add = true;
		}
		if (add) {
			nCode.add("JSR INTFAC");
			nCode.add("LDX #<" + addr);
			nCode.add("LDY #>" + addr);
			nCode.add("JSR FACMEM");
		}
	}

}
