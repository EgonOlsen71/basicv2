package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;

public class Gteq extends Compare {

	protected Gteq() {
		super("GTEQ", "BCS");
	}

	@Override
	protected void doCompare(List<String> nCode) {
		nCode.add("BEQ " + mnemonic + "_" + mnemonic + CNT);
		super.doCompare(nCode);

	}

}
