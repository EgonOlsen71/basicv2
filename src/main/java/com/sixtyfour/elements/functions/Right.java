package com.sixtyfour.elements.functions;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The RIGHT function.
 */
public class Right extends AbstractFunction {

	/**
	 * Instantiates a new right.
	 */
	public Right() {
		super("RIGHT$");
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
				int pos = txt.length() - count;
				if (pos < 0) {
					pos = 0;
				}
				return txt.substring(pos, txt.length());
			} catch (Exception e) {
				throw new RuntimeException("Illegal quantity error: " + txt + "/" + count);
			}
		} catch (Throwable t) {
			throw new RuntimeException("Syntax error: " + term);
		}
	}

	@Override
	public List<CodeContainer> evalToCode(Machine machine) {
		List<Atom> pars = Parser.getParameters(term);
		if (pars.size() != 2) {
			throw new RuntimeException("Wrong number of parameters: " + term);
		}
		Atom var = pars.get(0);
		List<String> ret = new ArrayList<String>();
		List<String> n1 = pars.get(1).evalToCode(machine).get(0).getExpression();
		n1.add(":PAR");
		n1.add("_");
		n1.addAll(var.evalToCode(machine).get(0).getExpression());
		n1.add(":" + this.getClass().getSimpleName().toUpperCase(Locale.ENGLISH));
		ret.addAll(0, n1);
		ret.add("_");
		List<CodeContainer> cc = new ArrayList<CodeContainer>();
		cc.add(new CodeContainer(ret));
		return cc;
	}
}
