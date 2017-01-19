package com.sixtyfour.extensions.graphics.commands.impl;

import java.awt.Font;
import java.util.HashMap;
import java.util.Map;

/**
 * Provides fonts.
 * 
 * @author EgonOlsen
 * 
 */
public class FontProvider {

	private static Map<String, Font> fontCache = new HashMap<String, Font>();

	/**
	 * Provides a (cached) font instance with the given attributes.
	 * 
	 * @param fontName
	 *            the font's name
	 * @param style
	 *            the style (0=plain, 1=bold, 2=italic)
	 * @param size
	 *            the size in pixels
	 * @return the font
	 */
	public static Font getFont(String fontName, int style, int size) {
		String name = fontName.toLowerCase() + "_" + style + "_" + size;
		Font font = fontCache.get(name);
		if (font == null) {
			int styly = 0;
			switch (style) {
			case 1:
				styly = Font.BOLD;
				break;
			case 2:
				styly = Font.ITALIC;
				break;
			default:
				styly = Font.PLAIN;
				break;
			}
			font = new Font(fontName, styly, Math.max(1, size));
			fontCache.put(name, font);
		}
		return font;
	}

}
