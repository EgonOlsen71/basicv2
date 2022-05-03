package com.sixtyfour.elements.functions;

import com.sixtyfour.elements.Type;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The CHR function.
 */
public class Chr extends AbstractFunction {

	/**
	 * Instantiates a new chr.
	 */
	public Chr() {
		super("CHR$");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		return Type.STRING;
	}

	@Override
	public Type getParameterType() {
		return Type.REAL;
	}

	/**
	 * The term optimizer can't handle CHR$ properly, because its result is platform
	 * dependant so that an eval on the cross compiling machine isn't the best idea.
	 * So we simply ignore it. That shouldn't really matter anyway.
	 * 
	 * @see com.sixtyfour.elements.functions.AbstractFunction#isExcluded()
	 */
	@Override
	public boolean isExcluded() {
		return true;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		if (term.getType().equals(Type.STRING)) {
			typeMismatch(term.getType());
		}
		Integer num = VarUtils.getInt(term.eval(machine));
		if (num < 0 || num > 255) {
			throw new RuntimeException("Illegal quantity error: " + num);
		}
		return Character.toString(getConvertedChar((char) num.intValue()));
	}

	private char getConvertedChar(char c) {
		if (c >= 'a' && c <= 'z') {
			c = (char) ((int) c - 32);
		} else if (c >= 'A' && c <= 'Z') {
			c = (char) ((int) c + 32);
		}
		return c;
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
