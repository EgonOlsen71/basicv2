package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;

public class Lteq extends Compare {

	protected Lteq() {
		super("LTEQ", "BCC");
	}

	@Override
	protected void doCompare(List<String> nCode) {
		nCode.add("BEQ " + mnemonic + "_" + mnemonic + CNT);
		super.doCompare(nCode);
	}

}
