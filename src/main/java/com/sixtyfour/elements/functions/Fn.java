package com.sixtyfour.elements.functions;

import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.elements.commands.Def;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The FN function. These functions can be defined in the basic code by DEF
 * FN...
 */
public class Fn extends AbstractFunction {

	/**
	 * Instantiates a new fn.
	 */
	public Fn() {
		super("FN");
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
		Def def = (Def) machine.getFunction(this.functionName);
		if (def == null) {
			throw new RuntimeException("Undef'd function error: " + this + "/" + this.functionName);
		}
		if (term.getType().equals(Type.STRING)) {
		  typeMismatch(this);
		}
		Object val = term.eval(machine);
		Variable placeHolder = machine.getVariable(def.getVarName());
		placeHolder.setValue(VarUtils.getFloat(val));
		return def.eval(machine);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.functions.AbstractFunction#hasPostfix()
	 */
	@Override
	public boolean hasPostfix() {
		return true;
	}

}
