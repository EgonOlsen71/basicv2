package com.sixtyfour.extensions.x16.functions;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.functions.AbstractFunction;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * @author EgonOlsen
 *
 */
public class Vpeek extends AbstractFunction {

	/**
	 * Instantiates a new left.
	 */
	public Vpeek() {
		super("VPEEK");
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
		// This doesn't do anything with bank
		if (!getType().equals(Type.STRING)) {
			int addr = VarUtils.getInt(term.eval(machine));
			int peeked = Integer.valueOf(machine.getRam()[addr]) & 0xff;
			Integer peekedAsWell = machine.getMemoryListener().peek(addr);
			if (peekedAsWell != null) {
				peeked = peekedAsWell.intValue() & 0xff;
			}
			return peeked;
		}
		throw new RuntimeException("Type mismatch error: " + getType());
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.elements.functions.AbstractFunction#evalToExpression(com
	 * .sixtyfour.system.Machine)
	 */
	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		List<Atom> pars = Parser.getParameters(term);
		if (pars.size() != 2) {
			throw new RuntimeException("Wrong number of parameters: " + term);
		}
		Atom var = pars.get(1);
		List<String> ret = new ArrayList<String>();
		List<String> n1 = pars.get(0).evalToCode(config, machine).get(0).getExpression();
		n1.add(":PAR");
		n1.add("_");
		n1.addAll(var.evalToCode(config, machine).get(0).getExpression());
		n1.add(":" + this.getClass().getSimpleName().toUpperCase(Locale.ENGLISH));
		ret.addAll(0, n1);
		ret.add("_");

		List<CodeContainer> cc = new ArrayList<CodeContainer>();
		cc.add(new CodeContainer(ret));
		return cc;
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
	
	/* (non-Javadoc)
	 * @see com.sixtyfour.elements.functions.AbstractFunction#getParameterCount()
	 */
	public int getParameterCount() {
		return 2;
	}
	
	/**
	 * @param code
	 * @return
	 */
	@Override
	public boolean addNativeFunctionCall(List<String> code) {
		code.add("POP C");
		code.add("JSR VPEEK");
		return true;
	}

}
