package com.sixtyfour.parser.logic;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.functions.Function;
import com.sixtyfour.parser.Atom;
import com.sixtyfour.parser.Term;
import com.sixtyfour.parser.cbmnative.CodeContainer;
import com.sixtyfour.system.Machine;

/**
 * A logic term.
 */
public class LogicTerm implements Atom {

	/** The name. */
	private String name;

	/**
	 * Instantiates a new logic term.
	 * 
	 * @param name the name, which is an internal marker for this block used at
	 *             parse time.
	 */
	public LogicTerm(String name) {
		this.name = name;
	}

	/** The left. */
	private Term left;

	/** The right. */
	private Term right;

	/** The comparator. */
	private Comparator comparator;

	@Override
	public List<CodeContainer> evalToCode(CompilerConfig config, Machine machine) {
		List<String> ret = new ArrayList<String>();
		List<CodeContainer> cc = new ArrayList<CodeContainer>();

		List<String> n1 = left.evalToCode(config, machine).get(0).getExpression();
		List<String> n2 = right.evalToCode(config, machine).get(0).getExpression();

		ret.add(0, "_");
		n2.add(0, ":" + (left.getType() == Type.STRING ? "S" : "") + this.comparator.evalToCode());
		ret.addAll(0, n1);
		ret.addAll(0, n2);

		cc.add(new CodeContainer(ret));
		return cc;
	}

	/**
	 * Gets the left term.
	 * 
	 * @return the left term
	 */
	public Term getLeft() {
		return left;
	}

	/**
	 * Sets the left term.
	 * 
	 * @param left the new left term
	 */
	public void setLeft(Term left) {
		this.left = left;
	}

	/**
	 * Gets the right term.
	 * 
	 * @return the right term
	 */
	public Term getRight() {
		return right;
	}

	/**
	 * Sets the right term.
	 * 
	 * @param right the new right term
	 */
	public void setRight(Term right) {
		this.right = right;
	}

	/**
	 * Gets the comparator.
	 * 
	 * @return the comparator
	 */
	public Comparator getComparator() {
		return comparator;
	}

	/**
	 * Sets the comparator.
	 * 
	 * @param comparator the new comparator
	 */
	public void setComparator(Comparator comparator) {
		this.comparator = comparator;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return left + " " + comparator + " " + right;
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

	public Type getType(boolean ignoreMT) {
		return Type.INTEGER;
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

	public List<Term> getTerms() {
		List<Term> terms = new ArrayList<Term>();
		terms.add(right);
		terms.add(left);
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
			if (o == this && (!(this.left instanceof Function) || ((Function) this.left).isDeterministic())) {
				return true;
			}

			boolean eq = true;

			if (this.left != null) {
				eq = this.left.equals(((LogicTerm) o).getLeft());
			}

			if (this.right != null && eq) {
				eq = this.right.equals(((LogicTerm) o).getRight());
			}

			if (this.comparator != null && eq) {
				eq = this.comparator.equals(((LogicTerm) o).getComparator());
			}

			return eq;
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
		return (this.left != null ? this.left.hashCode() : 0) + (this.right != null ? this.right.hashCode() : 0);
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

	private boolean evalToBoolean(Machine machine) {
		Object lo = left.eval(machine);
		Object ro = right != null ? right.eval(machine) : null;
		boolean ret = false;

		if (left.getType().equals(Type.STRING)) {
			// Compare strings
			if (right == null) {
				ret = true;
			} else {
				int res = lo.toString().compareTo(ro.toString());
				ret = (comparator.equals(Comparator.EQUAL) && res == 0)
						|| (comparator.equals(Comparator.LARGER) && res > 0)
						|| (comparator.equals(Comparator.SMALLER) && res < 0)
						|| (comparator.equals(Comparator.LARGER_OR_EQUAL) && res >= 0)
						|| (comparator.equals(Comparator.SMALLER_OR_EQUAL) && res <= 0)
						|| (comparator.equals(Comparator.NOT_EQUAL) && res != 0);
			}
		} else {
			// Compare numbers
			Number lon = (Number) lo;
			Number ron = (Number) ro;

			if (right == null) {
				ret = lon.floatValue() != 0;
			} else {
				float res = lon.floatValue() - ron.floatValue();
				ret = (comparator.equals(Comparator.EQUAL) && res == 0)
						|| (comparator.equals(Comparator.LARGER) && res > 0)
						|| (comparator.equals(Comparator.SMALLER) && res < 0)
						|| (comparator.equals(Comparator.LARGER_OR_EQUAL) && res >= 0)
						|| (comparator.equals(Comparator.SMALLER_OR_EQUAL) && res <= 0)
						|| (comparator.equals(Comparator.NOT_EQUAL) && res != 0);
			}
		}
		return ret;
	}
}
