package com.sixtyfour.cbmnative;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.sixtyfour.Logger;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.util.VarUtils;

/**
 * A helper class that can compact 6502 assembly code by identifying repeating
 * patterns, moving them into subroutines and replacing them by calls to these
 * subroutines. This reduces code size but increases execution time.
 * 
 * @author EgonOlsen
 *
 */
public class Compactor {

	private int threshold = 4;
	private int extCount = 0;
	private Map<Integer, List<Line>> lines = new HashMap<>();

	/**
	 * Creates a new compactor.
	 * 
	 * @param threshold the minimum length of the pattern to identify.
	 */
	public Compactor(int threshold) {
		this.threshold = threshold;
	}

	/**
	 * Inlines integer constants.
	 * 
	 * @param nCode the native code
	 * @return the native code with inlined integer constants
	 */
	public List<String> inlineIntegerConstants(List<String> nCode) {
		Map<String, Number> const2Value = Util.extractNumberConstants(nCode);
		int reps = 0;
		for (int i = 0; i < nCode.size(); i++) {
			String line = nCode.get(i);
			int pos = line.indexOf("CONST_");
			if (pos != -1 && line.contains("LD") && !line.contains("<") && !line.contains(">")) {
				String cst = line.substring(pos, line.length()).trim();
				String cn = cst.replace("+1", "");
				if (cn.contains("R")) {
					continue;
				}
				boolean isHighByte = cst.length() != cn.length();
				Object val = const2Value.get(cn);
				if (VarUtils.isInteger(val)) {
					int ival = VarUtils.getInt(val);
					if (isHighByte) {
						ival = ival >> 8;
					} else {
						ival = ival - ((ival >> 8) << 8);
					}
					String newLine = line.substring(0, pos) + "#" + ival;
					nCode.set(i, newLine);
					// System.out.println("Replaced " + line + " with " + newLine);
					reps++;
					if (newLine.startsWith("LDA") && nCode.get(i - 1).replace("LDY", "LDA").equals(newLine)) {
						// Move instead of Load, if it's an LDY #x LDA #x combination...
						nCode.set(i, "TYA");
					}
				}
			}
		}
		Logger.log("Inlined " + (reps >> 1) + " integer constants!");
		return nCode;
	}

	/**
	 * Removes unused constants from the code. The compiler might introduce
	 * constants to the code that aren't finally used in the end result. This method
	 * removes them.
	 * 
	 * @param input the native code
	 * @return the native code without the unused constants
	 */
	public List<String> removeUnusedConstants(List<String> input) {
		Logger.log("Removing unused constants...");
		boolean found = false;
		List<Line> consts = new ArrayList<>();
		int constStart = 0;
		for (int i = 0; i < input.size(); i++) {
			String line = input.get(i);
			if (!found) {
				if (line.startsWith("; *** CONSTANTS ***")) {
					found = true;
					constStart = i;
				}
				continue;
			}
			if (line.startsWith("CONST_")) {
				line = line.replace("\t", " ");
				line = line.split(" ")[0].trim();
				consts.add(new Line(line, i));
			}
		}

		if (!found) {
			return input;
		}

		Logger.log("Number of constants: " + consts.size());

		List<String> codePart = input.subList(0, constStart);
		List<Line> notUsed = new ArrayList<>();

		for (Line consty : consts) {
			boolean used = false;
			for (String line : codePart) {
				if (line.endsWith(consty.txt) || line.endsWith(consty.txt + ",X")) {
					used = true;
					break;
				}
			}
			if (!used) {
				notUsed.add(consty);
				continue;
			}
		}

		Logger.log("Number of unused constants: " + notUsed.size());
		// notUsed.forEach(p -> System.out.println(p.txt));

		for (Line consty : notUsed) {
			int pos = consty.position;
			boolean clear = true;
			for (int i = pos - 1; i >= 0; i--) {
				String cl = input.get(i);
				if (!cl.trim().isEmpty() && !cl.startsWith(";") && !cl.contains(".")) {
					// Actually, this should never happen because of the way in
					// which this algorithm works and how the constant list has
					// been created...but it does happen anyway...;-)
					Logger.log("Blocking entry: " + cl);
					clear = false;
				}
				if (cl.startsWith(";")) {
					break;
				}
			}
			if (clear) {
				input.set(pos, "");
				// Logger.log("Removed unused constant: " + consty.txt + "@" + consty.position);
				if (input.get(pos-1).contains(": $")) {
					// We've remove a String constants...that requires the next line to be removed as well
					input.set(pos+1, "");
				}
			}
		}

		return input;
	}

