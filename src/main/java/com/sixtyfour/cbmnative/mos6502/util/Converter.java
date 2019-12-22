package com.sixtyfour.cbmnative.mos6502.util;

/**
 * @author EgonOlsen71
 *
 */
public class Converter {

	/**
	 * Switching lower case to upper and upper case to lower in a string.
	 * 
	 * @param txt       the string
	 * @param onlyLower if true, only lower case conversions will be applied
	 * @return the result
	 */
	public static String convertCase(String txt, boolean onlyLower) {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < txt.length(); i++) {
			char c = txt.charAt(i);
			if (Character.isAlphabetic(c)) {
				if (!onlyLower) {
					if (Character.isLowerCase(c)) {
						c = Character.toUpperCase(c);
					} else if (Character.isUpperCase(c)) {
						c = Character.toLowerCase(c);
					}
				} else {
					if (Character.isUpperCase(c)) {
						c = Character.toLowerCase(c);
					}
				}
			}
			sb.append(c);
		}
		return sb.toString();
	}

}
