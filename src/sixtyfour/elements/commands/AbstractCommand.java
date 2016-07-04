package sixtyfour.elements.commands;

import java.util.Locale;

import sixtyfour.elements.Type;
import sixtyfour.parser.Term;
import sixtyfour.system.Machine;
import sixtyfour.system.ProgramCounter;

/**
 * The Class AbstractCommand.
 */
public abstract class AbstractCommand implements Command {
	
	/** The name. */
	protected String name;
	
	/** The term. */
	protected Term term;
	
	/** The line cnt. */
	protected int lineCnt = 0;
	
	/** The line pos. */
	protected int linePos = 0;
	
	/** The line number. */
	protected int lineNumber = 0;

	/**
	 * Instantiates a new abstract command.
	 */
	@SuppressWarnings("unused")
	private AbstractCommand() {
		//
	}

	/**
	 * Instantiates a new abstract command.
	 * 
	 * @param name
	 *            the name
	 */
	public AbstractCommand(String name) {
		this.name = name.toUpperCase(Locale.ENGLISH);
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.commands.Command#clone(java.lang.String)
	 */
	public Command clone(String linePart) {
		try {
			AbstractCommand clone = this.getClass().newInstance();
			clone.name = name;
			return clone;
		} catch (Exception e) {
			throw new RuntimeException("Unable to instantiate command: " + name);
		}

	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.commands.Command#getName()
	 */
	@Override
	public String getName() {
		return name;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.commands.Command#getTerm()
	 */
	@Override
	public Term getTerm() {
		return term;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.commands.Command#setTerm(sixtyfour.parser.Term)
	 */
	@Override
	public void setTerm(Term term) {
		this.term = term;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.commands.Command#isCommand(java.lang.String)
	 */
	@Override
	public boolean isCommand(String command) {
		return command.trim().toUpperCase(Locale.ENGLISH).startsWith(name);
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return this.name + " @ " + lineNumber;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		return null;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine memory) {
		return null;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.commands.Command#parse(java.lang.String, int, int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine memory) {
		this.lineCnt = lineCnt;
		this.linePos = linePos;
		this.lineNumber = lineNumber;
		return null;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.commands.Command#execute(sixtyfour.system.Machine)
	 */
	@Override
	public ProgramCounter execute(Machine memory) {
		return null;
	}

	/* (non-Javadoc)
	 * @see sixtyfour.elements.commands.Command#stopExecution()
	 */
	@Override
	public void stopExecution() {
		//
	}

	/* (non-Javadoc)
	 * @see sixtyfour.parser.Atom#isTerm()
	 */
	@Override
	public boolean isTerm() {
		return false;
	}

}
