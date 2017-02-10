package com.sixtyfour.elements.functions;

import com.sixtyfour.elements.Type;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The ABS function.
 */
public class Abs extends AbstractFunction {

	/**
	 * Instantiates a new abs.
	 */
	public Abs() {
		super("ABS");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		return term.getType();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		if (!term.getType().equals(Type.STRING)) {
			float val = Math.abs(VarUtils.getFloat(term.eval(machine)));
			if (term.getType().equals(Type.REAL)) {
				return val;
			} else {
				return (int) val;
			}
		}
		throw new RuntimeException("Formula too complex error: " + this);
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
    return (term.getType().equals(Type.REAL)?"(float)":"(int)")+ "Math.abs("+inter+")";
  }

}
