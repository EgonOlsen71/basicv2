package com.sixtyfour.elements.functions;

import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Term;
import com.sixtyfour.system.Machine;

/**
 * The VAL function.
 */
public class Val extends AbstractFunction {

	/**
	 * Instantiates a new val.
	 */
	public Val() {
		super("VAL");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		return Type.REAL;
	}

	@Override
	public Type getParameterType() {
		return Type.STRING;
	}
	
	@Override
	public void setTerm(Term term) {
		this.term = term;
	}
	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		if (!term.getType().equals(Type.STRING)) {
			typeMismatch(term.getType());
		}
		String str = (String) term.eval(machine);
		if (str == null) {
			return 0;
		}

		StringBuilder sb = new StringBuilder();
		boolean hasPoint = false;
		boolean hasE = false;
		boolean hasSign = false;
		str = str.trim();
		for (int i = 0; i < str.length(); i++) {
			char c = str.charAt(i);
			if (c==' ') {
				// VAL ignores SPACE
				continue;
			}
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
			return Double.valueOf(sb.toString());
		} catch (Exception e) {
			return 0f;
		}

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.functions.AbstractFunction#getParameterCount()
	 */
	public int getParameterCount() {
		return 1;
	}

}
