package com.sixtyfour.util;

import java.util.Locale;

/**
 * Utility class that hides some of the ugly casting and "instance of" checks
 * when dealing with variables.
 * 
 * @author EgonOlsen
 */
public final class VarUtils {

	/**
	 * Checks an instance is a Number.
	 * 
	 * @param obj the instance to check
	 * @return true, if it's a number
	 */
	public static boolean isNumber(Object obj) {
		return obj instanceof Float || obj instanceof Integer || obj instanceof Double;
	}

	/**
	 * Checks an instance is a Float.
	 * 
	 * @param obj the instance to check
	 * @return true, if it's a float
	 */
	public static boolean isFloat(Object obj) {
		return obj instanceof Float;
	}

	/**
	 * Checks an instance is a Double.
	 * 
	 * @param obj the instance to check
	 * @return true, if it's a double
	 */
	public static boolean isDouble(Object obj) {
		return obj instanceof Double;
	}

	/**
	 * Checks an instance is an Integer.
	 * 
	 * @param obj the instance to check
	 * @return true, if it's an integer
	 */
	public static boolean isInteger(Object obj) {
		return obj instanceof Integer;
	}

	/**
	 * Checks an instance is a String.
	 * 
	 * @param obj the instance to check
	 * @return true, if it's a string
	 */
	public static boolean isString(Object obj) {
		return obj instanceof String;
	}

	/**
	 * Gets the float value of an instance.
	 * 
	 * @param obj the instance
	 * @return the float value
	 */
	public static float getFloat(Object obj) {
		return ((Number) obj).floatValue();
	}

	/**
	 * Gets the double value of an instance.
	 * 
	 * @param obj the instance
	 * @return the double value
	 */
	public static double getDouble(Object obj) {
		return ((Number) obj).doubleValue();
	}

	/**
	 * Gets the int value of an instance.
	 * 
	 * @param obj the instance
	 * @return the int value
	 */
	public static int getInt(Object obj) {
		return ((Number) obj).intValue();
	}

	/**
	 * Converts a text to upper case using an english locale.
	 * 
	 * @param txt the text
	 * @return the text in upper case
	 */
	public static String toUpper(String txt) {
		return txt.toUpperCase(Locale.ENGLISH);
	}

	/**
	 * Changes variable names to match the JIT's requirements.
	 * 
	 * @param varName the name
	 * @return the new name
	 */
	public static String relabel(String varName) {
		return varName.replace('%', '_').replace("$", "__");
	}

}
