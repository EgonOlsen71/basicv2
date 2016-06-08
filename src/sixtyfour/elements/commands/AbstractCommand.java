package sixtyfour.elements.commands;

import java.util.Locale;

import sixtyfour.Memory;
import sixtyfour.elements.Assignment;
import sixtyfour.elements.Term;
import sixtyfour.elements.Type;

public abstract class AbstractCommand implements Command {
	protected String name;
	protected Term term;
	protected Assignment assignment;

	@SuppressWarnings("unused")
	private AbstractCommand() {
		//
	}

	public AbstractCommand(String name) {
		this.name = name.toUpperCase(Locale.ENGLISH);
	}

	public Command clone(String linePart) {
		try {
			AbstractCommand clone = this.getClass().newInstance();
			clone.name = name;
			return clone;
		} catch (Exception e) {
			throw new RuntimeException("Unable to instantiate command: " + name);
		}

	}

	@Override
	public Assignment getAssignment() {
		return assignment;
	}

	@Override
	public void setAssignment(Assignment assignment) {
		this.assignment = assignment;
	}

	@Override
	public String getName() {
		return name;
	}

	@Override
	public Term getTerm() {
		return term;
	}

	@Override
	public void setTerm(Term term) {
		this.term = term;
	}

	@Override
	public boolean isCommand(String command) {
		return command.trim().toUpperCase(Locale.ENGLISH).startsWith(name);
	}

	@Override
	public String toString() {
		return this.name;
	}

	@Override
	public Type getType() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Object eval() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void parse(String linePart, Memory memory) {
		// TODO Auto-generated method stub
	}
	
	@Override
	public void execute(Memory memory) {
		// TODO Auto-generated method stub
	}

}
