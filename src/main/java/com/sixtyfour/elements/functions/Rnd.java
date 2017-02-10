package com.sixtyfour.elements.functions;

import com.sixtyfour.elements.Type;
import com.sixtyfour.system.Machine;

/**
 * The RND function.
 */
public class Rnd extends AbstractFunction {

	/**
	 * Instantiates a new rnd.
	 */
	public Rnd() {
		super("RND");
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		return (float) Math.random();
	}
	
	 /* (non-Javadoc)
   * @see com.sixtyfour.elements.functions.AbstractFunction#toCode(com.sixtyfour.system.Machine)
   */
  @Override
  public String toCode(Machine machine) {
    return "(float) Math.random()";
  }
}
