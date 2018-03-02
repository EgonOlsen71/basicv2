package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.Logger;

/**
 * @author EgonOlsen
 * 
 */
public abstract class MathFunction implements Generator {

	private String comment = null;
	private String systemCall = null;
	private String mnemonic = null;

	protected MathFunction(String mnemonic, String comment, String systemCall) {
		this.mnemonic = mnemonic;
		this.comment = comment;
		this.systemCall = systemCall;
	}

	@Override
	public String getMnemonic() {
		return mnemonic;
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode, Map<String, String> name2label) {
		Operands ops = new Operands(line, name2label);
		Logger.log(line + " -- " + ops.getTarget() + "  <op>  " + ops.getSource());

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
		nCode.add("JSR $BBA2"); // Real in (A/Y) to FAC

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
		nCode.add("JSR $BBD7"); // FAC to (X/Y)
	}

}
