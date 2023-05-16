package com.sixtyfour.cbmnative;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.sixtyfour.Logger;
import com.sixtyfour.config.CompilerConfig;

/**
 * An optimizer for the native code in intermediate (pseudo) assembly language.
 * 
 * @author EgonOlsen
 * 
 */
public class NativeOptimizer {

	private final static int MAX_AHEAD = 20;
	private static List<NativePattern> patterns = new ArrayList<NativePattern>();

	static {
		List<Integer> pots = new ArrayList<>();
		for (int i = 0; i < 12; i++) {
			pots.add(Integer.valueOf((int) Math.pow(2, i)));
		}
		patterns.add(new NativePattern(new String[] { "MOV Y*", "PUSH Y", "MOV Y*", "JSR POS", "POP Y" }, new String[] { "JSR POS", "{0}" }));
		patterns.add(new NativePattern(new String[] { "MOV Y*", "JSR POS" }, new String[] { "JSR POS" }));
		patterns.add(new NativePattern(new String[] { "PUSH*", "POP*" }, new String[] { "MOV p1,p0" }));
		patterns.add(new NativePattern(new String[] { "PUSH X", "MOV C*|*[]*", "POP Y" }, new String[] { "{1}" }));
		patterns.add(
				new NativePattern(new String[] { "PUSH Y", "MOV Y,*", "POP X" }, new String[] { "MOV X,Y", "{1}" }));
		patterns.add(new NativePattern(new String[] { "MOV Y,#*", "MOV X,#-1{INTEGER}", "MUL X,Y" },
				new String[] { "{0:MOV Y,#>MOV X,#-}" }));
		patterns.add(new NativePattern(new String[] { "MOV Y,*", "MOV X,Y" }, new String[] { "{0:MOV Y,>MOV X,}" }));
		patterns.add(new NativePattern(new String[] { "MOV B,*", "MOV A,B" }, new String[] { "{0:MOV B,>MOV A,}" }));
		patterns.add(new NativePattern(new String[] { "MOV Y*", "PUSH Y", "JSR COMPACT", "MOV A*", "POP X" },
				new String[] { "{2}", "{3}", "{0:MOV Y,>MOV X,}" }));
		patterns.add(new NativePattern(new String[] { "MOV Y*", "PUSH Y", "JSR COMPACTMAX", "MOV A*", "POP X" },
				new String[] { "{2}", "{3}", "{0:MOV Y,>MOV X,}" }));
		patterns.add(new NativePattern(new String[] { "MOV Y*", "PUSH Y", "MOV A*", "POP X" },
				new String[] { "{2}", "{0:MOV Y,>MOV X,}" }));
		patterns.add(new NativePattern(new String[] { "PUSH X", "JSR COMPACT", "MOV A*", "POP X" },
				new String[] { "{1}", "{2}" }));
		patterns.add(new NativePattern(new String[] { "PUSH X", "JSR COMPACTMAX", "MOV A*", "POP X" },
				new String[] { "{1}", "{2}" }));
		patterns.add(new NativePattern(new String[] { "PUSH X", "MOV A*", "POP X" }, new String[] { "{1}" }));
		patterns.add(new NativePattern(new String[] { "MOV Y,X", "MOV X*", "ADD X,Y" },
				new String[] { "{1:MOV X,>MOV Y,}", "{2}" }));
		patterns.add(new NativePattern(new String[] { "MOV Y,X", "MOV X*", "MUL X,Y" },
				new String[] { "{1:MOV X,>MOV Y,}", "{2}" }));
		patterns.add(new NativePattern(new String[] { "PUSH C", "CHGCTX #1", "MOV B*", "POP C" },
				new String[] { "{1}", "{2}" }));
		patterns.add(new NativePattern(new String[] { "MOV X,X" }, new String[] {}));
		patterns.add(new NativePattern(new String[] { "MOV Y,Y" }, new String[] {}));
		patterns.add(
				new NativePattern(new String[] { "PUSH X", "MOV X,#*", "POP Y" }, new String[] { "MOV Y,X", "{1}" }));
		patterns.add(new NativePattern(new String[] { "PUSH Y", "MOV X,#*", "POP Y" }, new String[] { "{1}" }));
		patterns.add(
				new NativePattern(new String[] { "MOV X,#*", "MOVB (Y),X" }, new String[] { "{0:MOV X,>MOVB (Y),}" })); // !!!
		patterns.add(new NativePattern(new String[] { "MOV Y,#*", "MOV G,Y" }, new String[] { "{0:MOV Y,>MOV G,}" }));
		patterns.add(new NativePattern(new String[] { "MOV X,#*", "MOV G,Y" }, new String[] { "{0:MOV X,>MOV G,}" }));
		patterns.add(new NativePattern(new String[] { "INT X,Y", "INT X,X" }, new String[] { "{0}" }));
		patterns.add(new NativePattern(new String[] { "POP C", "PUSH C" }, new String[] {}));
		patterns.add(new NativePattern(
				new String[] { "PUSH C", "MOV C*", "PUSH C", "CHGCTX #1", "MOV B*", "POP D", "POP C" },
				new String[] { "{1:MOV C,>MOV D,}", "{3}", "{4}" }));
		patterns.add(new NativePattern(new String[] { "MOV Y,?}", "POP X" }, new String[] { "{1}", "{0}" }));
		patterns.add(new NativePattern(new String[] { "PUSH X", "NOP", "POP X" }, new String[] { "NOP" }));
		patterns.add(new NativePattern(new String[] { "PUSH Y", "NOP", "POP Y" }, new String[] { "NOP" }));
		// The {0} is actually not needed, because it loads a -1 that's never used into
		// ARG. However, removing it
		// disables some other optimizations at this stage and we don't want that.
		patterns.add(
				new NativePattern(new String[] { "MOV X,#-1{INTEGER}", "MUL X,Y" }, new String[] { "NEG X,Y" }));
		patterns.add(new NativePattern(new String[] { "MOV Y,#-1{INTEGER}", "MUL X,Y" },
				new String[] { "MOV Y,X", "NEG X,Y" }));
		patterns.add(new NativePattern(new String[] { "MOV C,X", "PUSH C" }, new String[] { "PUSH X" }));
		patterns.add(new NativePattern(new String[] { "PUSH C", "MOV Y,#*", "POP C" }, new String[] { "{1}" }));
		patterns.add(new NativePattern(
				new String[] { "MOV Y*", "MOV X*", "PUSH Y", "MOV G*", "CHGCTX #0", "JSR ARRAYACCESS", "POP Y" },
				new String[] { "{1}", "{3}", "{4}", "{5}", "{0}" }));
		patterns.add(new NativePattern(new String[] { "MOV Y,#*", "PUSH Y", "MOV Y*", "MOVB X,(Y)", "POP Y" },
				new String[] { "{2}", "{3}", "{0}" }));

		patterns.add(new NativePattern(new String[] { "PUSH C", "MOV *", "POP C" }, new String[] { "{1}" }));

		// Some microoptimizations to speed up
		// https://www.lemon64.com/forum/privmsg.php?folder=inbox&mode=read&p=348822

		patterns.add(new NativePattern(new String[] { "MOV Y*", "MOVB X,(Y)", "MOV Y,#%", "ADD X,Y" },
				new String[] { "{0}", "{2:MOV Y>MOV A}", "JSR PEEKBYTEADD" }));

		patterns.add(new NativePattern(new String[] { "JSR PEEKBYTEADD", "MOV Y,#%", "AND X,Y" },
				new String[] { "{1:MOV Y>MOV B}", "JSR PEEKBYTEADDAND" }));

		patterns.add(new NativePattern(new String[] { "JSR PEEKBYTEADD", "MOV Y,#%", "OR X,Y" },
				new String[] { "{1:MOV Y>MOV B}", "JSR PEEKBYTEADDOR" }));

		patterns.add(new NativePattern(new String[] { "MOV Y,*", "MOVB X,(Y)", "MOV Y,#%", "AND X,Y" },
				new String[] { "{0}", "{2:MOV Y>MOV A}", "JSR PEEKBYTEAND" }));

		patterns.add(new NativePattern(new String[] { "MOV Y,*", "MOVB X,(Y)", "MOV Y,#%", "OR X,Y" },
				new String[] { "{0}", "{2:MOV Y>MOV A}", "JSR PEEKBYTEOR" }));
		
		// This optimizes the array access for multi-dimensional arrays whose dimensions
		// are a power of 2, like k%(15,15)
		// It does this by rearranging the operations, so that the resulting
		// shr-optimization triggers.
		patterns.add(new NativePattern(new String[] { "MOV Y,#*", "PUSH Y", "MOV Y,*", "INT X,Y", "POP Y", "MUL X,Y" },
				new String[] { "{2}", "{3}", "PUSH X", "{0}", "POP X", "{5}" }));
		
		
		patterns.add(new NativePattern(new String[] {"MOV Y,#*", "PUSH Y", "CHGCTX #1", "MOV B,*", "CHGCTX #0", "JSR *", "POP Y"}, new String[] {"{3}","{5}","{0}"}));
		
		// MID (F$(I),x,y) simplified
		patterns.add(new NativePattern(new String[] {"MOV C,*", "PUSH C", "MOV C,*", "PUSH C", "MOV X,Y{REAL}", "CHGCTX #1", "MOV G,*", "JSR ARRAYACCESS", "MOV B,A", "POP D", "POP C", "JSR MID"}, 
				new String[] {"{4}", "{6}", "{7}", "{8}", "{0}", "{2:MOV C,>MOV D,}", "JSR MID"}));
		
		String[] calls = {"SNEQ", "SEQ", "SGT", "SLT", "SGTEQ", "SLTEQ"};
		
		for (String call:calls) {
			patterns.add(new NativePattern(new String[] {"MOV C,*","MOV D,#1{INTEGER}","CHGCTX #1","MOV B,*","JSR MID","POP B","CHGCTX #0","JSR "+call}, new String[] {"{0}","CHGCTX #1","{3}","JSR CHARAT","{5}","{6}","{7}"}));
		}
		
		// Remove some PUSH/POP to make room for SHL/SHR optimizations
		String[] ops = {"RND", "SIN", "COS", "SQR", "TAN", "EXP"};
		for (String op:ops) {
			patterns.add(new NativePattern(new String[] {"MOV Y,#*", "PUSH Y", "MOV Y,*",op+" X,Y", "POP Y"}, new String[] {"{2}","{3}","{0}"}));
		}

		// Optimizes special cases of a multiplication by, for example, 40 (and similar muls).
		// ...this also covers the former special case for arrays like a(16,16), which require a *17...
		createRulesForMulAndAddSub(pots);
	}

