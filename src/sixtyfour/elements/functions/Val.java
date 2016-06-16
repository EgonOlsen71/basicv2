package sixtyfour.elements.functions;

import sixtyfour.elements.Type;
import sixtyfour.system.Machine;

public class Val extends AbstractFunction {

	public Val() {
		super("VAL");
	}

	@Override
	public Type getType() {
		return Type.REAL;
	}

	@Override
	public Object eval(Machine memory) {
		if (!term.getType().equals(Type.STRING)) {
			throw new RuntimeException("Type mismatch error: " + term.getType());
		}
		String str = (String) term.eval(memory);
		if (str == null) {
			return 0;
		}

		StringBuilder sb = new StringBuilder();
		boolean hasPoint = false;
		boolean hasE = false;
		boolean hasSign = false;
		for (int i = 0; i < str.length(); i++) {
			char c = str.charAt(i);
			if (Character.isDigit(c)) {
				sb.append(c);
			} else {
				if ((i == 0 || (!hasSign && hasE)) && c == '-' || c == '+') {
					sb.append(c);
					if (hasE) {
						hasSign = true;
					}
				} else if (c == '.' && !hasPoint) {
					sb.append(c);
					hasPoint = true;
				} else if (c == 'e' && !hasE) {
					sb.append(c);
					hasE = true;
				} else {
					break;
				}
			}
		}
		try {
			return Float.valueOf(sb.toString());
		} catch (Exception e) {
			return 0f;
		}

	}
}
