/*
 * 
 */
package sixtyfour.elements.functions;

import java.util.List;

import sixtyfour.elements.Type;
import sixtyfour.parser.Atom;
import sixtyfour.parser.Parser;
import sixtyfour.system.Machine;

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

	/* (non-Javadoc)
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		return Type.STRING;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine memory) {
		try {
			List<Atom> pars = Parser.getParameters(term);
			if (pars.size() != 2 && pars.size() != 3) {
				throw new RuntimeException("Wrong number of parameters: " + term);
			}
			Atom var = pars.get(0);
			int start = ((Number) pars.get(1).eval(memory)).intValue()-1;
			int end = -999;
			if (pars.size() > 2) {
				end = ((Number) pars.get(2).eval(memory)).intValue() + start;
			}

			String txt = var.eval(memory).toString();
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
