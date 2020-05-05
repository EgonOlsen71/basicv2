package com.sixtyfour.extensions.x16.functions;

import java.util.List;

import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.functions.AbstractFunction;
import com.sixtyfour.system.Machine;

/**
 * The RND function.
 */
public class Joy extends AbstractFunction {

	/**
	 * Instantiates a new rnd.
	 */
	public Joy() {
		super("JOY");
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
		return Type.REAL;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		// This doesn't query anything and simply returns 0
		return 0f;
	}

	/*
	 * (non-Javadoc)
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
	 * @see com.sixtyfour.elements.functions.AbstractFunction#toCode(com.sixtyfour
	 * .system.Machine)
	 */
	@Override
	public String toCode(Machine machine) {
		return "0";
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.functions.AbstractFunction#getParameterCount()
	 */
	public int getParameterCount() {
		return 1;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.sixtyfour.elements.functions.AbstractFunction#addNativeFunctionCall(java.
	 * util.List)
	 */
	@Override
	public boolean addNativeFunctionCall(List<String> code) {
		code.add("JSR JOY");
		return true;
	}
}
