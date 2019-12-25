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
			addMouseGet(nCode);
			nCode.add("LDY MOUSE_STORE");
			nCode.add("LDA MOUSE_STORE+1");
			add = true;
		} else if (addr.equals("VAR_MY")) {
			addMouseGet(nCode);
			nCode.add("LDY MOUSE_STORE+2");
			nCode.add("LDA MOUSE_STORE+3");
			add = true;
		} else if (addr.equals("VAR_MB")) {
			addMouseGet(nCode);
			nCode.add("TAY");
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

	static void addMouseGet(List<String> nCode) {
		nCode.add("LDX #MOUSE_STORE");
		nCode.add("JSR mouse_get");
	}

}
