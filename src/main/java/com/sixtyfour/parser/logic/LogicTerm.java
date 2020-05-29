package com.sixtyfour.parser.logic;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.Machine;

/**
 * A logic term.
 */
public class LogicTerm implements LogicBlock {

	/** The name. */
	private String name;

	private Comparison comp;

	/**
	 * Instantiates a new logic term.
	 * 
	 * @param name the name, which is an internal marker for this block used at
	 *             parse time.
	 */
	public LogicTerm(String name) {
		this.name = name;
	}

	/**
	 * Adds a new logic block to the term.
	 * 
	 * @param block the new block
	 */
	public void setComparison(Comparison comp) {
		this.comp = comp;
	}
	
	public Comparison getComparison() {
		return comp;
	}

	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		List<CodeContainer> ret = new ArrayList<CodeContainer>();
		if (comp == null) {
			return ret;
		}
		ret.addAll(comp.evalToCode(config, machine));
		return ret;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * sixtyfour.parser.logic.LogicBlock#evalToBoolean(sixtyfour.system.Machine)
	 */
	@Override
	public boolean evalToBoolean(Machine machine) {
		if (comp == null) {
			return true;
		}
		return comp.evalToBoolean(machine);
	}

	
	/**
	 * Gets the name.
	 * 
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * Sets the name.
	 * 
	 * @param name the new name
	 */
	public void setName(String name) {
		this.name = name;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("(").append(comp).append(")");
		return sb.toString();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#eval(sixtyfour.system.Machine)
	 */
	@Override
	public Object eval(Machine machine) {
		boolean ok = evalToBoolean(machine);
		return ok ? -1 : 0;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.Atom#getType()
	 */
	@Override
	public Type getType() {
		return Type.INTEGER;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.parser.Atom#getType(boolean)
	 */
	@Override
	public Type getType(boolean ignoreMT) {
		return Type.INTEGER;
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.parser.Atom#isConstant()
	 */
	@Override
	public boolean isConstant() {
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.sixtyfour.parser.logic.LogicBlock#getTerms()
	 */
	@Override
	public List<Term> getTerms() {
		List<Term> terms = new ArrayList<Term>();
		terms.addAll(comp.getTerms());
		return terms;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object o) {
		if (o == null) {
			return false;
		}
		if (o instanceof LogicTerm) {
			return comp.equals(((LogicTerm)o).getComparison());
		}
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		// Not very elegant, but should do it for now...
		return name.hashCode();
	}

}
