package com.sixtyfour.cbmnative;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.system.CompilerConfig;

/**
 * An optimizer for the native code in pseudo assembly language.
 * 
 * @author EgonOlsen
 * 
 */
public class NativeOptimizer {

	private final static int MAX_AHEAD = 15;
	private static List<NativePattern> patterns = new ArrayList<NativePattern>();
	private static boolean optimizeSimpleForPokeLoops = true;

	static {
		patterns.add(new NativePattern(new String[] { "PUSH*", "POP*" }, new String[] { "MOV p1,p0" }));
		patterns.add(new NativePattern(new String[] { "PUSH X", "MOV C*|*[]*", "POP Y" }, new String[] { "{1}" }));
		patterns.add(new NativePattern(new String[] { "PUSH Y", "MOV Y,*", "POP X" }, new String[] { "MOV X,Y", "{1}" }));
		patterns.add(new NativePattern(new String[] { "MOV Y,#*", "MOV X,#-1{INTEGER}", "MUL X,Y" }, new String[] { "{0:MOV Y,#>MOV X,#-}" }));
		patterns.add(new NativePattern(new String[] { "MOV Y,*", "MOV X,Y" }, new String[] { "{0:MOV Y,>MOV X,}" }));
		patterns.add(new NativePattern(new String[] { "MOV B,*", "MOV A,B" }, new String[] { "{0:MOV B,>MOV A,}" }));
		patterns.add(new NativePattern(new String[] { "MOV Y*", "PUSH Y", "JSR COMPACT", "MOV A*", "POP X" }, new String[] { "{2}", "{3}", "{0:MOV Y,>MOV X,}" }));
		patterns.add(new NativePattern(new String[] { "MOV Y*", "PUSH Y", "MOV A*", "POP X" }, new String[] { "{2}", "{0:MOV Y,>MOV X,}" }));
		patterns.add(new NativePattern(new String[] { "PUSH X", "JSR COMPACT", "MOV A*", "POP X" }, new String[] { "{1}", "{2}" }));
		patterns.add(new NativePattern(new String[] { "PUSH X", "MOV A*", "POP X" }, new String[] { "{1}" }));
		patterns.add(new NativePattern(new String[] { "MOV Y,X", "MOV X*", "ADD X,Y" }, new String[] { "{1:MOV X,>MOV Y,}", "{2}" }));
		patterns.add(new NativePattern(new String[] { "MOV Y,X", "MOV X*", "MUL X,Y" }, new String[] { "{1:MOV X,>MOV Y,}", "{2}" }));
		patterns.add(new NativePattern(new String[] { "PUSH C", "CHGCTX #1", "MOV B*", "POP C" }, new String[] { "{1}", "{2}" }));
		patterns.add(new NativePattern(new String[] { "MOV X,X" }, new String[] {}));
		patterns.add(new NativePattern(new String[] { "MOV Y,Y" }, new String[] {}));
		patterns.add(new NativePattern(new String[] { "PUSH X", "MOV X,#*", "POP Y" }, new String[] { "MOV Y,X", "{1}" }));
		patterns.add(new NativePattern(new String[] { "PUSH Y", "MOV X,#*", "POP Y" }, new String[] { "{1}" }));
		patterns.add(new NativePattern(new String[] { "MOV X,#*", "MOVB (Y),X" }, new String[] { "{0:MOV X,>MOVB (Y),}" }));
		// Don't do this...it actually deoptimizes things by killing some
		// 6502-optimizations later in the process.
		// patterns.add(new NativePattern(new String[] { "MOV Y,*", "PUSH Y",
		// "MOV Y,*", "* X,Y", "POP Y" }, new String[] { "{2}", "{3}", "{0}"
		// }));
		patterns.add(new NativePattern(new String[] { "PUSH C", "MOV C*", "PUSH C", "CHGCTX #1", "MOV B*", "POP D", "POP C" }, new String[] { "{1:MOV C,>MOV D,}", "{3}", "{4}" }));

		// The fact that NOPs are inserted between expressions now kills the
		// fastfor-optimizer. This little hack revives it...
		patterns.add(new NativePattern(new String[] { "MOV Y,#*", "PUSH Y", "NOP", "MOV Y,#*", "PUSH Y", "NOP" }, new String[] { "{0}", "{1}", "{3}", "{4}" }));
	}

