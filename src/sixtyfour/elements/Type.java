package sixtyfour.elements;

public enum Type {
	STRING, REAL, INTEGER, NONE;

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
