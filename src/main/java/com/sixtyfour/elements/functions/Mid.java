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
 * The MID function.
 */
public class Mid extends AbstractFunction {

	/**
	 * Instantiates a new mid.
	 */
	public Mid() {
		super("MID$");
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
	 * @see
	 * com.sixtyfour.elements.functions.AbstractFunction#evalToExpression(com
	 * .sixtyfour.system.Machine)
	 */
	@Override
	public List<CodeContainer> evalToCode(Machine machine) {
		List<Atom> pars = Parser.getParameters(term);
		checkParameters(pars);
		Atom var = pars.get(0);

		List<String> ret = new ArrayList<String>();

		// Add additional parameters in reverse order
		List<String> n1 = pars.get(1).evalToCode(machine).get(0).getExpression();
		n1.add(":PAR");
		n1.add("_");

		if (pars.size() > 2) {
			n1.addAll(pars.get(2).evalToCode(machine).get(0).getExpression());
		} else {
			n1.add("#-1{INTEGER}");
		}
		n1.add(":PAR");
		n1.add("_");
		n1.addAll(var.evalToCode(machine).get(0).getExpression());
		n1.add(":" + this.getClass().getSimpleName().toUpperCase(Locale.ENGLISH));
		ret.addAll(0, n1);
		ret.add("_");
	  List<CodeContainer> cc=new ArrayList<CodeContainer>();
    cc.add(new CodeContainer(ret));
    return cc;
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
			checkParameters(pars);
			Atom var = pars.get(0);

			int start = VarUtils.getInt(pars.get(1).eval(machine)) - 1;
			int end = -999;
			if (pars.size() > 2) {
				end = VarUtils.getInt(pars.get(2).eval(machine)) + start;
			}

			String txt = var.eval(machine).toString();
			if (end == -999) {
				end = txt.length();
			}
			end = Math.min(end, txt.length());

			try {
				if (start >= txt.length()) {
					return "";
				}
				return txt.substring(start, end);
			} catch (Exception e) {
				throw new RuntimeException("Illegal quantity error: " + txt + "/" + start);
			}
		} catch (RuntimeException e) {
			throw e;
		} catch (Throwable t) {
			throw new RuntimeException("Syntax error: " + term);
		}
	}

	private void checkParameters(List<Atom> pars) {
		if (pars.size() != 2 && pars.size() != 3) {
			throw new RuntimeException("Wrong number of parameters: " + term);
		}
	}

}
