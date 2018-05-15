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

public class Compactor {

	private int threshold = 4;
	private int extCount = 0;
	private Map<Integer, List<Line>> lines = new HashMap<>();

	public Compactor(int threshold) {
		this.threshold = threshold;
	}

	public List<String> compact(List<String> input) {
		strip(input);

		// for (String line : input) { System.out.println(line); }

		int insertAt = 0;
		for (int i = 0; i < input.size() && insertAt == 0; i++) {
			if (input.get(i).contains("SUBROUTINES END")) {
				insertAt = i;
				input.add(insertAt++, ";##END_COMPACT");
			}
		}

		int oldSize = input.size();
		updateLineMap(input);

		List<List<Line>> finds = new ArrayList<>();
		Set<Integer> replaced = new HashSet<>();

		for (int i = 0; i < input.size(); i++) {
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
			Collections.sort(keys, new Comparator<String>() {
				@Override
				public int compare(String o1, String o2) {
					return o2.length() - o1.length();
				}
			});

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
					 * if (extCount>13 && extCount<18) {
					 * System.out.println("TRÖT: "+(extCount-1)+
					 * "---------------------------------------------------");
					 * int h=0; for (String l:input) {
					 * System.out.println(l+"    @"+(h++)); }
					 * System.out.println(
					 * "---------------------------------------------------"); }
					 */
				}
			}
			updateLineMap(input);

			if (toRemove.size() > 0) {
				finds.removeAll(toRemove);
			}
		}

		strip(input);
		System.out.println("Compactor executed with results:");
		System.out.println("Old size: " + oldSize);
		System.out.println("New size: " + input.size());
		return input;

	}

	private void strip(List<String> input) {
		for (Iterator<String> itty = input.iterator(); itty.hasNext();) {
			String val = itty.next().trim();
			if (val.contains("SUBROUTINES END")) {
				return;
			}
			if (val.isEmpty() || val.equals("NOP") || (val.startsWith(";") && !val.contains("##") && !val.contains("SUBROUTINES END"))) {
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
			if (line.startsWith("RTS") || line.contains("##") || line.startsWith("NOP") || (skip-- > 0) || line.contains("$FFFF") || line.startsWith("JSR COMPACT")
					|| line.contains("JMP") || line.contains("JSR NEXT")) {
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
