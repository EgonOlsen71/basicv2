/*
 * 
 */
package sixtyfour.elements;

/**
 * The Enum Type.
 */
public enum Type {
	
	/** The string. */
	STRING, 
 /** The real. */
 REAL, 
 /** The integer. */
 INTEGER, 
 /** The none. */
 NONE;

	/**
	 * Checks if is assignable.
	 * 
	 * @param type1
	 *            the type 1
	 * @param type2
	 *            the type 2
	 * @return true, if is assignable
	 */
	public static boolean isAssignable(Type type1, Type type2) {
		if (type1.equals(type2)) {
			return true;
		}
		if (type1.equals(REAL) && type2.equals(INTEGER)) {
			return true;
		}
		if (type1.equals(INTEGER) && type2.equals(REAL)) {
			return true;
		}
		return false;
	}
}
