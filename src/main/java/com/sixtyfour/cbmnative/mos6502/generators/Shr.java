package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.GeneratorContext;
import com.sixtyfour.cbmnative.Operand;
import com.sixtyfour.cbmnative.Operands;

/**
 * @author EgonOlsen
 * 
 */
public class Shr extends Calculation {

	public Shr() {
		super("SHR", "; FAC = FAC>>A", "JSR SHR");
	}

	protected Shr(String mnemonic, String comment, String systemCall) {
		super(mnemonic, comment, systemCall);
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
			Map<String, String> name2label) {
		Operands ops = new Operands(line, name2label);
		// Logger.log(line + " -- " + ops.getTarget() + " <op> " +
		// ops.getSource());
		Operand target = ops.getTarget();

		if (target.isRegister()) {
			nCode.add("LDA #<" + target.getRegisterName());
			nCode.add("LDY #>" + target.getRegisterName());
		} else {
			nCode.add("LDA #<" + target.getAddress());
			nCode.add("LDY #>" + target.getAddress());
		}

		nCode.add("; Real in (A/Y) to FAC");
		nCode.add("JSR REALFAC"); // Real in (A/Y) to FAC

		nCode.add(comment);
		nCode.add(systemCall);

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
