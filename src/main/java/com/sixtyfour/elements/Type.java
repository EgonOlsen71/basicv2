/*
 * 
 */
package com.sixtyfour.elements;

/**
 * An enum of types. Types can either be String, Real or Integer.
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
	 * Checks if one type is assignable to another. This is the case if the
	 * types are equal or either real or integer. Being assignable doesn't mean
	 * that there's no accuracy loss when doing so.
	 * 
	 * @param type1
	 *            one type
	 * @param type2
	 *            another type
	 * @return true, if these types can be assigned to each other
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
