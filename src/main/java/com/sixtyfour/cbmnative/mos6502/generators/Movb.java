package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.Logger;
import com.sixtyfour.elements.Type;

public class Movb extends GeneratorBase {

	@Override
	public String getMnemonic() {
		return "MOVB";
	}

	@Override
	public void generateCode(String line, List<String> nCode, List<String> subCode, Map<String, String> name2label) {
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
			if (target.isIndexed() && source.isIndexed()) {
				throw new RuntimeException("Invalid index mode (both sides are indexed!): " + line);
			}

			if (!target.isRegister() || !source.isRegister()) {
				throw new RuntimeException("Invalid index mode (at least one side isn't a register!): " + line);
			}
			if (target.isIndexed()) {
				indexedTarget(nCode, source, target);
			} else {
				indexedSource(nCode, source, target);
			}
		}
	}

	private void indexedSource(List<String> nCode, Operand source, Operand target) {
		if (source.getType() == Type.INTEGER) {
			nCode.add("LDY " + source.getRegisterName());
			nCode.add("LDA " + createAddress(source.getRegisterName(), 1));
			nCode.add("STY TMP_REG");
			nCode.add("STA TMP_REG+1");
		} else {
			nCode.add("LDA #<" + source.getRegisterName());
			nCode.add("LDY #>" + source.getRegisterName());
			nCode.add("; Real in (A/Y) to FAC");
			nCode.add("JSR $BBA2"); // Real in (A/Y) to FAC

			nCode.add("; FAC to integer in Y/A");
			nCode.add("JSR $B7F7"); // FAC to integer in Y/A
			nCode.add("STY " + TMP_ZP);
			nCode.add("STA " + (TMP_ZP + 1));
		}

		nCode.add("LDY #0");
		if (target.getType() == Type.INTEGER) {
			nCode.add("LDA (" + TMP_ZP + "), Y");
			nCode.add("STA " + target.getRegisterName());
			nCode.add("STY " + createAddress(target.getRegisterName(), 1));
		} else {
			nCode.add("LDA (" + TMP_ZP + "), Y");
			nCode.add("TAY");
			nCode.add("LDA #0");
			nCode.add("; integer in Y/A to FAC");
			nCode.add("JSR $B391"); // integer in A/Y to FAC

			nCode.add("LDX #<" + target.getRegisterName());
			nCode.add("LDY #>" + target.getRegisterName());
			nCode.add("; FAC to (X/Y)");
			nCode.add("JSR $BBD7"); // FAC to (X/Y)
		}
	}

	private void indexedTarget(List<String> nCode, Operand source, Operand target) {
		if (target.getType() == Type.INTEGER) {
			nCode.add("LDY " + target.getRegisterName());
			nCode.add("LDA " + createAddress(target.getRegisterName(), 1));
			nCode.add("STY TMP_REG");
			nCode.add("STA TMP_REG+1");
		} else {
			nCode.add("LDA #<" + target.getRegisterName());
			nCode.add("LDY #>" + target.getRegisterName());
			nCode.add("; Real in (A/Y) to FAC");
			nCode.add("JSR $BBA2"); // Real in (A/Y) to FAC

			nCode.add("; FAC to integer in Y/A");
			nCode.add("JSR $B7F7"); // FAC to integer in Y/A
			nCode.add("STY " + TMP_ZP);
			nCode.add("STA " + (TMP_ZP + 1));
		}

		if (source.getType() == Type.INTEGER) {
			nCode.add("LDA " + source.getRegisterName());
			nCode.add("LDY #0");
			nCode.add("STA (" + TMP_ZP + "),Y");
		} else {
			nCode.add("LDA #<" + source.getRegisterName());
			nCode.add("LDY #>" + source.getRegisterName());
			nCode.add("; Real in (A/Y) to FAC");
			nCode.add("JSR $BBA2"); // Real in (A/Y) to FAC

			nCode.add("; FAC to integer in Y/A");
			nCode.add("JSR $B7F7"); // FAC to integer in Y/A
			nCode.add("TYA");
			nCode.add("LDY #0");
			nCode.add("STA (" + TMP_ZP + "),Y");
		}
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

		if (target.isAddress()) {
			nCode.add("; FAC to integer in Y/A");
			nCode.add("JSR $B7F7"); // FAC to integer in Y/A
			nCode.add("STY " + target.getAddress());
		} else {
			if (target.getType() == Type.INTEGER) {
				nCode.add("; FAC to integer in Y/A");
				nCode.add("JSR $B7F7"); // FAC to integer in Y/A
				nCode.add("STY " + target.getRegisterName());
				nCode.add("STA " + this.createAddress(target.getRegisterName(), 1));
			} else {
				nCode.add("LDX #<" + target.getRegisterName());
				nCode.add("LDY #>" + target.getRegisterName());
				nCode.add("; FAC to (X/Y)");
				nCode.add("JSR $BBD7"); // FAC to (X/Y)
			}
		}
	}

	private void noIndexIntegerSource(List<String> nCode, Operand source, Operand target) {
		// Source is INTEGER
		if (source.isRegister()) {
			nCode.add("LDY " + source.getRegisterName());
			nCode.add("LDA #0");
		} else {
			nCode.add("LDY " + source.getAddress());
			nCode.add("LDA #0");
		}

		if (target.getType() == Type.INTEGER) {
			nCode.add("STY " + target.getAddress());
		} else {
			nCode.add("; integer in Y/A to FAC");
			nCode.add("JSR $B391"); // integer in Y/A to FAC

			if (target.isAddress()) {
				nCode.add("; FAC to integer in Y/A");
				nCode.add("JSR $B7F7"); // FAC to integer in Y/A
				nCode.add("STY " + target.getAddress());
			} else {
				if (target.getType() == Type.INTEGER) {
					nCode.add("; FAC to integer in Y/A");
					nCode.add("JSR $B7F7"); // FAC to integer in Y/A
					nCode.add("STY " + target.getRegisterName());
					nCode.add("STA " + this.createAddress(target.getRegisterName(), 1));
				} else {
					nCode.add("LDX #<" + target.getRegisterName());
					nCode.add("LDY #>" + target.getRegisterName());
					nCode.add("; FAC to (X/Y)");
					nCode.add("JSR $BBD7"); // FAC to (X/Y)
				}
			}
		}
	}
}
