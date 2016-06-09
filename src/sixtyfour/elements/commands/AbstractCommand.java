package sixtyfour.elements.commands;

import java.util.Locale;

import sixtyfour.elements.Assignment;

public class AbstractCommand implements Command {
	protected String name;
	protected String term;
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
			clone.term = linePart.substring(name.length()).trim();
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
	public String getTerm() {
		return term;
	}

	@Override
	public void setTerm(String content) {
		this.term = content;
	}

	@Override
	public boolean isCommand(String command) {
		return command.trim().toUpperCase(Locale.ENGLISH).startsWith(name);
	}

	@Override
	public String toString() {
		return this.name;
	}

}
