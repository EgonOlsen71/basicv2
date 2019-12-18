package com.sixtyfour.parser.cbmnative;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import com.sixtyfour.parser.assembly.ControlCodes;

/**
 * Converts files in .PRG format back into ASCII by replacing the BASIC tokens
 * and such. Supports C64 and VIC 20 BASIC V2 and the X16's extensions.
 * 
 * @author EgonOlsen71
 */
public class UnTokenizer {

	private final static Map<Integer, String> TOKENS = new HashMap<Integer, String>() {
		private static final long serialVersionUID = 1L;
		{
			this.put(128, "END");
			this.put(129, "FOR");
			this.put(130, "NEXT");
			this.put(131, "DATA");
			this.put(132, "INPUT#");
			this.put(133, "INPUT");
			this.put(134, "DIM");
			this.put(135, "READ");
			this.put(136, "LET");
			this.put(137, "GOTO");
			this.put(138, "RUN");
			this.put(139, "IF");
			this.put(140, "RESTORE");
			this.put(141, "GOSUB");
			this.put(142, "RETURN");
			this.put(143, "REM");
			this.put(144, "STOP");
			this.put(145, "ON");
			this.put(146, "WAIT");
			this.put(147, "LOAD");
			this.put(148, "SAVE");
			this.put(149, "VERIFY");
			this.put(150, "DEF");
			this.put(151, "POKE");
			this.put(152, "PRINT#");
			this.put(153, "PRINT");
			this.put(154, "CONT");
			this.put(155, "LIST");
			this.put(156, "CLR");
			this.put(157, "CMD");
			this.put(158, "SYS");
			this.put(159, "OPEN");
			this.put(160, "CLOSE");
			this.put(161, "GET");
			this.put(162, "NEW");
			this.put(163, "TAB(");
			this.put(164, "TO");
			this.put(165, "FN");
			this.put(166, "SPC(");
			this.put(167, "THEN");
			this.put(168, "NOT");
			this.put(169, "STEP");
			this.put(170, "+");
			this.put(171, "-");
			this.put(172, "*");
			this.put(173, "/");
			this.put(174, "^");
			this.put(175, "AND");
			this.put(176, "OR");
			this.put(177, ">");
			this.put(178, "=");
			this.put(179, "<");
			this.put(180, "SGN");
			this.put(181, "INT");
			this.put(182, "ABS");
			this.put(183, "USR");
			this.put(184, "FRE");
			this.put(185, "POS");
			this.put(186, "SQR");
			this.put(187, "RND");
			this.put(188, "LOG");
			this.put(189, "EXP");
			this.put(190, "COS");
			this.put(191, "SIN");
			this.put(192, "TAN");
			this.put(193, "ATN");
			this.put(194, "PEEK");
			this.put(195, "LEN");
			this.put(196, "STR$");
			this.put(197, "VAL");
			this.put(198, "ASC");
			this.put(199, "CHR$");
			this.put(200, "LEFT$");
			this.put(201, "RIGHT$");
			this.put(202, "MID$");
			this.put(203, "GO");
			
			// X16-Extensions go here...this isn't really a good solution, it
			// would be better to make the extension itself fill this, but
			// I can't be bothered right now...
			this.put(0xCE86, "SCREEN");
			this.put(0xCE87, "PSET");
			this.put(0xCE8A, "RECT");
			this.put(0xCE88, "LINE");
			this.put(0xCE89, "FRAME");
			this.put(0xCE8B, "CHAR");
			this.put(0xCE8C, "MOUSE");
			this.put(0xCE8E, "MX");
			this.put(0xCE8F, "MY");
			this.put(0xCE90, "MB");
			this.put(0xCE84, "VPOKE");
			this.put(0xCE8D, "VPEEK");
			this.put(0xCE81, "DOS");
			this.put(0xCE80, "MON");
			this.put(0xCE82, "OLD");
			this.put(0xCE83, "GEOS");
		}
	};

	public UnTokenizer() {
		//
	}

	/**
	 * Converts a PRG file into ASCII format
	 * 
	 * @param program the file in binary
	 * @return the ascii version of it
	 */
	public List<String> getText(byte[] program, boolean multiByte) {
		List<String> lines = new ArrayList<>();
		StringBuilder line = new StringBuilder();

		int start = getInt(program, 0);
		int addr = start + 2;
		boolean done = false;

		while (!done) {
			int nextLine = getInt(program, addr - start);
			if (nextLine == 0) {
				done = true;
			} else {
				addr += 2;
				int ln = getInt(program, addr - start);
				line.append(ln).append(' ');
				addr += 2;
				int b = 0;
				boolean inString = false;
				do {
					b = program[(addr++) - start] & 0xff;
					if (b != 0) {
						char c = (char) b;
						if (c == '"') {
							inString = !inString;
						}
						if (b < 128 || inString || (b > 203 && (!multiByte || b!=206))) {
							if (inString && isSpecialChar(c)) {
								line.append(ControlCodes.getPlaceHolder(b));
							} else {
								line.append(convertChar(c));
							}
						} else {
						    	String token = TOKENS.get(b);
						    	if (multiByte && b==206) {
						    	    int mb = b*256+(program[(addr++) - start] & 0xff);
						    	    token=TOKENS.get(mb);
						    	}
							if (token == null) {
								throw new RuntimeException("Unknown token: " + b);
							}
							if (line.length() > 0 && line.charAt(line.length() - 1) != ' ' && b < 180
									&& token.length() > 1) {
								line.append(' ');
							}
							line.append(token.toLowerCase(Locale.ENGLISH));
							if (token.length() > 1 && b < 180) {
								line.append(' ');
							}
						}
					}
				} while (b != 0);
				addr = nextLine + 2;
				String ls = line.toString().replaceAll("\\s{2,}", " ");
				lines.add(ls);
				line.setLength(0);
			}
		}
		return lines;
	}

	private char convertChar(char c) {
		if (c > 64 && c < 91) {
			return (char) (c + 32);
		}
		if (c > 96 && c < 123) {
			return (char) (c - 32);
		}

		if (c == 94) {
			c = '^';
		}

		/*
		 * if (c == 92) { c = '£'; }
		 */
		return c;
	}

	private boolean isSpecialChar(char c) {
		return c < 32 || (c > 90 && c < 97) || c > 122;
	}

	private int getInt(byte[] program, int index) {
		return (program[index] & 0xff) + 256 * (program[index + 1] & 0xff);
	}

}
