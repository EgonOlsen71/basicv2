package com.sixtyfour.elements.functions;

import com.sixtyfour.elements.Type;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The SQR function.
 */
public class Sqr extends AbstractFunction {

	/**
	 * Instantiates a new sqr.
	 */
	public Sqr() {
		super("SQR");
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
		if (!term.getType().equals(Type.STRING)) {
			float val = VarUtils.getFloat(term.eval(machine));
			if (val < 0) {
				throw new RuntimeException("Illegal quantity error: " + val);
			}
			return Float.valueOf((float) Math.sqrt(val));
		}
		throw new RuntimeException("Type mismatch error: " + term.getType());
	}
	
	 /* (non-Javadoc)
   * @see com.sixtyfour.elements.functions.AbstractFunction#toCode(com.sixtyfour.system.Machine)
   */
  @Override
  public String toCode(Machine machine) {
    String inter=term.toCode(machine);
    if (inter==null) {
      return null;
    }
    return "(float) Math.sqrt("+inter+")";
  }

}
