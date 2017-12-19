package com.sixtyfour.cbmnative.mos6502.generators;

import java.util.Locale;
import java.util.Map;

import com.sixtyfour.elements.Type;

/**
 * @author EgonOlsen
 * 
 */
public class Operands {
	private Operand target;
	private Operand source;

	public Operands(String command, Map<String, String> name2label) {
		int pos = command.indexOf(" ");
		if (pos == -1) {
			throw new RuntimeException("Can't parse command: " + command);
		}

		command = command.substring(pos).trim();

		pos = command.indexOf(",");
		if (pos == -1) {
			throw new RuntimeException("Can't parse command: " + command);
		}
		String left = command.substring(0, pos).trim();
		String right = command.substring(pos + 1).trim();

		target = new Operand();
		source = new Operand();

		fill(target, left, name2label);
		fill(source, right, name2label);
	}

	public Operand getTarget() {
		return target;
	}

	public void setTarget(Operand target) {
		this.target = target;
	}

	public Operand getSource() {
		return source;
	}

	public void setSource(Operand source) {
		this.source = source;
	}

	private void fill(Operand op, String txt, Map<String, String> name2label) {
		op.setIndexed(false);
		op.setAddress(null);
		op.setRegister(null);
		op.setType(getType(txt));

		if (txt.length() == 1) {
			op.setRegister(txt.toUpperCase(Locale.ENGLISH));
		} else {
			if (txt.startsWith("(")) {
				op.setIndexed(true);
				if (txt.endsWith("})")) {
					txt = removeBrackets(txt);
					String label = name2label.get(txt);
					op.setAddress(label == null ? txt : label);
				} else {
					txt = removeBrackets(txt);
					op.setRegister(txt);
				}
			} else {
				txt = removeBrackets(txt);
				String label = name2label.get(txt);
				op.setAddress(label == null ? txt : label);
			}
		}
	}

	private Type getType(String txt) {
		int end = txt.lastIndexOf("}");
		int start = txt.lastIndexOf("{");
		if (start != -1 && end != -1 && start + 1 != end) {
			return Type.valueOf(txt.substring(start + 1, end));
		}
		if (txt.contains(".")) {
			return Type.REAL;
		}
		return Type.INTEGER;
	}

	private String removeBrackets(String txt) {
		txt = txt.replace("(", "").replace(")", "");
		int pos = txt.indexOf("{");
		if (pos != -1) {
			txt = txt.substring(0, pos);
		}
		return txt;
	}

}
