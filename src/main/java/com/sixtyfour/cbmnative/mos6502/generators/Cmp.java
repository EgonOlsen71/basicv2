package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.Logger;
import com.sixtyfour.elements.Type;

public class Cmp extends GeneratorBase {

	private static int CNT = 0;

	@Override
	public String getMnemonic() {
		return "CMP";
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode, Map<String, String> name2label) {
		Operands ops = new Operands(line, name2label);
		Logger.log(line + " -- " + ops.getTarget() + "  |||  " + ops.getSource());

		Operand source = ops.getSource();
		Operand target = ops.getTarget();

		if (!source.isIndexed() && !target.isIndexed()) {
			if (source.getType() == Type.INTEGER) {
				noIndexIntegerSource(nCode, source, target);
			} else {
				noIndexRealSource(nCode, source, target);
			}
		} else {
			throw new RuntimeException("Invalid indexing mode: " + line);
		}
		nCode.add("COMP_SKP" + CNT + ":");
		CNT++;
	}

	private void noIndexRealSource(List<String> nCode, Operand source, Operand target) {
		// Source is REAL
		if (source.isRegister()) {
			nCode.add("LDA #<" + source.getRegisterName());
			nCode.add("LDY #>" + source.getRegisterName());
		} else {
			nCode.add("LDA #<" + source.getAddress());
			nCode.add("LDY #>" + source.getAddress());
		}
		nCode.add("; Real in (A/Y) to FAC");
		nCode.add("JSR $BBA2"); // Real in (A/Y) to FAC

		if (target.getType() == Type.INTEGER) {
			nCode.add("; FAC to integer in Y/A");
			nCode.add("JSR $B1AA"); // FAC to integer in A/Y

			if (target.isRegister()) {
				nCode.add("CPY " + target.getRegisterName());
				nCode.add("BNE COMP_SKP" + CNT);
				nCode.add("CMP " + createAddress(target.getRegisterName(), 1));
				nCode.add("BNE COMP_SKP" + CNT);

			} else {
				nCode.add("CPY " + target.getAddress());
				nCode.add("BNE COMP_SKP" + CNT);
				nCode.add("CMP " + createAddress(target.getAddress(), 1));
				nCode.add("BNE COMP_SKP" + CNT);
			}
		} else {
			if (target.isRegister()) {
				nCode.add("LDA #<" + target.getRegisterName());
				nCode.add("LDY #>" + target.getRegisterName());
			} else {
				nCode.add("LDA #<" + target.getAddress());
				nCode.add("LDY #>" + target.getAddress());
			}
			nCode.add("; CMPFAC with (A/Y)");
			nCode.add("JSR $BC5B"); // CMPFAC with (A/Y)
		}
	}

	private void noIndexIntegerSource(List<String> nCode, Operand source, Operand target) {
		if (source.isRegister()) {
			nCode.add("LDY " + source.getRegisterName());
			nCode.add("LDA " + createAddress(source.getRegisterName(), 1));
		} else {
			nCode.add("LDY " + source.getAddress());
			nCode.add("LDA " + createAddress(source.getAddress(), 1));
		}

		if (target.getType() == Type.INTEGER) {
			if (target.isRegister()) {
				nCode.add("CPY " + target.getRegisterName());
				nCode.add("BNE COMP_SKP" + CNT);
				nCode.add("CMP " + createAddress(target.getRegisterName(), 1));
				nCode.add("BNE COMP_SKP" + CNT);

			} else {
				nCode.add("CPY " + target.getAddress());
				nCode.add("BNE COMP_SKP" + CNT);
				nCode.add("CMP " + createAddress(target.getAddress(), 1));
				nCode.add("BNE COMP_SKP" + CNT);
			}
		} else {
			nCode.add("; integer in Y/A to FAC");
			nCode.add("JSR $B391"); // integer in A/Y to FAC

			if (target.isRegister()) {
				nCode.add("LDA #<" + target.getRegisterName());
				nCode.add("LDY #>" + target.getRegisterName());
			} else {
				nCode.add("LDA #<" + target.getAddress());
				nCode.add("LDY #>" + target.getAddress());
			}
			nCode.add("; CMPFAC with (A/Y)");
			nCode.add("JSR $BC5B"); // CMPFAC with (A/Y)
		}
	}
}
