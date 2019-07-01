package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.Generator;
import com.sixtyfour.cbmnative.GeneratorContext;
import com.sixtyfour.cbmnative.Operand;
import com.sixtyfour.cbmnative.Operands;

/**
 * @author EgonOlsen
 * 
 */
public abstract class Calculation implements Generator {

	protected String comment = null;
	protected String systemCall = null;
	protected String mnemonic = null;
	protected boolean skipArgTransfer = false;

	protected Calculation(String mnemonic, String comment, String systemCall) {
		this.mnemonic = mnemonic;
		this.comment = comment;
		this.systemCall = systemCall;
		this.skipArgTransfer = false;
	}

	protected Calculation(String mnemonic, String comment, String systemCall, boolean skipArgTransfer) {
		this.mnemonic = mnemonic;
		this.comment = comment;
		this.systemCall = systemCall;
		this.skipArgTransfer = skipArgTransfer;
	}

	@Override
	public String getMnemonic() {
		return mnemonic;
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
			Map<String, String> name2label) {
		Operands ops = new Operands(line, name2label);
		// Logger.log(line + " -- " + ops.getTarget() + " <op> " +
		// ops.getSource());

		Operand source = ops.getSource();
		Operand target = ops.getTarget();

		if (source.isRegister()) {
			nCode.add("LDA #<" + source.getRegisterName());
			nCode.add("LDY #>" + source.getRegisterName());
		} else {
			nCode.add("LDA #<" + source.getAddress());
			nCode.add("LDY #>" + source.getAddress());
		}

		nCode.add("; Real in (A/Y) to FAC");
		nCode.add("JSR REALFAC"); // Real in (A/Y) to FAC

		if (target.isRegister()) {
			nCode.add("LDA #<" + target.getRegisterName());
			nCode.add("LDY #>" + target.getRegisterName());
		} else {
			nCode.add("LDA #<" + target.getAddress());
			nCode.add("LDY #>" + target.getAddress());
		}
		
		if (!skipArgTransfer) {
			nCode.add("; Real in (A/Y) to ARG");
			nCode.add("JSR MEMARG"); // Real in (A/Y) to ARG
		}
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