	/**
	 * Compacts the code.
	 * 
	 * @param conf  the compiler configuration
	 * @param input the input code
	 * @return the compacted code
	 */
	public List<String> compact(CompilerConfig conf, List<String> input) {
		Logger.log("Compacting code...");
		ProgressListener pl = null;
		if (conf != null) {
			pl = conf.getProgressListener();
		}
		if (pl != null) {
			pl.start();
		}
		strip(conf, input);

		// for (String line : input) { System.out.println(line); }

		int insertAt = 0;
		int startLine = 0;
		String lookOutFor = "SUBROUTINES END";
		String startText = null;
		if (conf.isBigRam()) {
			startText = lookOutFor;
			lookOutFor = "*** CONSTANTS ***";
		}

		for (int i = 0; i < input.size() && insertAt == 0; i++) {
			if (startText != null && input.get(i).contains(startText)) {
				startLine = i;
			}
			if (input.get(i).contains(lookOutFor)) {
				insertAt = i;
				input.add(i + 1, ";##END_COMPACT");
			}
		}

		if (startLine != 0) {
			insertAt = startLine;
		}

		int oldSize = input.size();
		updateLineMap(input);

		List<List<Line>> finds = new ArrayList<>();
		Set<Integer> replaced = new HashSet<>();

		Comparator<String> lineComp = new Comparator<String>() {
			@Override
			public int compare(String o1, String o2) {
				return o2.length() - o1.length();
			}
		};

		for (int i = startLine; i < input.size(); i++) {
			if (pl != null && i % 300 == 0) {
				// Advance the progress listener...
				pl.nextStep();
			}
			String line = input.get(i).trim();
			if (line.startsWith(";##END_COMPACT")) {
				break;
			}
			if (line.startsWith(";")) {
				continue;
			}
			List<Line> matchings = lines.get(line.hashCode());
			if (matchings == null) {
				continue;
			}
			Set<List<Line>> addedTo = new HashSet<>();
			for (Line match : matchings) {
				if (match.txt.equals(line)) {
					for (List<Line> current : finds) {
						if (addedTo.contains(current)) {
							continue;
						}
						Line lp = current.get(current.size() - 1);
						if (lp.position == match.position - 1) {
							current.add(match);
							addedTo.add(current);
							break;
						}
					}

					List<Line> start = new ArrayList<>();
					start.add(match);
					finds.add(start);
					addedTo.add(start);
				}
			}

			List<List<Line>> toRemove = new ArrayList<>(finds);
			toRemove.removeAll(addedTo);

			Map<String, List<List<Line>>> removers = new HashMap<>();
			for (List<Line> rem : toRemove) {
				StringBuilder sb = new StringBuilder();
				for (Line rl : rem) {
					sb.append(rl.txt);
				}
				List<List<Line>> subs = removers.get(sb.toString());
				if (subs == null) {
					subs = new ArrayList<>();
					removers.put(sb.toString(), subs);
				}
				subs.add(rem);
			}

			List<String> keys = new ArrayList<String>(removers.keySet());
			Collections.sort(keys, lineComp);

			for (String remover : keys) {
				List<List<Line>> rems = removers.get(remover);
				if (rems != null && rems.size() > 1 && rems.get(0).size() > threshold) {
					String label = "COMPACT" + (extCount++);
					boolean reallyFirst = true;
					for (List<Line> toReps : rems) {
						boolean first = true;
						boolean alreadyProcs = false;
						for (Line toRep : toReps) {
							int pos = toRep.position;
							if (replaced.contains(pos)) {
								alreadyProcs = true;
								break;
							}
						}

						if (!alreadyProcs) {
							for (Line toRep : toReps) {
								int pos = toRep.position;
								if (first) {
									input.set(pos, "JSR " + label);
									if (reallyFirst) {
										input.add(insertAt++, label);
										String lastLine = null;
										for (Line rr : toReps) {
											lastLine = rr.txt;
											input.add(insertAt++, lastLine);
										}
										if (lastLine != null && lastLine.startsWith("JSR")) {
											input.set(insertAt - 1, "JMP" + lastLine.substring(3));
										} else {
											input.add(insertAt++, "RTS");
										}
										input.add(insertAt++, ";##################################################");
										reallyFirst = false;
									}
									first = false;
									replaced.add(pos);
								} else {
									input.set(pos, "NOP");
									replaced.add(pos);
								}
							}
						}
					}
					/*
					 * if (extCount>13 && extCount<18) { System.out.println( "TRÖT: "+(extCount-1)+
					 * "---------------------------------------------------"); int h=0; for (String
					 * l:input) { System.out.println(l+ "    @"+(h++)); } System.out.println(
					 * "---------------------------------------------------"); }
					 */
				}
			}
			updateLineMap(input);

			if (toRemove.size() > 0) {
				finds.removeAll(toRemove);
			}
		}

		strip(conf, input);
		if (pl != null) {
			pl.done();
		}
		Logger.log("Compactor executed with results:");
		Logger.log("Old size: " + oldSize);
		Logger.log("New size: " + input.size());
		return input;
	}

