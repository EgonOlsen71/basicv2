package com.sixtyfour.cbmnative.python.generators;

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
public class MovPy extends GeneratorBasePy {

	@Override
	public String getMnemonic() {
		return "MOV";
	}

	@Override
	public void generateCode(GeneratorContext context, String line, List<String> nCode, List<String> subCode,
			Map<String, String> name2label) {
		Operands ops = new Operands(line, name2label);

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

		truncInteger(nCode, target);
	}

	private void targetString(List<String> nCode, Operand source, Operand target) {
		if (!checkSpecialWriteVars(nCode, target, source)) {
			String from = getOpName(source);
			String to = getOpName(target);
			nCode.add(to + "=" + from);
		}
	}

	private void sourceString(List<String> nCode, Operand source, Operand target) {
		if (!checkSpecialReadVars(nCode, target, source)) {
			String from = getOpName(source);
			String to = getOpName(target);
			nCode.add(to + "=" + from);
		} else {
			String to = getOpName(target);
			nCode.add(to + "=tmpy");
		}
	}

	private void sourceStringArray(List<String> nCode, Operand source, Operand target) {
		sourceString(nCode, source, target);
	}

	private void noIndexArraySource(List<String> nCode, Operand source, Operand target) {
		String from = getOpName(source);
		String to = getOpName(target);
		nCode.add(to + "=" + from);
	}

	private void indexedTargetInteger(List<String> nCode, Operand source, Operand target) {
		String from = getOpName(source);
		String to = getOpName(target);
		nCode.add("_memory[" + to + "]" + "=" + from);
	}

	private void indexedSourceTargetReal(List<String> nCode, Operand source, Operand target) {
		String from = getOpName(source);
		String to = getOpName(target);
		nCode.add(to + "=" + "_memory[" + from + "]");
	}

	private void noIndexRealSource(List<String> nCode, Operand source, Operand target) {
		if (!checkSpecialReadVars(nCode, target, source)) {
			noIndexArraySource(nCode, source, target);
		} else {
			String to = getOpName(target);
			nCode.add(to + "=tmpy");
		}
	}

	private void noIndexIntegerSource(List<String> nCode, Operand source, Operand target) {
		noIndexArraySource(nCode, source, target);
	}

}
