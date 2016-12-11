package com.sixtyfour.elements.commands;

import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Term;
import com.sixtyfour.system.Machine;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.util.VarUtils;

/**
 * An abstract, common base class for commands.
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
		this.name = VarUtils.toUpper(name);
	}

	/*
	 * (non-Javadoc)
	 * 
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.Command#getName()
	 */
	@Override
	public String getName() {
		return name;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.Command#keepSpaces()
	 */
	public boolean keepSpaces() {
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.Command#getTerm()
	 */
	@Override
	public Term getTerm() {
		return term;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.Command#setTerm(sixtyfour.parser.Term)
	 */
	@Override
	public void setTerm(Term term) {
		this.term = term;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.Command#isCommand(java.lang.String)
	 */
	@Override
	public boolean isCommand(String command) {
		return VarUtils.toUpper(command.trim()).startsWith(name);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return this.name + " @ " + lineNumber;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.Command#parse(java.lang.String, int,
	 * int, int, boolean, sixtyfour.system.Machine)
	 */
	@Override
	public String parse(String linePart, int lineCnt, int lineNumber, int linePos, boolean lastPos, Machine machine) {
		this.lineCnt = lineCnt;
		this.linePos = linePos;
		this.lineNumber = lineNumber;
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * sixtyfour.elements.commands.Command#execute(sixtyfour.system.Machine)
	 */
	@Override
	public BasicProgramCounter execute(Machine machine) {
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.elements.commands.Command#stopExecution()
	 */
	@Override
	public void stopExecution() {
		//
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#isTerm()
	 */
	@Override
	public boolean isTerm() {
		return false;
	}

}
