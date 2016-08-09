/*
 * 
 */
package com.sixtyfour.elements.functions;

import java.util.List;

import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Parser;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.VarUtils;

/**
 * The Class Mid.
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
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		try {
			List<Atom> pars = Parser.getParameters(term);
			if (pars.size() != 2 && pars.size() != 3) {
				throw new RuntimeException("Wrong number of parameters: " + term);
			}
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

}
