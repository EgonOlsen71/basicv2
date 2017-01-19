package com.sixtyfour.extensions.graphics.commands.impl;

import java.awt.Color;
import java.util.LinkedList;

/**
 * FloodFiller for Images.
 * 
 * @author EgonOlsen
 */
public class FloodFiller {

	/**
	 * @param img
	 * @param width
	 * @param height
	 * @param xSeed
	 * @param ySeed
	 * @param col
	 */
	public void fill(int[] pixels, int width, int height, int xSeed, int ySeed, Color col) {
		int x = xSeed;
		int y = ySeed;

		if (x >= 0 && x < width && y >= 0 && y < height) {

			int oldColor = pixels[y * width + x];
			int fillColor = col.getAlpha() << 24 | col.getRed() << 16 | col.getGreen() << 8 | col.getGreen();

			if (oldColor != fillColor) {
				floodIt(pixels, x, y, width, height, oldColor, fillColor);
			}
		}
	}

	private void floodIt(int[] pixels, int x, int y, int width, int height, int oldColor, int fillColor) {

		int[] point = new int[] { x, y };
		LinkedList<int[]> points = new LinkedList<int[]>();
		points.addFirst(point);

		while (!points.isEmpty()) {

			point = (int[]) points.remove();

			x = point[0];
			y = point[1];
			int xr = x;

			int yp = y * width;
			int ypp = yp + width;
			int ypm = yp - width;

			do {
				pixels[xr + yp] = fillColor;
				xr++;
			} while (xr < width && pixels[xr + y * width] == oldColor);
			xr--;

			int xl = x;
			do {
				pixels[xl + yp] = fillColor;
				xl--;
			} while (xl >= 0 && pixels[xl + y * width] == oldColor);
			xl++;

			boolean upLine = false;
			boolean downLine = false;

			for (int xi = xl; xi <= xr; xi++) {
				if (y > 0 && pixels[xi + ypm] == oldColor && !upLine) {
					points.addFirst(new int[] { xi, y - 1 });
					upLine = true;
				} else {
					upLine = false;
				}
				if (y < height - 1 && pixels[xi + ypp] == oldColor && !downLine) {
					points.addFirst(new int[] { xi, y + 1 });
					downLine = true;
				} else {
					downLine = false;
				}
			}
		}
	}

}
