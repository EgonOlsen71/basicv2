package sixtyfour.util;

/**
 * The Class VarUtils.
 * 
 * @author EgonOlsen
 */
public class VarUtils {

	/**
	 * Checks if is number.
	 * 
	 * @param obj
	 *            the obj
	 * @return true, if is number
	 */
	public static boolean isNumber(Object obj) {
		return obj instanceof Float || obj instanceof Integer;
	}

	/**
	 * Checks if is float.
	 * 
	 * @param obj
	 *            the obj
	 * @return true, if is float
	 */
	public static boolean isFloat(Object obj) {
		return obj instanceof Float;
	}

	/**
	 * Checks if is integer.
	 * 
	 * @param obj
	 *            the obj
	 * @return true, if is integer
	 */
	public static boolean isInteger(Object obj) {
		return obj instanceof Integer;
	}

	/**
	 * Checks if is string.
	 * 
	 * @param obj
	 *            the obj
	 * @return true, if is string
	 */
	public static boolean isString(Object obj) {
		return obj instanceof String;
	}

	/**
	 * Gets the float.
	 * 
	 * @param obj
	 *            the obj
	 * @return the float
	 */
	public static float getFloat(Object obj) {
		return ((Number) obj).floatValue();
	}

	/**
	 * Gets the int.
	 * 
	 * @param obj
	 *            the obj
	 * @return the int
	 */
	public static int getInt(Object obj) {
		return ((Number) obj).intValue();
	}

}
