package com.sixtyfour.test.misc;

import java.util.ArrayList;
import java.util.List;

public class ShiftValSplitter {

	public static void main(String[] args) {

		List<Integer> pots = new ArrayList<>();
		for (int i = 0; i < 12; i++) {
			pots.add(Integer.valueOf((int) Math.pow(2, i)));
		}

		for (int i = 0; i <= 320; i++) {
			int firstShift = getNearestPot(pots, i);
			if (firstShift >= 0) {
				int firstPart = pots.get(firstShift);
				int dif = i - firstPart;
				if (dif != 0) {
					int secondShift = getNearestPot(pots, dif);
					if (secondShift >= 0) {
						int secondPart = pots.get(secondShift);
						int total = firstPart + secondPart;
						if (total == i) {
							//System.out.println(firstShift + "+" + secondShift + " - " + firstPart + "+" + secondPart
							//		+ "=" + total);
							System.out.println("this.add("+total+");");
						}
					}
				}
			}
		}

	}

	private static int getNearestPot(List<Integer> pots, int i) {
		int lastP = -1;
		for (int p = 0; p < pots.size(); p++) {
			int potVal = pots.get(p);
			if (potVal > i) {
				break;
			}
			lastP = p;
		}
		return lastP;
	}

}
