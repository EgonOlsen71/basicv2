package com.sixtyfour.cbmnative;

import java.util.ArrayList;
import java.util.List;

/**
 * An optimizer for the native code in pseudo assembly language. This one is
 * much less sophisticated than for example the one for 6502-code and should be
 * re-done at one time. But that time isn't now...
 * 
 * @author EgonOlsen
 * 
 */
public class NativeOptimizer {

    public static List<String> optimizeNative(List<String> code) {
	int oldCode = 0;
	do {
	    oldCode = code.size();
	    code = optimizeNative1(code);
	    code = optimizeNative2(code);
	} while (oldCode != code.size());

	return code;
    }

    private static List<String> optimizeNative1(List<String> code) {
	List<String> ret = new ArrayList<String>();
	if (code.size() > 1) {
	    for (int i = 0; i < code.size() - 1; i++) {
		String l0 = code.get(i);
		String l1 = code.get(i + 1);
		String l2 = null;
		if (i < code.size() - 2) {
		    l2 = code.get(i + 2);
		}

		String[] l0ps = l0.split(" |,");
		String[] l1ps = l1.split(" |,");

		if (l0.startsWith("PUSH") && l1.startsWith("POP")) {
		    ret.add("MOV " + l1ps[1] + "," + l0ps[1]);
		    i += 1;
		    continue;
		}

		if (l2 != null && l0.equals("PUSH X") && l1.startsWith("MOV C") && l1.contains("[]")
			&& l2.equals("POP Y")) {
		    ret.add(l1);
		    i += 2;
		    continue;
		}

		// PUSH Y
		// MOV Y,A{REAL}
		// POP X
		if (l0.endsWith("PUSH Y") && l1.startsWith("MOV Y,") && l2.equals("POP X")) {
		    ret.add("MOV X,Y");
		    ret.add(l1);
		    i += 2;
		    continue;
		}

		// MOV Y,#2.0{REAL}
		// MOV X,#-1{INTEGER}
		// MUL X,Y
		if (l0.startsWith("MOV Y,#") && l1.contains("MOV X,#-1{INTEGER}") && l2.contains("MUL X,Y")) {
		    int pos = l0.indexOf("#");
		    ret.add(l0.substring(0, pos + 1).replace("Y,", "X,") + "-" + l0.substring(pos + 1));
		    i += 2;
		    continue;
		}

		// MOV Y,#4096{INTEGER}
		// MOV X,(Y)
		if (l0.contains("INTEGER") && l0.startsWith("MOV Y,#")
			&& (l1.equals("MOV X,(Y)") || l1.equals("MOVB X,(Y)"))) {
		    try {
			int addr = Integer.parseInt(l0.substring(l0.indexOf("#") + 1, l0.indexOf("{")));
			if (l1.equals("MOVB X,(Y)")) {
			    ret.add("MOVB X," + addr);
			} else {
			    ret.add("MOV X," + addr);
			}
			i += 1;
			continue;
		    } catch (Exception e) {
			//
		    }
		}

		if (l0.startsWith("MOV Y,") && l1.equals("MOV X,Y")) {
		    ret.add(l0.replace("MOV Y,", "MOV X,"));
		    i += 1;
		    continue;
		}

		if (l0.startsWith("MOV B,") && l1.equals("MOV A,B")) {
		    ret.add(l0.replace("MOV B,", "MOV A,"));
		    i += 1;
		    continue;
		}

		if (l0ps.length == 3 && l1ps.length == 3) {
		    if (l0ps[0].equals("MOV") && l0ps[2].equals("X")) {
			if (l1ps[1].equals("Y") && l0ps[1].equals(l1ps[2]) && l0ps[1].contains("{")) {
			    ret.add(l0);
			    ret.add("MOV Y,X");
			    i += 1;
			    continue;
			}
		    } else if (l0ps[0].equals("MOV") && l0ps[2].equals("Y")) {
			if (l1ps[1].equals("X") && l0ps[1].equals(l1ps[2]) && l0ps[1].contains("{")) {
			    ret.add(l0);
			    ret.add("MOV X,Y");
			    i += 1;
			    continue;
			}
		    }
		}

		boolean rep = false;
		for (char c : new char[] { 'C', 'D' }) {
		    if (l1.startsWith("MOV " + c + ",")) {
			if (l0.startsWith("MOV ")) {
			    int pos = l0.indexOf(",");
			    String r0 = l0.substring(4, pos).trim();
			    String r1 = l1.substring(6).trim();
			    if (r0.equals(r1)) {
				String right = l0.substring(pos + 1).trim();
				ret.add("MOV " + c + "," + right);
				rep = true;
				break;
			    }
			}
		    }
		}
		if (!rep) {
		    ret.add(l0);
		} else {
		    i++;
		}
	    }
	    ret.add(code.get(code.size() - 1));
	} else {
	    ret.addAll(code);
	}
	return ret;
    }

