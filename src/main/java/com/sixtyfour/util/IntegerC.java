package com.sixtyfour.util;

/**
 * Similar to valueOf in Java5's Integer class but more aggressive in caching.
 * 
 * @author EgonOlsen
 */
public class IntegerC {

	private final static Integer[] CACHE = new Integer[4000];
	private final static int OFFSET = 2000;

	static {
		for (int i = 0; i < CACHE.length; i++) {
			CACHE[i] = Integer.valueOf(i - 2000);
		}
	}

	/**
	 * @param i
	 * @return
	 */
	public static Integer valueOf(int i) {
		if (i >= -2000 && i <= 1999) {
			return CACHE[i + OFFSET];
		}
		return Integer.valueOf(i);
	}
}