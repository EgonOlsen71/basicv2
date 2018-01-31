package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;

public class Lt extends Compare {

	protected Lt() {
		super("LT", "BCC");
	}

	@Override
	protected void doCompare(List<String> nCode) {
		// Vergleich Konstante (A/Y) mit FAC: A=0 wenn gleich, A=1 wenn FAC
		// größer, A=$FF wenn FAC kleiner
		nCode.add("BEQ " + mnemonic + "_" + mnemonic + "_EQ" + CNT);
		nCode.add("ROL");
		nCode.add(command + " " + mnemonic + "_" + mnemonic + CNT);
		nCode.add(mnemonic + "_" + mnemonic + "_EQ" + CNT + ":");
		nCode.add("LDA #<REAL_CONST_ZERO");
		nCode.add("LDY #>REAL_CONST_ZERO");
		nCode.add("JMP " + mnemonic + "_SKIP" + CNT);
		nCode.add(mnemonic + "_" + mnemonic + CNT + ":");
		nCode.add("LDA #<REAL_CONST_MINUS_ONE");
		nCode.add("LDY #>REAL_CONST_MINUS_ONE");
	}

}
