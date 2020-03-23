package com.sixtyfour.cbmnative.mos6502.x16.generators;

import java.util.List;

import com.sixtyfour.cbmnative.Operand;
import com.sixtyfour.cbmnative.mos6502.generators.Mov;
import com.sixtyfour.cbmnative.mos6502.x16.X16Defaults;

/**
 * @author EgonOlsen
 *
 */
public class MovX extends Mov implements X16Defaults {

	@Override
	protected void checkSpecialReadVars(List<String> nCode, Operand source) {
		super.checkSpecialReadVars(nCode, source);
		checkSpecialReadVarsX16(nCode, source);
	}
}
