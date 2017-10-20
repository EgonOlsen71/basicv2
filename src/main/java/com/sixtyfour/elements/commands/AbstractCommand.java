package com.sixtyfour.elements.commands;

import java.util.List;

import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.BasicProgramCounter;
import com.sixtyfour.system.Machine;
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

	@Override
	public List<CodeContainer> evalToCode(Machine machine) {
		throw new RuntimeException("Command " + this.getName() + " not implemented in native compiler!");
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.parser.Atom#toCode(com.sixtyfour.system.Machine)
	 */
	@Override
	public String toCode(Machine machine) {
		return null;
	}

	@Override
	public boolean isConditional() {
		return false;
	}

	/**
	 * Throws a type mismatch error.
	 * 
	 * @param line
	 */
	protected void typeMismatch(String line) {
		throw new RuntimeException("Type mismatch error: " + line);
	}

	/**
	 * Throws a syntax error.
	 * 
	 * @param line
	 */
	protected void syntaxError(String line) {
		throw new RuntimeException("Syntax error: " + line);
	}

	/**
	 * Throws a type mismatch error.
	 * 
	 * @param line
	 */
	protected void typeMismatch(Object obj) {
		typeMismatch(obj.toString());
	}

	/**
	 * Throws a syntax error.
	 * 
	 * @param line
	 */
	protected void syntaxError(Object obj) {
		syntaxError(obj.toString());
	}
	
	/**
	 * @param expr
	 * @return
	 */
	protected List<String> saveG(List<String> expr)
  {
    if (expr.size()>0 && expr.get(expr.size()-1).equals("PUSH G")) {
        expr=expr.subList(0, expr.size() - 1);
    } else {
      expr.add("POP G");
    }
    return expr;
  }

	/**
	 * @param params
	 * @param msg
	 * @param types
	 */
	protected void checkTypes(List<Atom> params, String msg, Type... types) {
		if (types == null) {
			return;
		}
		int max = Math.min(types.length, params.size());
		for (int i = 0; i < max; i++) {
			if (types[i] != null && params.get(i).getType().equals(types[i])) {
				typeMismatch(msg);
				break;
			}
		}
	}

	/**
	 * @param machine
	 * @param variable
	 * @return
	 */
	protected String getVariableLabel(Machine machine, Variable variable) {
		List<CodeContainer> ccs = variable.evalToCode(machine);
		return ccs.get(0).getExpression().get(0);
	}

	/**
	 * @param line
	 * @return
	 */
	protected String getPushRegister(String line) {
		if (line.startsWith("PUSH")) {
			line = line.substring(4).trim();
			return line;
		}
		return null;
	}
}
