package sixtyfour.elements.functions;

import java.util.Locale;

import sixtyfour.parser.Parser;
import sixtyfour.parser.Term;
import sixtyfour.system.Machine;

/**
 * The Class AbstractFunction.
 */
public abstract class AbstractFunction implements Function {

	/** The name. */
	protected String name;
	
	/** The term. */
	protected Term term;

	/** The function name. */
	protected String functionName;

	/**
	 * Instantiates a new abstract function.
	 */
	@SuppressWarnings("unused")
	private AbstractFunction() {
		//
	}

	/**
	 * Instantiates a new abstract function.
	 * 
	 * @param name
	 *            the name
	 */
	public AbstractFunction(String name) {
		this.name = name.toUpperCase(Locale.ENGLISH);
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#clone()
	 */
	public Function clone() {
		try {
			AbstractFunction clone = this.getClass().newInstance();
			clone.name = name;
			return clone;
		} catch (Exception e) {
			throw new RuntimeException("Unable to instantiate function: " + name);
		}

	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.functions.Function#getName()
	 */
	@Override
	public String getName() {
		return name;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.functions.Function#getTerm()
	 */
	@Override
	public Term getTerm() {
		return term;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.functions.Function#setTerm(sixtyfour.parser.Term)
	 */
	@Override
	public void setTerm(Term term) {
		this.term = term;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.functions.Function#parse(java.lang.String, sixtyfour.system.Machine)
	 */
	@Override
	public void parse(String linePart, Machine memory) {
		this.setTerm(Parser.getTerm(linePart, memory, false, true));
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.functions.Function#isFunction(java.lang.String)
	 */
	@Override
	public boolean isFunction(String function) {
		return function.trim().toUpperCase(Locale.ENGLISH).startsWith(name);
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.functions.Function#hasPostfix()
	 */
	@Override
	public boolean hasPostfix() {
		return false;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.functions.Function#setFunctionName(java.lang.String)
	 */
	@Override
	public void setFunctionName(String functionName) {
		this.functionName = functionName;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return this.name + "(" + term + ")";
	}

	/* (non-Javadoc)
	 * @see sixtyfour.parser.Atom#isTerm()
	 */
	@Override
	public boolean isTerm() {
		return false;
	}
}
