package com.sixtyfour.util;

/**
 * Utils for parsing number related stuff
 * 
 * @author EgonOlsen
 *
 */
public class NumberUtils {

	/**
	 * Parses a line number in a GOTO or GOSUB statement just like the interpreter would
	 * @param linePart
	 * @return
	 */
	public static int parseLineNumber(String linePart) {
		if (linePart==null) {
			return 0;
		}
		linePart=linePart.trim();
		StringBuilder sb = new StringBuilder();

        for (int i = 0; i < linePart.length(); i++) {
            char c = linePart.charAt(i);
            if (Character.isDigit(c)) {
                sb.append(c);
            } else {
                break;
            }
        }
        try {
        	return Integer.parseInt(sb.toString());
        } catch(Exception e) {
        	return 0;
        }
	}
	
}