	private void strip(CompilerConfig conf, List<String> input) {

		String lookOutFor = "SUBROUTINES END";
		if (conf.isBigRam()) {
			lookOutFor = "*** CONSTANTS ***";
		}

		for (Iterator<String> itty = input.iterator(); itty.hasNext();) {
			String val = itty.next().trim();
			if (val.contains(lookOutFor)) {
				return;
			}
			if (val.isEmpty() || val.equals("NOP")
					|| (val.startsWith(";") && !val.contains("##") && !val.contains(lookOutFor))) {
				itty.remove();
			}
		}
	}

	private void updateLineMap(List<String> input) {
		lines.clear();
		int cnt = 0;
		int skip = 0;
		for (String line : input) {
			line = line.trim();
			if (line.contains("##END_COMPACT")) {
				return;
			}
			if (line.startsWith("RTS") || line.contains("##") || line.startsWith("NOP") || (skip-- > 0)
					|| line.contains("$FFFF") || line.startsWith("JSR COMPACT") || line.contains("JMP")
					|| line.contains("JSR NEXT")) {
				cnt++;
				continue;
			}
			if (line.contains("MOVBSELF") && line.startsWith("ST")) {
				// Self modifying code...don't compact it, until it's over...
				int p1 = line.indexOf(" ");
				int p2 = line.indexOf("+");
				if (p1 != -1 && p2 != -1) {
					String lab = line.substring(p1, p2).trim();
					for (int lc = cnt; lc < input.size(); lc++) {
						String subl = input.get(lc);
						if (subl.startsWith(lab + ":")) {
							cnt++;
							skip = lc + 2 - cnt;
							break;
						}
					}
					continue;
				}
			}
			int hc = line.hashCode();
			List<Line> hcs = lines.get(hc);
			if (hcs == null) {
				hcs = new ArrayList<>();
			}
			hcs.add(new Line(line, cnt));
			cnt++;
			lines.put(hc, hcs);
		}
	}

	private static class Line {
		public Line(String txt, int position) {
			this.txt = txt;
			this.position = position;
		}

		public String txt;
		public int position;
	}
}
