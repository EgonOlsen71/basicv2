package sixtyfour.parser.logic;

import sixtyfour.elements.Type;
import sixtyfour.parser.Term;
import sixtyfour.system.Machine;

public class Comparison implements LogicBlock {

	private Term left;
	private Term right;
	private Comparator comparator;
	private boolean not = false;

	@Override
	public boolean eval(Machine machine) {
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

	public Term getLeft() {
		return left;
	}

	public void setLeft(Term left) {
		this.left = left;
	}

	public Term getRight() {
		return right;
	}

	public void setRight(Term right) {
		this.right = right;
	}

	public Comparator getComparator() {
		return comparator;
	}

	public void setComparator(Comparator comparator) {
		this.comparator = comparator;
	}

	@Override
	public void not() {
		not = !not;
	}

	@Override
	public String toString() {
		return (not ? " NOT " : "") + left + " " + comparator + " " + right;
	}
}
