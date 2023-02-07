package com.sixtyfour.util;

import java.util.ArrayList;
import java.util.List;

/**
 * 
 * @author EgonOlsen
 *
 */
public class PotUtils {

	private final static List<Integer> POTS = new ArrayList<>() {
		private static final long serialVersionUID = 1L;
		{
			for (int i = 8; i > 0; i--) {
				add(Integer.valueOf((int) Math.pow(2, i)));
			}
		}
	};
	
	/**
	 * 
	 * @param i
	 * @return
	 */
	public static int getNearestPot(int i) {
		int lastP = -1;
		for (int p = 0; p < POTS.size(); p++) {
			int potVal = POTS.get(p);
			if (potVal < i) {
				break;
			}
			lastP = potVal;
		}
		return lastP;
	}
	
}
