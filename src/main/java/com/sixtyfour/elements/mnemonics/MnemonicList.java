package com.sixtyfour.elements.mnemonics;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.sixtyfour.config.CompilerConfig;

/**
 * A list of all known mnemonics.
 */
public class MnemonicList {

	private static final Set<Integer> CONDITIONAL_BRANCHES = Collections.unmodifiableSet(new HashSet<Integer>() {
		private static final long serialVersionUID = 1L;
		{
			this.add(0x90);
			this.add(0xB0);
			this.add(0xF0);
			this.add(0xD0);
			this.add(0x10);
			this.add(0x30);
			this.add(0x50);
			this.add(0x70);
		}
	});

	private static final List<Mnemonic> MNEMONICS = Collections.unmodifiableList(new ArrayList<Mnemonic>() {
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
			this.add(new Cpx());
			this.add(new Cpy());
			this.add(new Inc());
			this.add(new Dec());
			this.add(new Inx());
			this.add(new Iny());
			this.add(new Dex());
			this.add(new Dey());
			this.add(new Asl());
			this.add(new Lsr());
			this.add(new Ror());
			this.add(new Rol());
			this.add(new Bit());
			this.add(new Jmp());
			this.add(new Jsr());
			this.add(new Rti());
			this.add(new Rts());
			this.add(new Bcc());
			this.add(new Bcs());
			this.add(new Beq());
			this.add(new Bne());
			this.add(new Bmi());
			this.add(new Bpl());
			this.add(new Bvc());
			this.add(new Bvs());
			this.add(new Sec());
			this.add(new Clc());
			this.add(new Sei());
			this.add(new Cli());
			this.add(new Clv());
			this.add(new Sld());
			this.add(new Cld());
			this.add(new Pha());
			this.add(new Pla());
			this.add(new Php());
			this.add(new Plp());
			this.add(new Nop());
			this.add(new Brk());
		}
	});
	
	// Enhanced list with support for some 65C02 commands...
	private static final List<Mnemonic> XMNEMONICS = Collections.unmodifiableList(new ArrayList<Mnemonic>() {
		private static final long serialVersionUID = 1L;

		{
		    this.add(new Stz());
		    this.add(new Ply());
		    this.add(new Plx());
		    this.add(new Phy());
		    this.add(new Phx());
		    this.addAll(MNEMONICS);
		}
	});

	/**
	 * Return the list of mnemonics
	 * 
	 * @return the list
	 */
	public static List<Mnemonic> getMnemonics(CompilerConfig config) {
	    if (!config.isEnhancedInstructionSet()) {
		return MNEMONICS;
	    } else {
		return XMNEMONICS;
	    }
	}

	/**
	 * Returns a set of opcodes that represent conditional branches.
	 * 
	 * @return the set
	 */
	public static Set<Integer> getConditonalBranches() {
		return CONDITIONAL_BRANCHES;
	}

}
