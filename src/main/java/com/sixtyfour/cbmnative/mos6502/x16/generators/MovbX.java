package com.sixtyfour.cbmnative.mos6502.x16.generators;

import java.util.List;

import com.sixtyfour.cbmnative.Operand;
import com.sixtyfour.cbmnative.mos6502.generators.Movb;
import com.sixtyfour.cbmnative.mos6502.x16.X16Defaults;
import com.sixtyfour.elements.Type;

/**
 * Special implementation of the MOVB generator for the X16, because it has to
 * switch ROM banks for PEEK (for whatever reason...)
 * 
 * @todo this might has to be extended to cover RAM banks as well once some kind
 *       of BANK command makes it into the X16's BASIC
 * 
 * 
 * @author EgonOlsen71
 *
 */
public class MovbX extends Movb implements X16Defaults {

	protected void indexedSource(List<String> nCode, Operand source, Operand target) {
		createIndexedSourceCode(nCode, source);

		if (target.getType() == Type.INTEGER) {
			nCode.add("MOVBSELF" + MOV_CNT + ":");
			nCode.add("LDA $FFFF");
			nCode.add("STA " + target.getRegisterName());
			nCode.add("STY " + createAddress(target.getRegisterName(), 1));
			nCode.add("PLA");
			nCode.add("STA ROMSELECT");
		} else {
			nCode.add("MOVBSELF" + MOV_CNT + ":");
			nCode.add("LDY $FFFF");
			nCode.add("PLA");
			nCode.add("STA ROMSELECT");
			nCode.add("LDA #0");
			nCode.add("; integer in Y/A to FAC");
			nCode.add("JSR INTFAC"); // integer in A/Y to FAC

			nCode.add("LDX #<" + target.getRegisterName());
			nCode.add("LDY #>" + target.getRegisterName());
			nCode.add("; FAC to (X/Y)");
			nCode.add("JSR FACMEM"); // FAC to (X/Y)
		}
	}

	protected void createIndexedSourceCode(List<String> nCode, Operand source) {
		super.createIndexedSourceCode(nCode, source);
		nCode.add("LDA ROMSELECT");
		nCode.add("PHA");
		nCode.add("LDA #0");
		nCode.add("STA ROMSELECT");
	}

	@Override
	protected void checkSpecialReadVars(List<String> nCode, Operand source) {
		super.checkSpecialReadVars(nCode, source);
		checkSpecialReadVarsX16(nCode, source);
	}

	@Override
	protected boolean checkSpecialWriteVarsString(List<String> nCode, Operand target) {
		boolean ret = super.checkSpecialWriteVarsString(nCode, target);
		if (!ret) {
			ret = checkSpecialWriteVarsStringX16(nCode, target);
		}
		return ret;
	}

}
