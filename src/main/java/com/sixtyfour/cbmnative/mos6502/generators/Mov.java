package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.GeneratorContext;
import com.sixtyfour.cbmnative.Operand;
import com.sixtyfour.cbmnative.Operands;
import com.sixtyfour.elements.Type;

public class Mov extends GeneratorBase {

	private static int MOV_CNT = 0;

	@Override
	public String getMnemonic() {
		return "MOV";
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
			Map<String, String> name2label) {
		Operands ops = new Operands(line, name2label);
		// Logger.log(line + " -- " + ops.getTarget() + " ||| " +
		// ops.getSource());

		Operand source = ops.getSource();
		Operand target = ops.getTarget();

		context.setLastMoveSource(source);
		context.setLastMoveTarget(target);

		if (!source.isIndexed() && !target.isIndexed()) {
			if (source.getType() == Type.STRING) {
				if (source.isArray()) {
					sourceStringArray(nCode, source, target);
				} else {
					sourceString(nCode, source, target);
				}
			} else if (target.getType() == Type.STRING) {
				targetString(nCode, source, target);
			} else if (source.isArray()) {
				noIndexArraySource(nCode, source, target);
			} else {
				if (source.getType() == Type.INTEGER) {
					noIndexIntegerSource(nCode, source, target);
				} else {
					noIndexRealSource(nCode, source, target);
				}
			}
		} else {
			if (target.getType() == Type.INTEGER) {
				indexedTargetInteger(nCode, source, target);
			} else {
				if (source.isIndexed() && source.isRegister()) {
					indexedSourceTargetReal(nCode, source, target);
				} else {
					throw new RuntimeException("Invalid index mode: " + line);
				}
			}
		}
	}

	private void targetString(List<String> nCode, Operand source, Operand target) {
		if (source.isRegister()) {
			nCode.add("LDA " + source.getRegisterName());
			nCode.add("LDY " + createAddress(source.getRegisterName(), 1));
		} else {
			nCode.add("LDA " + source.getAddress());
			nCode.add("LDY " + createAddress(source.getAddress(), 1));
		}

		nCode.add("STA TMP_ZP");
		nCode.add("STY TMP_ZP+1");

		if (!checkSpecialWriteVars(nCode, target)) {
			if (target.isRegister()) {
				nCode.add("LDA #<" + target.getRegisterName());
				nCode.add("LDY #>" + target.getRegisterName());
			} else {
				nCode.add("LDA #<" + target.getAddress());
				nCode.add("LDY #>" + target.getAddress());
			}
			nCode.add("JSR COPYSTRING");
		}
	}

	private void sourceString(List<String> nCode, Operand source, Operand target) {
		if (source.isConstant()) {
			nCode.add("LDA #<" + source.getAddress());
			nCode.add("LDY #>" + source.getAddress());
		} else {
			checkSpecialReadVars(nCode, source);
			nCode.add("LDA " + source.getAddress());
			nCode.add("LDY " + createAddress(source.getAddress(), 1));
		}
		nCode.add("STA " + target.getRegisterName());
		nCode.add("STY " + createAddress(target.getRegisterName(), 1));
	}

	private void sourceStringArray(List<String> nCode, Operand source, Operand target) {
		if (source.isConstant()) {
			nCode.add("LDA #<" + source.getAddress());
			nCode.add("LDY #>" + source.getAddress());
		} else {
			checkSpecialReadVars(nCode, source);
			nCode.add("LDA #<" + source.getAddress());
			nCode.add("LDY #>" + source.getAddress());
		}
		nCode.add("STA " + target.getRegisterName());
		nCode.add("STY " + createAddress(target.getRegisterName(), 1));
	}

	private void noIndexArraySource(List<String> nCode, Operand source, Operand target) {
		if (source.isRegister()) {
			nCode.add("LDA #<" + source.getRegisterName());
			nCode.add("LDY #>" + source.getRegisterName());
		} else {
			nCode.add("LDA #<" + source.getAddress());
			nCode.add("LDY #>" + source.getAddress());
		}

		if (target.isRegister()) {
			nCode.add("STA " + target.getRegisterName());
			nCode.add("STY " + createAddress(target.getRegisterName(), 1));
		} else {
			nCode.add("STA " + target.getAddress());
			nCode.add("STY " + createAddress(target.getAddress(), 1));
		}
	}

