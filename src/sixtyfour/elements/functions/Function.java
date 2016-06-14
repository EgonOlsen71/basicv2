package sixtyfour.elements.functions;

import sixtyfour.parser.Atom;
import sixtyfour.parser.Term;
import sixtyfour.system.Machine;

public interface Function extends Atom {
	String getName();

	boolean isFunction(String function);

	Function clone();

	Term getTerm();

	void setTerm(Term term);

	void parse(String linePart, Machine machine);

	boolean hasPostfix();

	void setFunctionName(String functionName);

}
