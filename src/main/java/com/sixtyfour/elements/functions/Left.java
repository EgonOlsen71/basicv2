package com.sixtyfour.elements.functions;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The LEFT function.
 */
public class Left extends AbstractFunction {

	/**
	 * Instantiates a new left.
	 */
	public Left() {
		super("LEFT$");
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
	public boolean typesMatch() {
		List<Atom> pars = Parser.getParameters(term);
		if (pars.size() != 2) {
			throw new RuntimeException("Wrong number of parameters: " + term);
		}
		if (pars.get(0).getType(true) != Type.STRING || pars.get(1).getType(true) == Type.STRING) {
			return false;
		}
		return true;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		try {
			List<Atom> pars = Parser.getParameters(term);
			if (pars.size() != 2) {
				throw new RuntimeException("Wrong number of parameters: " + term);
			}
			Atom var = pars.get(0);
			int count = VarUtils.getInt(pars.get(1).eval(machine));
			String txt = var.eval(machine).toString();

			try {
				return txt.substring(0, count < txt.length() ? count : txt.length());
			} catch (Exception e) {
				throw new RuntimeException("Illegal quantity error: " + txt + "/" + count);
			}
		} catch (Throwable t) {
			throw new RuntimeException("Syntax error: " + term);
		}
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
		Atom var = pars.get(0);
		List<String> ret = new ArrayList<String>();
		List<String> n1 = pars.get(1).evalToCode(config, machine).get(0).getExpression();
		n1.add(":PAR");
		n1.add("_");
		n1.addAll(var.evalToCode(config, machine).get(0).getExpression());
		n1.add(":" + getNativeFunctionName());
		ret.addAll(0, n1);
		ret.add("_");
		List<CodeContainer> cc = new ArrayList<CodeContainer>();
		cc.add(new CodeContainer(ret));
		return cc;
	}
}
