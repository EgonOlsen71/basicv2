package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.Generator;
import com.sixtyfour.cbmnative.GeneratorContext;
import com.sixtyfour.elements.Type;

public abstract class Compare implements Generator {

	protected static int CNT = 0;
	protected String mnemonic = null;
	protected String command;

	protected Compare(String mnemonic, String command) {
		this.mnemonic = mnemonic;
		this.command = command;
	}

	@Override
	public String getMnemonic() {
		return mnemonic;
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode, Map<String, String> name2label) {
		Operands ops = new Operands(line, name2label);
		// Logger.log(line + " -- " + ops.getTarget() + "  |||  " +
		// ops.getSource());

		Operand source = ops.getSource();
		Operand target = ops.getTarget();

		if (!source.isIndexed() && !target.isIndexed()) {
			if (source.getType() != Type.REAL || target.getType() != Type.REAL) {
				throw new RuntimeException("Invalid comparison: " + line);
			}
			noIndexRealSource(nCode, source, target);

		} else {
			throw new RuntimeException("Invalid indexing mode: " + line);
		}

		nCode.add(mnemonic + "_SKIP" + CNT + ":");
		nCode.add("; Real in (A/Y) to FAC");
		nCode.add("JSR REALFAC"); // Real in (A/Y) to FAC
		if (target.isRegister()) {
			nCode.add("LDX #<" + target.getRegisterName());
			nCode.add("LDY #>" + target.getRegisterName());
		} else {
			nCode.add("LDX #<" + target.getAddress());
			nCode.add("LDY #>" + target.getAddress());
		}
		nCode.add("; FAC to (X/Y)");
		nCode.add("JSR FACMEM"); // FAC to (X/Y)
		CNT++;
	}

	protected void noIndexRealSource(List<String> nCode, Operand source, Operand target) {
		// Source is REAL
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
		nCode.add("; CMPFAC with (A/Y)");
		nCode.add("JSR CMPFAC"); // CMPFAC with (A/Y)

		doCompare(nCode);
	}

	protected void doCompare(List<String> nCode) {
		nCode.add(command + " " + mnemonic + "_" + mnemonic + CNT);
		nCode.add("LDA #<REAL_CONST_ZERO");
		nCode.add("LDY #>REAL_CONST_ZERO");
		nCode.add("JMP " + mnemonic + "_SKIP" + CNT);
		nCode.add(mnemonic + "_" + mnemonic + CNT + ":");
		nCode.add("LDA #<REAL_CONST_MINUS_ONE");
		nCode.add("LDY #>REAL_CONST_MINUS_ONE");
	}
}