    private static List<String> optimizeNative2(List<String> code) {
	List<String> ret = new ArrayList<String>();
	if (code.size() > 1) {
	    for (int i = 0; i < code.size() - 1; i++) {
		String l0 = code.get(i);
		String l1 = code.get(i + 1);
		String l2 = null;
		if (i < code.size() - 2) {
		    l2 = code.get(i + 2);
		}
		String l3 = null;
		if (i < code.size() - 3) {
		    l3 = code.get(i + 3);
		}
		String l4 = null;
		if (i < code.size() - 4) {
		    l4 = code.get(i + 4);
		}

		String[] l0ps = l0.split(" |,");
		String[] l2ps = null;

		if (l2 != null) {
		    l2ps = l2.split(" |,");
		}

		// MOV Y,#2{INTEGER}
		// PUSH Y
		// JSR COMPACT
		// MOV A,#hello{STRING}
		// POP X
		if (l2 != null && l3 != null && l4 != null && l0.startsWith("MOV Y") && l1.equals("PUSH Y")
			&& l2.equals("JSR COMPACT") && l3.startsWith("MOV A") && l4.equals("POP X")) {
		    ret.add(l2);
		    ret.add(l3);
		    ret.add(l0.replace("MOV Y,", "MOV X,"));
		    i += 4;
		    continue;
		}

		// PUSH X
		// JSR COMPACT
		// MOV A,#world!{STRING}
		// POP X
		if (l2 != null && l3 != null && l0.equals("PUSH X") && l1.equals("JSR COMPACT")
			&& l2.startsWith("MOV A") && l3.equals("POP X")) {
		    ret.add(l1);
		    ret.add(l2);
		    i += 3;
		    continue;
		}

		// MOV Y,X
		// MOV X,#7.2{REAL}
		// ADD X,Y
		if (l2 != null && l0.equals("MOV Y,X") && l1.startsWith("MOV X")
			&& (l2.equals("ADD X,Y") || l2.equals("MUL X,Y"))) {
		    ret.add(l1.replace("MOV X,", "MOV Y,"));
		    ret.add(l2);
		    i += 2;
		    continue;
		}

		// MOV A{REAL},X
		// MOV Y,#35{INTEGER}
		// MOV X,A{REAL}
		// ADD X,Y
		if (l2ps != null && l2ps.length > 2 && l0ps.length > 2 && l3 != null && l0ps[0].equals("MOV")
			&& l0ps[2].equals("X") && l2ps[2].equals(l0ps[1]) && l1.startsWith("MOV Y")
			&& (l3.equals("ADD X,Y") || l3.equals("SUB X,Y") || l3.equals("MUL X,Y")
				|| l3.equals("DIV X,Y"))) {
		    ret.add(l0);
		    ret.add(l1);
		    ret.add(l3);
		    i += 3;
		    continue;
		}

		ret.add(l0);
	    }
	    ret.add(code.get(code.size() - 1));
	} else {
	    ret.addAll(code);
	}
	return ret;
    }
}
