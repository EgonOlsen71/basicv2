package com.sixtyfour.parser.assembly;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

/**
 * @author EgonOlsen
 * 
 */
public class ControlCodes {

	private static Map<String, Integer> placeHolder2code = new HashMap<String, Integer>() {
		private static final long serialVersionUID = 1L;

		{
			this.put("space", 32);
			this.put("black", 144);
			this.put("blk", 144);
			this.put("white", 5);
			this.put("wht", 5);
			this.put("red", 28);
			this.put("cyan", 159);
			this.put("cyn", 159);
			this.put("purple", 156);
			this.put("pur", 156);
			this.put("green", 30);
			this.put("grn", 30);
			this.put("blue", 31);
			this.put("blu", 31);
			this.put("yellow", 158);
			this.put("yel", 158);
			this.put("orange", 129);
			this.put("orng", 129);
			this.put("orn", 129);
			this.put("brown", 149);
			this.put("brn", 149);
			this.put("light red", 150);
			this.put("lred", 150);
			this.put("dark grey", 151);
			this.put("dark gray", 151);
			this.put("gry1", 151);
			this.put("grey", 152);
			this.put("gray", 152);
			this.put("gry2", 152);
			this.put("light green", 153);
			this.put("lgrn", 153);
			this.put("light blue", 154);
			this.put("lblu", 154);
			this.put("light grey", 155);
			this.put("light gray", 155);
			this.put("gry3", 155);
			this.put("reverse on", 18);
			this.put("rvon", 18);
			this.put("rvson", 18);
			this.put("reverse off", 146);
			this.put("rvof", 146);
			this.put("rvsoff", 146);
			this.put("cursor down", 17);
			this.put("down", 17);
			this.put("cursor up", 145);
			this.put("up", 145);
			this.put("cursor left", 157);
			this.put("left", 157);
			this.put("cursor right", 29);
			this.put("rght", 29);
			this.put("right", 29);
			this.put("del", 20);
			this.put("insert", 148);
			this.put("inst", 148);
			this.put("clear", 147);
			this.put("clr", 147);
			this.put("home", 19);
			this.put("f1", 133);
			this.put("f3", 134);
			this.put("f5", 135);
			this.put("f7", 136);
			this.put("f2", 137);
			this.put("f4", 138);
			this.put("f6", 139);
			this.put("f8", 140);
			this.put("pound", 92);
			this.put("shift space", 160);
			for (int i = 65; i < 91; i++) {
			    char c=((char) (i - 65 + 'a'));
			    this.put("shift-" + c, i);
			    this.put("sh " + c, i);
			}
			for (int i = 65; i < 255; i++) {
			    char c=((char) (i - 65 + 'a'));
			    this.put("cbm-" + c, i);
			    this.put("cm " + c, i);
			}
			// {CBM-A} to {CBM-Z}
		}
	};

	public static void main(String[] args) {
		//
	}

	public static int getCode(String placeHolder) {
		placeHolder = placeHolder.replace("{", "").replace("}", "").toLowerCase(Locale.ENGLISH).trim();
		if (placeHolder2code.containsKey(placeHolder)) {
			return placeHolder2code.get(placeHolder);
		}
		return -1;
	}

}