	public static List<String> optimizeNative(List<String> code) {
		if (CompilerConfig.getConfig().isIntermediateLanguageOptimizations()) {
			int oldCode = 0;
			do {
				oldCode = code.size();
				code = applyPatterns(code);
			} while (oldCode != code.size());
		}
		return code;
	}

	private static List<String> applyPatterns(List<String> code) {
		List<String> ret = new ArrayList<String>();
		String[] lines = new String[MAX_AHEAD];
		String[][] splittedLines = new String[MAX_AHEAD][];

		if (code.size() > 1) {
			for (int i = 0; i < code.size() - 1; i++) {
				boolean cont = false;
				int p = 0;
				String line0 = code.get(i);
				for (; p < MAX_AHEAD && p + i < code.size(); p++) {
					String line = code.get(p + i);
					lines[p] = line;
					splittedLines[p] = lines[p].split(" |,");
				}
				for (; p < MAX_AHEAD; p++) {
					lines[p] = null;
					splittedLines[p] = null;
				}

				for (NativePattern pattern : patterns) {
					String[] toReplace = pattern.getToReplace();
					String[] replaceWith = pattern.getReplaceWith();

					boolean match = true;
					for (p = 0; p < toReplace.length; p++) {
						if (lines[p] == null) {
							match = false;
							break;
						}
						String sf = toReplace[p];
						String[] parts = sf.split("\\|");
						boolean subMatch = true;
						for (String sfs : parts) {
							String sfo = sfs.replace("*", "");
							if ((sfs.startsWith("*") && sfs.endsWith("*") && lines[p].contains(sfo))
									|| (sfs.startsWith("*") && lines[p].endsWith(sfo) || (sfs.endsWith("*") && lines[p].startsWith(sfo)) || sfs.equals(lines[p]))) {
								subMatch = true;
							} else {
								subMatch = false;
								break;
							}
						}
						match = subMatch;
						if (!match) {
							break;
						}
					}
					if (match) {
						for (p = 0; p < replaceWith.length; p++) {
							String rw = replaceWith[p];
							String rs = null;
							if (rw != null && !rw.isEmpty()) {
								if (rw.startsWith("{") && rw.endsWith("}")) {
									int pos = rw.indexOf(":");
									String num = null;
									if (pos == -1) {
										num = rw.substring(1, rw.length() - 1);
									} else {
										num = rw.substring(1, pos);
									}
									rs = lines[Integer.parseInt(num)];
									if (pos != -1) {
										int pos2 = rw.indexOf(">", pos);
										rs = rs.replace(rw.substring(pos + 1, pos2), rw.substring(pos2 + 1, rw.length() - 1));
									}
								}
								if (rs == null) {
									rs = replaceWith[p];
									for (int u = 0; u < MAX_AHEAD && splittedLines[u] != null; u++) {
										if (splittedLines[u].length > 1) {
											rs = rs.replace("p" + u, splittedLines[u][1]);
										}
									}
								}
							}
							ret.add(rs);
						}
						cont = true;
						i += toReplace.length - 1;
						// System.out.println("Applied: " +
						// Arrays.toString(pattern.toReplace));
					}

				}
				if (cont) {
					continue;
				}

				// Special optimizations without a pattern definition...

				// MOV X,#6{INTEGER}
				// MOVB 53280,X
				if (lines[0].startsWith("MOV X,#") && lines[1].startsWith("MOVB") && lines[1].endsWith(",X") && !lines[1].contains("(")) {
					ret.add(lines[1].replace(",X", lines[0].substring(lines[0].indexOf(","))));
					i += 1;
					continue;
				}

				if (lines[0].contains("INTEGER") && lines[0].startsWith("MOV Y,#") && (lines[1].equals("MOV X,(Y)") || lines[1].equals("MOVB X,(Y)"))) {
					try {
						int addr = Integer.parseInt(lines[0].substring(lines[0].indexOf("#") + 1, lines[0].indexOf("{")));
						if (lines[1].equals("MOVB X,(Y)")) {
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

				if (splittedLines[0].length == 3 && splittedLines[1].length == 3) {
					if (splittedLines[0][0].equals("MOV") && splittedLines[0][2].equals("X")) {
						if (splittedLines[1][1].equals("Y") && splittedLines[0][1].equals(splittedLines[1][2]) && splittedLines[0][1].contains("{")) {
							ret.add(lines[0]);
							ret.add("MOV Y,X");
							i += 1;
							continue;
						}
					} else if (splittedLines[0][0].equals("MOV") && splittedLines[0][2].equals("Y")) {
						if (splittedLines[1][1].equals("X") && splittedLines[0][1].equals(splittedLines[1][2]) && splittedLines[0][1].contains("{")) {
							ret.add(lines[0]);
							ret.add("MOV X,Y");
							i += 1;
							continue;
						}
					}
				}

				if (splittedLines[2] != null && splittedLines[2].length > 2 && splittedLines[0].length > 2 && lines[3] != null && splittedLines[0][0].equals("MOV")
						&& splittedLines[0][2].equals("X") && splittedLines[2][2].equals(splittedLines[0][1]) && lines[1].startsWith("MOV Y")
						&& (lines[3].equals("ADD X,Y") || lines[3].equals("SUB X,Y") || lines[3].equals("MUL X,Y") || lines[3].equals("DIV X,Y"))) {
					ret.add(lines[0]);
					ret.add(lines[1]);
					ret.add(lines[3]);
					i += 3;
					continue;
				}

				// Detect and replace simple for-poke-loops
				if (optimizeSimpleForPokeLoops && lines[14] != null) {
					if (lines[0].startsWith("MOV Y,") && (lines[0].endsWith("{INTEGER}") || lines[0].endsWith(".0{REAL}")) && lines[1].equals("PUSH Y")
							&& lines[2].startsWith("MOV Y,") && (lines[2].endsWith("{INTEGER}") || lines[2].endsWith(".0{REAL}"))) {
						if (lines[3].equals("PUSH Y") && lines[4].startsWith("MOV Y,") && (lines[4].endsWith("{INTEGER}") || lines[4].endsWith(".0{REAL}"))
								&& lines[5].startsWith("MOV") && lines[5].endsWith(",Y")) {
							if (lines[6].startsWith("MOV A,(") && lines[7].equals("JSR INITFOR") && lines[8].startsWith("MOV Y,") && lines[9].equals("PUSH Y")
									&& lines[10].startsWith("MOV X,")) {
								if (lines[10].endsWith("}") && lines[11].equals("POP Y") && lines[12].equals("MOVB (Y),X") && lines[13].startsWith("MOV A,")
										&& lines[14].equals("JSR NEXT")) {
									String[] parts = lines[5].split(" |\\{");
									String var = parts[1];
									if (lines[13].contains(var + "{}") || lines[13].contains("#0{")) {
										ret.add(lines[0]);
										ret.add(lines[1]);
										ret.add(lines[2]);
										ret.add(lines[3]);
										ret.add(lines[4]);
										ret.add(lines[5]);
										ret.add(lines[6]);
										ret.add(lines[10]);
										ret.add("JSR FASTFOR");
										i += 14;
										continue;
									}
								}
							}
						}
					}
				}

				// Opti2
				boolean rep = false;
				for (char c : new char[] { 'C', 'D' }) {
					if (lines[1].startsWith("MOV " + c + ",")) {
						if (lines[0].startsWith("MOV ")) {
							int pos = lines[0].indexOf(",");
							String r0 = lines[0].substring(4, pos).trim();
							String r1 = lines[1].substring(6).trim();
							if (r0.equals(r1)) {
								String right = lines[0].substring(pos + 1).trim();
								ret.add("MOV " + c + "," + right);
								rep = true;
								break;
							}
						}
					}
				}
				if (!rep) {
					ret.add(line0);
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

	private static class NativePattern {

		private String[] toReplace;

		private String[] replaceWith;

		public NativePattern(String[] toReplace, String[] replaceWith) {
			this.toReplace = toReplace;
			this.replaceWith = replaceWith;
		}

		public String[] getToReplace() {
			return toReplace;
		}

		public String[] getReplaceWith() {
			return replaceWith;
		}
	}
}
