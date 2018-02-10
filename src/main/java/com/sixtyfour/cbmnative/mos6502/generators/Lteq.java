package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;

public class Lteq extends Compare {

	protected Lteq() {
		super("LTEQ", "BCC");
	}

	@Override
	protected void doCompare(List<String> nCode) {
		int p = nCode.size();
		super.doCompare(nCode);
		nCode.add(p + 1, "BEQ " + mnemonic + "_" + mnemonic + CNT);
		// BCC/BEQ should be better in most cases than BEQ/BCC...
	}

}
