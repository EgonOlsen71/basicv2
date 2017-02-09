package com.sixtyfour.parser.logic;

import com.sixtyfour.elements.Type;
import com.sixtyfour.parser.Term;
import com.sixtyfour.system.Machine;

/**
 * A comparison between two logic blocks.
 */
public class Comparison implements LogicBlock {

	/** The left. */
	private Term left;

	/** The right. */
	private Term right;

	/** The comparator. */
	private Comparator comparator;

	/** The not. */
	private boolean not = false;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * sixtyfour.parser.logic.LogicBlock#evalToBoolean(sixtyfour.system.Machine)
	 */
	@Override
	public boolean evalToBoolean(Machine machine) {
		Object lo = left.eval(machine);
		Object ro = right != null ? right.eval(machine) : null;
		boolean ret = false;

		if (left.getType().equals(Type.STRING)) {
			// Compare strings
			if (right == null) {
				ret = true;
			} else {
				int res = lo.toString().compareTo(ro.toString());
				ret = (comparator.equals(Comparator.EQUAL) && res == 0) || (comparator.equals(Comparator.LARGER) && res > 0) || (comparator.equals(Comparator.SMALLER) && res < 0)
						|| (comparator.equals(Comparator.LARGER_OR_EQUAL) && res >= 0) || (comparator.equals(Comparator.SMALLER_OR_EQUAL) && res <= 0)
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
				ret = (comparator.equals(Comparator.EQUAL) && res == 0) || (comparator.equals(Comparator.LARGER) && res > 0) || (comparator.equals(Comparator.SMALLER) && res < 0)
						|| (comparator.equals(Comparator.LARGER_OR_EQUAL) && res >= 0) || (comparator.equals(Comparator.SMALLER_OR_EQUAL) && res <= 0)
						|| (comparator.equals(Comparator.NOT_EQUAL) && res != 0);
			}
		}
		if (not) {
			ret = !ret;
		}
		return ret;
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
	 * @param left
	 *            the new left term
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
	 * @param right
	 *            the new right term
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
	 * @param comparator
	 *            the new comparator
	 */
	public void setComparator(Comparator comparator) {
		this.comparator = comparator;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see sixtyfour.parser.logic.LogicBlock#not()
	 */
	@Override
	public void not() {
		not = !not;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return (not ? " NOT " : "") + left + " " + comparator + " " + right;
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

  @Override
  public String toCode()
  {
    return null;
  }
}
