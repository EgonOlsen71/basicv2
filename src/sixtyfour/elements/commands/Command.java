package sixtyfour.elements.commands;

import sixtyfour.Memory;
import sixtyfour.elements.Assignment;
import sixtyfour.elements.Atom;
import sixtyfour.elements.Term;

public interface Command extends Atom {
	String getName();

	boolean isCommand(String command);

	Command clone(String linePart);

	Term getTerm();

	void setTerm(Term term);

	Assignment getAssignment();

	void setAssignment(Assignment assignment);

	void parse(String linePart, Memory memory);

	void execute(Memory memory);
}