	private void indexedTargetInteger(List<String> nCode, Operand source, Operand target) {
		if (source.isRegister()) {
			nCode.add("LDA #<" + source.getRegisterName());
			nCode.add("LDY #>" + source.getRegisterName());
		} else {
			nCode.add("LDA #<" + source.getAddress());
			nCode.add("LDY #>" + source.getAddress());
		}

		if (target.isRegister()) {
			nCode.add("STA " + target.getRegisterName());
			nCode.add("STY " + createAddress(target.getRegisterName(), 1));
		} else {
			nCode.add("STA " + target.getAddress());
			nCode.add("STY " + createAddress(target.getAddress(), 1));
		}
	}

	private void indexedSourceTargetReal(List<String> nCode, Operand source, Operand target) {
		if (source.isRegister()) {
			nCode.add("LDA #<" + source.getRegisterName());
			nCode.add("LDY #>" + source.getRegisterName());
		} else {
			nCode.add("LDA #<" + source.getAddress());
			nCode.add("LDY #>" + source.getAddress());
		}

		nCode.add("; Real in (A/Y) to FAC");
		nCode.add("JSR REALFAC"); // Real in (A/Y) to FAC
		nCode.add("JSR FACWORD"); // FAC to integer in Y/A

		String lab = "MOVSELF" + (MOV_CNT++);
		nCode.add("STY " + lab + "+1");

		nCode.add("STA " + lab + "+2");
		nCode.add(lab + ":");
		nCode.add("LDA $FFFF");
		nCode.add("TAY");
		nCode.add("LDA #0");

		if (target.getType() == Type.REAL) {
			nCode.add("; integer in Y/A to FAC");
			nCode.add("JSR INTFAC"); // integer in A/Y to FAC

			if (target.isRegister()) {
				nCode.add("LDX #<" + target.getRegisterName());
				nCode.add("LDY #>" + target.getRegisterName());
			} else {
				nCode.add("LDX #<" + target.getAddress());
				nCode.add("LDY #>" + target.getAddress());
			}
			nCode.add("; FAC to (X/Y)");
			nCode.add("JSR FACMEM"); // FAC to (X/Y)
		} else {
			if (target.isRegister()) {
				nCode.add("STY " + target.getRegisterName());
				nCode.add("STA " + createAddress(target.getRegisterName(), 1));
			} else {
				nCode.add("STY " + target.getAddress());
				nCode.add("STA " + createAddress(target.getAddress(), 1));
			}
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

		if (target.getType() == Type.INTEGER) {
			nCode.add("; FAC to integer in Y/A");
			nCode.add("JSR FACINT"); // FAC to integer in A/Y

			if (target.isRegister()) {
				nCode.add("STY " + target.getRegisterName());
				nCode.add("STA " + createAddress(target.getRegisterName(), 1));
			} else {
				nCode.add("STY " + target.getAddress());
				nCode.add("STA " + createAddress(target.getAddress(), 1));
			}
		} else {
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

	private void noIndexIntegerSource(List<String> nCode, Operand source, Operand target) {
		// Source is INTEGER

		if (source.isRegister()) {
			nCode.add("LDY " + source.getRegisterName());
			nCode.add("LDA " + createAddress(source.getRegisterName(), 1));
		} else {
			nCode.add("LDY " + source.getAddress());
			nCode.add("LDA " + createAddress(source.getAddress(), 1));
		}

		if (target.getType() == Type.INTEGER) {
			if (target.isRegister()) {
				nCode.add("STY " + target.getRegisterName());
				nCode.add("STA " + createAddress(target.getRegisterName(), 1));
			} else {
				nCode.add("STY " + target.getAddress());
				nCode.add("STA " + createAddress(target.getAddress(), 1));
			}
		} else {
			nCode.add("; integer in Y/A to FAC");
			nCode.add("JSR INTFAC"); // integer in A/Y to FAC

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