	private static void createRulesForMulAndAddSub(List<Integer> pots) {
		Set<Integer> covered = new HashSet<>(); // we have to make sure to cover only one way (like 48=32+16 and 64-16)
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
							covered.add(total);
							if (secondShift > 0) {
										patterns.add(new NativePattern(new String[] { "MOV X,#" + i + "{INTEGER}", "MUL X,Y" },
										new String[] { "MOV A,#" + firstShift + "{INTEGER}", "MOV X,Y", "SHL X,A",
												"MOV A,#" + secondShift + "{INTEGER}", "SHL Y,A", "ADD X,Y" }));

								patterns.add(new NativePattern(new String[] { "MOV Y,#" + i + "{INTEGER}", "MUL X,Y" },
										new String[] { "MOV A,#" + firstShift + "{INTEGER}", "MOV Y,X", "SHL X,A",
												"MOV A,#" + secondShift + "{INTEGER}", "SHL Y,A", "ADD X,Y" }));	
							} else {
								
								patterns.add(new NativePattern(new String[] { "MOV X,#" + i + "{INTEGER}", "MUL X,Y" },
										new String[] { "MOV A,#" + firstShift + "{INTEGER}", "MOV X,Y", "SHL X,A",
												"ADD X,Y" }));
								patterns.add(new NativePattern(new String[] { "MOV Y,#" + i + "{INTEGER}", "MUL X,Y" },
										new String[] { "MOV A,#" + firstShift + "{INTEGER}", "MOV Y,X", "SHL Y,A",
												"ADD X,Y" }));

							}
						}
					}
				}
			}
		}
		createRulesForMulAndSub(pots,covered);
	}
	
	private static void createRulesForMulAndSub(List<Integer> pots, Set<Integer> covered) {
		for (int i = 0; i <= 320; i++) {
			int firstShift = getNearestPot(pots, i);
			if (firstShift >= 0) {
				if (firstShift<pots.size()-1) {
					int oldPart = pots.get(firstShift);
					if (oldPart==i) {
						continue;
					}
					firstShift++;
					int firstPart = pots.get(firstShift);
					int dif = firstPart - i;
					if (dif != 0) {
						int secondShift = getNearestPot(pots, dif);
						if (secondShift >= 0) {
							int secondPart = pots.get(secondShift);
							int total = firstPart - secondPart;
							if (total == i && !covered.contains(total)) {
								if (secondShift > 0) {
									patterns.add(new NativePattern(new String[] { "MOV X,#" + i + "{INTEGER}", "MUL X,Y" },
											new String[] { "MOV A,#" + firstShift + "{INTEGER}", "MOV X,Y", "SHL X,A",
													"MOV A,#" + secondShift + "{INTEGER}", "SHL Y,A", "SUB X,Y" }));
	
									patterns.add(new NativePattern(new String[] { "MOV Y,#" + i + "{INTEGER}", "MUL X,Y" },
											new String[] { "MOV A,#" + firstShift + "{INTEGER}", "MOV Y,X", "SHL X,A",
													"MOV A,#" + secondShift + "{INTEGER}", "SHL Y,A", "SUB X,Y" }));
								} 
							}
						}
					}
				}
			}
		}
	}

	/**
	 * Optimize the intermediate code
	 * 
	 * @param config the compiler configuration
	 * @param code   the code in intermediate language
	 * @param pg     an optional progress listener
	 * @return the optimized code
	 */
	public static List<String> optimizeNative(CompilerConfig config, List<String> code, ProgressListener pg) {
		if (config.isIntermediateLanguageOptimizations()) {
			Logger.log("Running intermediate code optimizer...");
			code = optimizeNativeInternal(config, code, pg);
		}
		return code;
	}

	static List<String> optimizeNativeInternal(CompilerConfig config, List<String> code, ProgressListener pg) {
		if (config.isIntermediateLanguageOptimizations()) {
			int oldCode = 0;
			if (pg != null) {
				pg.start();
			}
			do {
				if (pg != null) {
					pg.nextStep();
				}
				oldCode = getChecksum(code);
				code = applyPatterns(config, code);
			} while (oldCode != getChecksum(code));
			if (pg != null) {
				pg.done();
			}
		}
		return code;
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
	

	private static int getChecksum(List<String> code) {
		// the optimizer has optimization that change order or commands, but not the
		// actual length.
		// So we can't rely on size for change-detection here. This isn't 100% safe
		// either, but that shouldn't matter too much.
		int val = 0;
		for (String line : code) {
			val ^= line.hashCode();
		}
		return val+code.size();
	}

	private static List<String> applyPatterns(CompilerConfig config, List<String> code) {
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
							String sfo = sfs.replace("*", "").replace("%", "");
							if (sfo.contains("?")) {
								String[] pps = sfo.split("\\?");
								if (lines[p].startsWith(pps[0]) && lines[p].endsWith(pps[1])) {
									subMatch = true;
								} else {
									subMatch = false;
									break;
								}
							} else {
								if (sfs.contains("%")) {
									if (sfs.endsWith("%") && lines[p].startsWith(sfo)
											&& lines[p].endsWith("{INTEGER}")) {
										String num = lines[p].replace(sfo, "").replace("{INTEGER}", "");
										try {
											int numi = Integer.parseInt(num);
											if (numi > 0 && numi <= 255) {
												subMatch = true;
											} else {
												subMatch = false;
												break;
											}
										} catch (Exception e) {
											subMatch = false;
											break;
										}
									} else {
										subMatch = false;
										break;
									}
								} else {
									if ((sfs.startsWith("*") && sfs.endsWith("*") && lines[p].contains(sfo))
											|| (sfs.startsWith("*") && lines[p].endsWith(sfo)
													|| (sfs.endsWith("*") && lines[p].startsWith(sfo))
													|| sfs.equals(lines[p]))) {
										subMatch = true;
									} else {
										subMatch = false;
										break;
									}
								}
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
										if (rw.indexOf("§", pos2) == -1) {
											rs = rs.replace(rw.substring(pos + 1, pos2),
													rw.substring(pos2 + 1, rw.length() - 1));
										} else {
											int pos3 = rw.indexOf("§", pos2);
											int pos4 = rw.indexOf("§", pos3 + 1);
											String fun = rw.substring(pos3 + 1, pos4);
											if (fun.equalsIgnoreCase("chr")) {
												rs = rs.replace(rw.substring(pos + 1, pos2),
														rw.substring(pos2 + 1, pos3));
												pos3 = rs.indexOf(",");
												rs = rs.substring(0, pos3 + 1) + "#{"
														+ rs.substring(pos3 + 2, rs.indexOf("{", pos3)) + "}{STRING}";
											} else {
												throw new RuntimeException("Unknown optimizer function: " + fun);
											}
										}
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

				if (config.isIntOptimizations()) {
					// Not doing these optimizations also disables the
					// corresponding ones in the 6502 optimizer, because it
					// will then never encounter a JSR FXXX call...

					// MOV Y,#1{INTEGER}
					// MOV X,T%{INTEGER}
					// ADD X,Y
					// This is actually not that great in itself, but the native
					// optimizer can build upon it...
					if (lines[0].equals("MOV Y,#1{INTEGER}") && lines[1].startsWith("MOV X")
							&& lines[1].endsWith("%{INTEGER}") && lines[2].equals("ADD X,Y")) {
						ret.add(lines[1]);
						ret.add("JSR FINX");
						i += 2;
						continue;
					}

					// MOV Y,#1{INTEGER}
					// MOV X,R%{INTEGER}
					// SUB X,Y
					// ...this neither...
					if (lines[0].equals("MOV Y,#1{INTEGER}") && lines[1].startsWith("MOV X")
							&& lines[1].endsWith("%{INTEGER}") && lines[2].equals("SUB X,Y")) {
						ret.add(lines[1]);
						ret.add("JSR FDEX");
						i += 2;
						continue;
					}
				}

				if (config.isShiftOptimizations()) {
					// MOV Y,#128{INTEGER}
					// MOV X,U{REAL}
					// DIV X,Y
					if (lines[0].startsWith("MOV Y,#")
							&& (lines[0].endsWith("{INTEGER}") || lines[0].endsWith(".0{REAL}"))
							&& lines[1].startsWith("MOV X,") && lines[2].equals("DIV X,Y")) {
						String val = lines[0].replace("MOV Y,#", "").replace("{INTEGER}", "").replace(".0{REAL}", "");
						float vf = Float.parseFloat(val);
						vf = (float) (Math.log(vf) / Math.log(2));
						if (vf == (int) vf && vf >= 1 && vf <= 8) {
							ret.add("MOV A,#" + (int) vf + "{INTEGER}");
							ret.add(lines[1]);
							ret.add("SHR X,A");
							i += 2;
							continue;
						}
					}

					// MOV Y,#128{INTEGER}
					// MOV X,U{REAL}
					// MUL X,Y
					if (lines[0].startsWith("MOV Y,#")
							&& (lines[0].endsWith("{INTEGER}") || lines[0].endsWith(".0{REAL}"))
							&& lines[1].startsWith("MOV X,") && lines[2].equals("MUL X,Y")) {
						String val = lines[0].replace("MOV Y,#", "").replace("{INTEGER}", "").replace(".0{REAL}", "");
						float vf = Float.parseFloat(val);
						vf = (float) (Math.log(vf) / Math.log(2));
						if (vf == (int) vf && vf >= 1 && vf <= 8) {
							ret.add("MOV A,#" + (int) vf + "{INTEGER}");
							ret.add(lines[1]);
							ret.add("SHL X,A");
							i += 2;
							continue;
						}
					}

					// MOV Y,#128{INTEGER}
					// DIV X,Y
					if (lines[0].startsWith("MOV Y,#")
							&& (lines[0].endsWith("{INTEGER}") || lines[0].endsWith(".0{REAL}"))
							&& lines[1].equals("DIV X,Y")) {
						String val = lines[0].replace("MOV Y,#", "").replace("{INTEGER}", "").replace(".0{REAL}", "");
						float vf = Float.parseFloat(val);
						vf = (float) (Math.log(vf) / Math.log(2));
						if (vf == (int) vf && vf >= 1 && vf <= 8) {
							ret.add("MOV A,#" + (int) vf + "{INTEGER}");
							ret.add("SHR X,A");
							i += 1;
							continue;
						}
					}

					// MOV Y,#128{INTEGER}
					// MUL X,Y
					if (lines[0].startsWith("MOV Y,#")
							&& (lines[0].endsWith("{INTEGER}") || lines[0].endsWith(".0{REAL}"))
							&& lines[1].equals("MUL X,Y")) {
						String val = lines[0].replace("MOV Y,#", "").replace("{INTEGER}", "").replace(".0{REAL}", "");
						float vf = Float.parseFloat(val);
						vf = (float) (Math.log(vf) / Math.log(2));
						if (vf == (int) vf && vf >= 1 && vf <= 8) {
							ret.add("MOV A,#" + (int) vf + "{INTEGER}");
							ret.add("SHL X,A");
							i += 1;
							continue;
						}
					}
				}

				// MOV X,#6{INTEGER}
				// MOVB 53280,X
				if (lines[0].startsWith("MOV X,#") && lines[1].startsWith("MOVB") && lines[1].endsWith(",X")
						&& !lines[1].contains("(")) {
					ret.add(lines[1].replace(",X", lines[0].substring(lines[0].indexOf(","))));
					i += 1;
					continue;
				}

				if (lines[0].contains("INTEGER") && lines[0].startsWith("MOV Y,#")
						&& (lines[1].equals("MOV X,(Y)") || lines[1].equals("MOVB X,(Y)"))) {
					try {
						int addr = Integer
								.parseInt(lines[0].substring(lines[0].indexOf("#") + 1, lines[0].indexOf("{")));
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
						if (splittedLines[1][1].equals("Y") && splittedLines[0][1].equals(splittedLines[1][2])
								&& splittedLines[0][1].contains("{")) {
							ret.add(lines[0]);
							ret.add("MOV Y,X");
							i += 1;
							continue;
						}
					} else if (splittedLines[0][0].equals("MOV") && splittedLines[0][2].equals("Y")) {
						if (splittedLines[1][1].equals("X") && splittedLines[0][1].equals(splittedLines[1][2])
								&& splittedLines[0][1].contains("{")) {
							ret.add(lines[0]);
							ret.add("MOV X,Y");
							i += 1;
							continue;
						}
					}
				}

				if (splittedLines[2] != null && splittedLines[2].length > 2 && splittedLines[0].length > 2
						&& lines[3] != null && splittedLines[0][0].equals("MOV") && splittedLines[0][2].equals("X")
						&& splittedLines[2][2].equals(splittedLines[0][1]) && lines[1].startsWith("MOV Y")
						&& (lines[3].equals("ADD X,Y") || lines[3].equals("SUB X,Y") || lines[3].equals("MUL X,Y")
								|| lines[3].equals("DIV X,Y"))) {
					ret.add(lines[0]);
					ret.add(lines[1]);
					ret.add(lines[3]);
					i += 3;
					continue;
				}

				// Detect and replace simple for-poke-loops
				int oldi = i;
				i = detectFastFor(config, ret, lines, i);
				if (i != oldi) {
					// Something has changed, skip the rest...
					continue;
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

	private static int detectFastFor(CompilerConfig config, List<String> ret, String[] lines, int i) {
		if (config.isLoopOptimizations()) {

			// Loop type 1
			if (lines[18] != null) {
				if (lines[0].startsWith("MOV Y,") && (lines[0].endsWith("{INTEGER}") || lines[0].endsWith(".0{REAL}"))
						&& lines[1].startsWith("MOV") && lines[1].endsWith(",Y") && lines[2].equals("NOP")
						&& lines[3].startsWith("MOV Y,")
						&& (lines[3].endsWith("{INTEGER}") || lines[3].endsWith(".0{REAL}"))) {
					if (lines[4].equals("PUSH Y") && lines[5].equals("NOP") && lines[6].startsWith("MOV Y,")
							&& (lines[6].endsWith("{INTEGER}") || lines[6].endsWith(".0{REAL}"))
							&& lines[7].equals("PUSH Y")) {
						if (lines[8].startsWith("MOV A,(") && lines[9].equals("JSR INITFOR") && lines[10].equals("NOP")
								&& lines[11].startsWith("MOV Y,")) {
							if (lines[12].equals("PUSH Y") && lines[13].startsWith("MOV X,")
									&& lines[14].equals("POP Y") && lines[15].equals("MOVB (Y),X")
									&& lines[16].equals("NOP") && lines[17].startsWith("MOV A,")
									&& lines[18].equals("JSR NEXT")) {
								// Make sure that the loop variable is
								// actually the poke's target...
								// BY checking if MOV A,(I{REAL}) == MOV
								// Y,I{REAL} after some replacements.
								if (lines[8].replace("(", "").replace(")", "").replace("A,", "Y,").equals(lines[11])) {
									String[] parts = lines[1].split(" |\\{");
									String var = parts[1];
									if (lines[17].contains(var + "{}") || lines[17].contains("#0{")) {
										ret.add(lines[0]);
										ret.add(lines[1]);
										ret.add(lines[3]);
										ret.add(lines[4]);
										ret.add(lines[6]);
										ret.add(lines[7]);
										ret.add(lines[8]);
										ret.add(lines[13]);
										ret.add("JSR FASTFOR");
										i += 18;
										return i;
									}
								}
							}
						}
					}
				}
			}
			
			
			// Loop type 2...actually, this shouldn't be needed. The difference is in line 13/14 only. The generic optimizer rules
			// should handle this, but the order in which things happen is a problem here. The correct of doing it would be to
			// run all the generic rules until nothing changes and THEN run the detection for fast fors...but that's not the way
			// it is. It all happens interleaved...maybe one day...
			if (lines[19] != null) {
				if (lines[0].startsWith("MOV Y,") && (lines[0].endsWith("{INTEGER}") || lines[0].endsWith(".0{REAL}"))
						&& lines[1].startsWith("MOV") && lines[1].endsWith(",Y") && lines[2].equals("NOP")
						&& lines[3].startsWith("MOV Y,")
						&& (lines[3].endsWith("{INTEGER}") || lines[3].endsWith(".0{REAL}"))) {
					if (lines[4].equals("PUSH Y") && lines[5].equals("NOP") && lines[6].startsWith("MOV Y,")
							&& (lines[6].endsWith("{INTEGER}") || lines[6].endsWith(".0{REAL}"))
							&& lines[7].equals("PUSH Y")) {
						if (lines[8].startsWith("MOV A,(") && lines[9].equals("JSR INITFOR") && lines[10].equals("NOP")
								&& lines[11].startsWith("MOV Y,")) {
							if (lines[12].equals("PUSH Y") && lines[13].startsWith("MOV Y,") && lines[14].equals("MOV X,Y")
									&& lines[15].equals("POP Y") && lines[16].equals("MOVB (Y),X")
									&& lines[17].equals("NOP") && lines[18].startsWith("MOV A,")
									&& lines[19].equals("JSR NEXT")) {
								// Make sure that the loop variable is
								// actually the poke's target...
								// BY checking if MOV A,(I{REAL}) == MOV
								// Y,I{REAL} after some replacements.
								if (lines[8].replace("(", "").replace(")", "").replace("A,", "Y,").equals(lines[11])) {
									String[] parts = lines[1].split(" |\\{");
									String var = parts[1];
									if (lines[18].contains(var + "{}") || lines[18].contains("#0{")) {
										ret.add(lines[0]);
										ret.add(lines[1]);
										ret.add(lines[3]);
										ret.add(lines[4]);
										ret.add(lines[6]);
										ret.add(lines[7]);
										ret.add(lines[8]);
										ret.add(lines[13].replace("MOV Y", "MOV X"));
										ret.add("JSR FASTFOR");
										i += 19;
										return i;
									}
								}
							}
						}
					}
				}
			}
			
		}
		return i;
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

		public String toString() {
			return Arrays.toString(toReplace) + " -> " + Arrays.toString(replaceWith);
		}
	}
}
