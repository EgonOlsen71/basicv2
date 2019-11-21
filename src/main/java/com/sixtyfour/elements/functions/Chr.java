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
	
	/** 
	 * Actually, CHR$ is deterministic, of course. But because it creates a STRING as output but
	 * takes a number as input, the constant folder somehow would wrongly optimizes this
	 * (see TermOptimizer.optimizeTerm()). I'm not sure how to handle this case, so for now
	 * CHR$ is flagged as non-deterministic, which will work around this issue.
	 * 
	 * 
	 * @see com.sixtyfour.elements.functions.AbstractFunction#isDeterministic()
	 */
	@Override
	public boolean isDeterministic() {
		return false;
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
