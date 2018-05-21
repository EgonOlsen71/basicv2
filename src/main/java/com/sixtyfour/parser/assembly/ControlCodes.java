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
			add(32, "space");
			add(144, "black", "blk", "ctrl-1");
			add(5, "white", "wht", "ctrl-2", "ctrl-e");
			add(28, "red", "ctrl-3", "ctrl-pound", "ctrl-£");
			add(159, "cyan", "cyn", "ctrl-4");
			add(156, "purple", "pur", "pink", "cm-3");
			add(30, "green", "grn", "ctrl-6", "ctrl-up arrow", "ctrl-↑");
			add(31, "blue", "blu", "ctrl-7", "ctrl-=");
			add(158, "yellow", "yel", "ctrl-8");
			add(129, "orange", "orng", "orn", "cm-1");
			add(149, "brown", "brn", "cm-2");
			add(150, "light red", "lred");
			add(151, "dark grey", "dark gray", "gry1", "cm-4");
			add(152, "grey", "gray", "gry2", "cm-5");
			add(153, "light green", "lgrn", "cm-6");
			add(154, "light blue", "lblu", "cm-7");
			add(155, "light grey", "light gray", "gry3", "cm-8");
			add(18, "reverse on", "rvon", "rvson", "ctrl-r", "ctrl-9");
			add(146, "reverse off", "rvof", "rvsoff", "ctrl-0");
			add(17, "cursor down", "down", "ctrl-q");
			add(145, "cursor up", "up", "shift-cursor down", "shift-down", "sh-cursor down", "sh-down");
			add(157, "cursor left", "left", "shift-cursor-right", "shift-right", "sh-cursor-right", "sh-right");
			add(29, "cursor right", "rght", "right", "ctrl-;");
			add(20, "del", "delete", "ctrl-t");
			add(14, "ctrl-n");
			add(13, "return", "ret", "ctrl-m");
			add(148, "insert", "inst", "shift-delete", "sh-delete", "shift-del", "sh-del");
			add(147, "clear", "clr", "shift-home", "sh-home");
			add(19, "home", "ctrl-s");
			add(133, "f1");
			add(134, "f3");
			add(135, "f5");
			add(136, "f7");
			add(137, "f2", "shift-f1", "sh-f1");
			add(138, "f4", "shift-f3", "sh-f3");
			add(139, "f6", "shift-f5", "sh-f5");
			add(140, "f8", "shift-f7", "sh-f7");
			add(92, "pound", "£");
			add(160, "shift-space", "sh-space");
			add(33, "shift-1", "sh-1");
			add(34, "shift-2", "sh-2");
			add(35, "shift-3", "sh-3");
			add(36, "shift-4", "sh-4");
			add(37, "shift-5", "sh-5");
			add(38, "shift-6", "sh-6");
			add(39, "shift-7", "sh-7");
			add(40, "shift-8", "sh-8");
			add(41, "shift-9", "sh-9");
			add(42, "*", "asterisk");
			add(43, "+", "plus");
			add(44, ",", "comma");
			add(45, "-", "minus");
			add(46, ".", "period");
			add(47, "/", "slash");
			add(58, ":", "colon");
			add(59, ";", "semicolon");
			add(60, "shift-comma", "shift-,", "sh-comma", "sh-,");
			add(61, "equal", "equals", "eq", "=");
			add(62, "shift-period", "shift-.", "sh-period", "sh-.");
			add(63, "shift-slash", "shift-/", "sh-slash", "sh-/");
			add(64, "@", "at");
			add(91, "shift-colon", "shift-:", "sh-colon", "sh-:");
			add(93, "shift-semicolon", "shift-;", "sh-semicolon", "sh-;");
			add(94, "↑", "^", "up arrow");
			add(95, "←", "left arrow");
			add(141, "shift-return", "sh-return", "shift-ret", "sh-ret");
			add(161, "cm-k");
			add(162, "cm-i");
			add(163, "cm-t");
			add(164, "cm-@", "cm-at");
			add(165, "cm-g");
			add(166, "cm-+", "cm-plus");
			add(167, "cm-m");
			add(168, "cm-£", "cm-pound");
			add(169, "shift-£", "shift-pound", "sh-£", "sh-pound");
			add(170, "cm-n");
			add(171, "cm-q");
			add(172, "cm-d");
			add(173, "cm-z");
			add(174, "cm-s");
			add(175, "cm-p");
			add(176, "cm-a");
			add(177, "cm-e");
			add(178, "cm-r");
			add(179, "cm-w");
			add(180, "cm-h");
			add(181, "cm-j");
			add(182, "cm-l");
			add(183, "cm-y");
			add(184, "cm-u");
			add(185, "cm-o");
			add(186, "shift-@", "shift-at", "sh-@", "sh-at");
			add(187, "cm-f");
			add(188, "cm-c");
			add(189, "cm-x");
			add(190, "cm-v");
			add(191, "cm-b");
			add(192, "shift-*", "shift-asterisk", "sh-*", "sh-asterisk");
			add(219, "shift-+", "shift-plus", "sh-+", "sh-plus");
			add(220, "cm--", "cm-minus");
			add(221, "shift--", "shift-minus", "sh--", "sh-minus");
			add(222, "shift-↑", "shift-up arrow", "sh-↑", "sh-up arrow");
			add(223, "cm-*", "cm-asterisk");

			for (int i = 65; i < 91; i++) {
				char c = ((char) (i - 65 + 'a'));
				add(i, "shift-" + c, "sh-" + c);
			}

		}

		public void add(int code, String... placeholders) {
			for (String placy : placeholders) {
				this.put(placy, code);
				this.put(placy.replaceFirst("ctrl", "ct"), code);
				this.put(placy.replaceFirst("-", " "), code);
				this.put(placy.replaceFirst("ctrl", "ct").replaceFirst("-", " "), code);
			}
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
