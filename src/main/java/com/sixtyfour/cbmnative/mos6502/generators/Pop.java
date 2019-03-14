package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.GeneratorContext;
import com.sixtyfour.cbmnative.Operand;
import com.sixtyfour.cbmnative.Operands;
import com.sixtyfour.elements.Type;

/**
 * @author EgonOlsen
 * 
 */
public class Pop extends GeneratorBase {
	@Override
	public String getMnemonic() {
		return "POP";
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
			Map<String, String> name2label) {
		Operands ops = new Operands(line, name2label);
		// Logger.log(line + " -- " + ops.getTarget());
		Operand target = ops.getTarget();
		if (target.getType() == Type.INTEGER) {
			nCode.add("JSR POPINT");
			nCode.add("LDY TMP_ZP");
			nCode.add("LDA TMP_ZP+1");
			if (target.isRegister()) {
				nCode.add("STY " + target.getRegisterName());
				nCode.add("STA " + target.getRegisterName() + "+1");
			} else {
				nCode.add("STY " + target.getAddress());
				nCode.add("STA " + target.getAddress() + "+1");
			}
		} else {
			nCode.add("JSR POPREAL");
			if (target.isRegister()) {
				nCode.add("LDX #<" + target.getRegisterName());
				nCode.add("LDY #>" + target.getRegisterName());
			} else {
				nCode.add("LDX #<" + target.getAddress());
				nCode.add("LDY #>" + target.getAddress());
			}
			nCode.add("; FAC to (X/Y)");
			nCode.add("JSR FACMEM"); // FAC to (X/Y)
		}
	}
}
