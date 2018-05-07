package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import com.sixtyfour.Logger;
import com.sixtyfour.elements.Type;

public class Movb extends GeneratorBase {

	private static int MOV_CNT = 0;

	@Override
	public String getMnemonic() {
		return "MOVB";
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode, Map<String, String> name2label) {
		Operands ops = new Operands(line, name2label);
		Logger.log(line + " -- " + ops.getTarget() + "  |||  " + ops.getSource());

		MOV_CNT++;

		Operand source = ops.getSource();
		Operand target = ops.getTarget();

		context.setLastMoveSource(source);
		context.setLastMoveTarget(target);

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
				if (target.isRegister() && source.isConstant()) {
					indexedTargetWithConstant(nCode, source, target);
				} else {
					throw new RuntimeException("Invalid index mode (at least one side isn't a register and source isn't a constant value either!): " + line);
				}
			} else {
				if (target.isIndexed()) {
					indexedTarget(nCode, source, target);
				} else {
					indexedSource(nCode, source, target);
				}
			}
		}
	}

	private void indexedTargetWithConstant(List<String> nCode, Operand source, Operand target) {
		createIndexedTargetCode(nCode, target);

		nCode.add("LDA #$" + Integer.toHexString(Integer.parseInt(source.getValue().substring(1))).toUpperCase(Locale.ENGLISH));
		nCode.add("MOVBSELF" + MOV_CNT + ":");
		nCode.add("STA $FFFF");

	}

	private void createIndexedTargetCode(List<String> nCode, Operand target) {
		if (target.getType() == Type.INTEGER) {
			nCode.add("LDY " + target.getRegisterName());
			nCode.add("LDA " + createAddress(target.getRegisterName(), 1));
			nCode.add("STY TMP_REG");
			nCode.add("STA TMP_REG+1");
		} else {
			nCode.add("LDA #<" + target.getRegisterName());
			nCode.add("LDY #>" + target.getRegisterName());
			nCode.add("; Real in (A/Y) to FAC");
			nCode.add("JSR REALFAC"); // Real in (A/Y) to FAC

			nCode.add("; FAC to integer in Y/A");
			nCode.add("JSR FACWORD"); // FAC to integer in Y/A
			String lab = "MOVBSELF" + MOV_CNT;
			nCode.add("STY " + lab + "+1");
			nCode.add("STA " + lab + "+2");
		}
	}

	private void indexedSource(List<String> nCode, Operand source, Operand target) {
		createIndexedTargetCode(nCode, source);

		if (target.getType() == Type.INTEGER) {
			nCode.add("MOVBSELF" + MOV_CNT + ":");
			nCode.add("LDA $FFFF");
			nCode.add("STA " + target.getRegisterName());
			nCode.add("STY " + createAddress(target.getRegisterName(), 1));
		} else {
			nCode.add("MOVBSELF" + MOV_CNT + ":");
			nCode.add("LDY $FFFF");
			nCode.add("LDA #0");
			nCode.add("; integer in Y/A to FAC");
			nCode.add("JSR INTFAC"); // integer in A/Y to FAC

			nCode.add("LDX #<" + target.getRegisterName());
			nCode.add("LDY #>" + target.getRegisterName());
			nCode.add("; FAC to (X/Y)");
			nCode.add("JSR FACMEM"); // FAC to (X/Y)
		}
	}

	private void indexedTarget(List<String> nCode, Operand source, Operand target) {
		createIndexedTargetCode(nCode, target);

		if (source.getType() == Type.INTEGER) {
			nCode.add("LDA " + source.getRegisterName());
			nCode.add("MOVBSELF" + MOV_CNT + ":");
			nCode.add("STA $FFFF");
		} else {
			nCode.add("LDA #<" + source.getRegisterName());
			nCode.add("LDY #>" + source.getRegisterName());
			nCode.add("; Real in (A/Y) to FAC");
			nCode.add("JSR REALFAC"); // Real in (A/Y) to FAC

			nCode.add("; FAC to integer in Y/A");
			nCode.add("JSR FACWORD"); // FAC to integer in Y/A
			nCode.add("MOVBSELF" + MOV_CNT + ":");
			nCode.add("STY $FFFF");
		}
	}

	private void noIndexRealSource(List<String> nCode, Operand source, Operand target) {
		// Source is REAL
		if (source.isRegister()) {
			nCode.add("LDA #<" + source.getRegisterName());
			nCode.add("LDY #>" + source.getRegisterName());
		} else {
			checkSpecialReadVars(nCode, source);
			nCode.add("LDA #<" + source.getAddress());
			nCode.add("LDY #>" + source.getAddress());
		}
		nCode.add("; Real in (A/Y) to FAC");
		nCode.add("JSR REALFAC"); // Real in (A/Y) to FAC

		if (target.isAddress()) {
			nCode.add("; FAC to integer in Y/A");
			nCode.add("JSR FACWORD"); // FAC to integer in Y/A
			nCode.add("STY " + target.getAddress());
		} else {
			if (target.getType() == Type.INTEGER) {
				nCode.add("; FAC to integer in Y/A");
				nCode.add("JSR FACWORD"); // FAC to integer in Y/A
				nCode.add("STY " + target.getRegisterName());
				nCode.add("STA " + this.createAddress(target.getRegisterName(), 1));
			} else {
				nCode.add("LDX #<" + target.getRegisterName());
				nCode.add("LDY #>" + target.getRegisterName());
				nCode.add("; FAC to (X/Y)");
				nCode.add("JSR FACMEM"); // FAC to (X/Y)
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
			nCode.add("JSR INTFAC"); // integer in Y/A to FAC

			if (target.isAddress()) {
				nCode.add("; FAC to integer in Y/A");
				nCode.add("JSR FACWORD"); // FAC to integer in Y/A
				nCode.add("STY " + target.getAddress());
			} else {
				if (target.getType() == Type.INTEGER) {
					nCode.add("; FAC to integer in Y/A");
					nCode.add("JSR FACWORD"); // FAC to integer in Y/A
					nCode.add("STY " + target.getRegisterName());
					nCode.add("STA " + this.createAddress(target.getRegisterName(), 1));
				} else {
					nCode.add("LDX #<" + target.getRegisterName());
					nCode.add("LDY #>" + target.getRegisterName());
					nCode.add("; FAC to (X/Y)");
					nCode.add("JSR FACMEM"); // FAC to (X/Y)
				}
			}
		}
	}
}
