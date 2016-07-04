/*
 * 
 */
package sixtyfour.elements.functions;

import sixtyfour.elements.Type;
import sixtyfour.system.Machine;
import sixtyfour.util.VarUtils;

/**
 * The Class Str.
 */
public class Str extends AbstractFunction {

	/**
	 * Instantiates a new str.
	 */
	public Str() {
		super("STR$");
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
		if (term.getType().equals(Type.STRING)) {
			throw new RuntimeException("Type mismatch error: " + term.getType());
		}
		Float num = VarUtils.getFloat(term.eval(machine));
		String str = num.toString();
		if (num.floatValue() == (int) num.floatValue()) {
			str = str.substring(0, str.length() - 2);
		}
		if (num > 0) {
			str = " " + str;
		}
		return str;
	}
}
