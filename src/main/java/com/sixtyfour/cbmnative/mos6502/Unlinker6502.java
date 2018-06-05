package com.sixtyfour.cbmnative.mos6502;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.Unlinker;

/**
 * @author EgonOlsen
 * 
 */
public class Unlinker6502 implements Unlinker {

	@Override
	public List<String> unlink(List<String> res) {

		// mnems.add("; *** CODE ***");
		Logger.log("Unlinking unused runtime code...");

		List<String> ret = new ArrayList<String>();
		int posy = res.lastIndexOf("; *** SUBROUTINES ***");
		int posyEnd = res.lastIndexOf("; *** SUBROUTINES END ***");

		List<String> endRet = res.subList(posyEnd, res.size());
		res = res.subList(0, posyEnd);

		ret.addAll(res.subList(0, posy + 1));

		// Find all jumps in the generated code
		Set<String> codeJumps = findJumps(ret);
		List<String> subs = res.subList(posy + 1, res.size());

		// Find all jumps in code blocks of the runtime routines that are
		// referenced from the generated code

		int codeLength = 0;
		do {
			codeLength = codeJumps.size();
			int cnt = 0;
			for (String line : subs) {
				line = findLabel(line);
				if (codeJumps.contains(line)) {
					int start = find(subs, cnt, -1);
					int end = find(subs, cnt, 1);
					if (start == -1 || end == -1) {
						throw new RuntimeException("Failed to find block delimiter @ " + cnt + "/" + subs.get(cnt));
					}
					List<String> subSubs = subs.subList(start, end + 1);
					codeJumps.addAll(findJumps(subSubs));
				}
				cnt++;
			}
		} while (codeJumps.size() > codeLength);

		// remove unused blocks from the runtime code
		for (int i = 0; i < subs.size(); i++) {
			String line = subs.get(i);
			if (line.startsWith(";")) {
				continue;
			}
			int start = find(subs, i, -1);
			int end = find(subs, i, 1);
			List<String> subSubs = subs.subList(start, end + 1);

			/*
			 * System.out.println("----------------------------------------");
			 * System.out.println("found: "); for (String ss:subSubs) {
			 * System.out.println(ss); }
			 */

			boolean used = false;
			for (String subLine : subSubs) {
				subLine = findLabel(subLine);
				if (codeJumps.contains(subLine) || subLine.startsWith("INITS") || subLine.startsWith("INITN")) {
					used = true;
					break;
				}
			}
			if (used) {
				ret.addAll(subSubs);
			} /*
			 * else { System.out.println("Block from " + subSubs.get(1) +
			 * " not used, removing it!"); }
			 */
			i = end;
		}

		ret.addAll(endRet);
		return ret;
	}

	private String findLabel(String line) {
		line = line.trim().toUpperCase(Locale.ENGLISH);
		line = line.replace("\t", " ");
		int pos = line.indexOf(" ");
		if (pos != -1) {
			line = line.substring(0, pos);
		}
		return line;
	}

	private int find(List<String> subs, int cnt, int dir) {
		for (int i = cnt; i >= 0 && i < subs.size(); i += dir) {
			if (subs.get(i).startsWith(";###")) {
				return i;
			}
		}
		return -1;
	}

	private Set<String> findJumps(List<String> ret) {
		String[] jumps = new String[] { "JMP", "JSR", "BNE", "BEQ", "BMI", "BCC", "BCS" };

		Set<String> labels = new HashSet<String>();
		for (String line : ret) {
			line = line.replace("\t", " ");
			for (String jmp : jumps) {
				jmp += " ";
				if (line.toUpperCase(Locale.ENGLISH).contains(jmp)) {
					int pos = line.indexOf(jmp);
					String end = line.substring(pos + 4);
					pos = end.indexOf(";");
					if (pos != -1) {
						end = end.substring(0, pos);
					}
					end = end.trim();
					labels.add(end);
					break;
				}
			}
		}
		return labels;
	}

}
