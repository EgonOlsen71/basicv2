package com.sixtyfour.elements.mnemonics;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 *
 */
public class MnemonicList {
	public static final List<Mnemonic> MNEMONICS = Collections.unmodifiableList(new ArrayList<Mnemonic>() {
		private static final long serialVersionUID = 1L;

		{
			this.add(new Lda());
			this.add(new Ldx());
			this.add(new Ldy());
			this.add(new Sta());
			this.add(new Stx());
			this.add(new Sty());
			this.add(new Tax());
			this.add(new Tay());
			this.add(new Tsx());
			this.add(new Txa());
			this.add(new Tya());
			this.add(new Txs());
			this.add(new And());
			this.add(new Ora());
			this.add(new Eor());
			this.add(new Adc());
			this.add(new Sbc());
			this.add(new Cmp());
			this.add(new Inc());
			this.add(new Dec());
			this.add(new Inx());
			this.add(new Iny());
			this.add(new Dex());
			this.add(new Dey());
		}
	});

	public static List<Mnemonic> getMnemonics() {
		return MNEMONICS;
	}

}
