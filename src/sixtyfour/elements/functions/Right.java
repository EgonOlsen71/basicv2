package sixtyfour.elements.functions;

import java.util.List;

import sixtyfour.elements.Type;
import sixtyfour.parser.Atom;
import sixtyfour.parser.Parser;
import sixtyfour.system.Machine;

public class Right extends AbstractFunction {
	public Right() {
		super("RIGHT$");
	}

	@Override
	public Type getType() {
		return Type.STRING;
	}

	@Override
	public Object eval(Machine memory) {
		try {
			List<Atom> pars = Parser.getParameters(term);
			if (pars.size() != 2) {
				throw new RuntimeException("Wrong number of parameters: " + term);
			}
			Atom var = pars.get(0);
			int count = ((Number) pars.get(1).eval(memory)).intValue();
			String txt = var.eval(memory).toString();

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
}
