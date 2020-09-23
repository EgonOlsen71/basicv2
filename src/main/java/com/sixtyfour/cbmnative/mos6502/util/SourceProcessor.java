package com.sixtyfour.cbmnative.mos6502.util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import com.sixtyfour.Logger;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.parser.assembly.AssemblyParser;
import com.sixtyfour.parser.assembly.ConstantValue;
import com.sixtyfour.parser.assembly.ConstantsContainer;
import com.sixtyfour.parser.assembly.LabelsContainer;
import com.sixtyfour.system.Machine;

/**
 * @author EgonOlsen
 *
 */
public class SourceProcessor {

	private List<String> src;

	public SourceProcessor(List<String> src) {
		this.src = src;
	}

	public List<SourcePart> split() {
		List<SourcePart> parts = new ArrayList<>();

		int start = 0;
		int cur = 0;
		boolean skipMode = false;

		for (String line : src) {
			line = AssemblyParser.truncateComments(line);
			line = AssemblyParser.replaceTabs(line);
			cur++;
			line = line.trim().toLowerCase(Locale.ENGLISH);
			if (line.startsWith("line_")) {
				skipMode = false;
				int end = line.length();
				int pos = line.replace(':', ' ').indexOf(" ");
				if (pos != -1) {
					end = pos;
				}
				line = line.substring(5, end).trim();
				try {
					Integer.parseInt(line);
					SourcePart part = new SourcePart(start, cur - 1, src);
					start = cur - 1;
					part.setCompiledCode(true);
					parts.add(part);
				} catch (Exception e) {
					//
				}
			} else {
				if (line.startsWith(";####")) {
					if (!skipMode) {
						SourcePart part = new SourcePart(start, cur, src);
						start = cur;
						parts.add(part);
						skipMode = true;
					}
				} else {
					skipMode = false;
					if (line.startsWith("*=")) {
						SourcePart part = new SourcePart(start, cur - 1, src);
						start = cur - 1;
						parts.add(part);
					}
				}
			}
		}
		if (start < cur) {
			SourcePart part = new SourcePart(start, cur, src);
			parts.add(part);
		}

		return parts;
	}

	public List<String> relocate(CompilerConfig config, List<SourcePart> parts, List<MemoryHole> holes) {
		int os = holes != null ? holes.size() : 0;
		if (os == 0) {
			return src;
		}
		holes = optimizeHoles(holes);

		if (os != holes.size()) {
			Logger.log("Optimized memory holes/locks:");
			holes.forEach(p -> Logger.log(p.toString()));
		}

		Machine machine = new Machine();
		ConstantsContainer ccon = new ConstantsContainer();
		LabelsContainer lcon = new LabelsContainer(machine);
		List<String> res = new ArrayList<>();
		Iterator<MemoryHole> holy = holes.iterator();
		MemoryHole hole = holy.next();
		int addr = -1;
		int skippies = 0;

		for (SourcePart part : parts) {
			int size = part.calculateCodeSize(config, ccon, lcon);
			if (hole != null && addr >= 0 && addr + 3 + size >= hole.getStartAddress()) {
				// The new part doesn't fit anymore, skip the hole...
				addr = hole.getEndAddress() + 1;
				String haddr = "$" + Integer.toHexString(addr);
				res.add(";+++++ SKIP TO " + haddr);
				if (part.isCompiledCode()) {
					// This might not be needed, but we don't know this here for sure, so we add it just in case...
					res.add("JMP RELOCMEM" + skippies);
				}
				Logger.log("Relocating code to " + haddr);
				res.add("*=" + haddr);
				res.add("RELOCMEM" + (skippies++) + ":");
				if (holy.hasNext()) {
					hole = holy.next();
				} else {
					hole = null;
				}
			}
			
			for (String line : part.getSourcePart()) {
				res.add(line);
				if (!line.startsWith("*=")) {
					continue;
				}
				ConstantValue cv = AssemblyParser.getConstant(config, line, ccon);
				if (cv != null) {
					if (cv.getName().equals("*")) {
						addr = cv.getValue();
					}
				}
			}
			addr+=size;
		}

		return res;
	}

	public String toString(CompilerConfig config, ConstantsContainer ccon, LabelsContainer lcon) {
		List<SourcePart> parts = split();
		StringBuilder sb = new StringBuilder();
		int cnt = 0;
		for (SourcePart part : parts) {
			int len = part.calculateCodeSize(config, ccon, lcon);
			sb.append(";+++++++++ PART " + cnt + " - START / " + len + " BYTES\n");
			for (String line : part.getSourcePart()) {
				sb.append(line).append("\n");
			}
			sb.append(";+++++++++ PART " + cnt + " - END / " + len + " BYTES\n");
			cnt++;
		}
		return sb.toString();
	}

	private List<MemoryHole> optimizeHoles(List<MemoryHole> holes) {
		int os = 0;
		do {
			os = holes.size();
			holes = optimizeHolesInternal(holes);
		} while (os > holes.size());
		return holes;
	}

	private List<MemoryHole> optimizeHolesInternal(List<MemoryHole> holes) {
		if (holes.size() < 2) {
			return holes;
		}

		Collections.sort(holes, new Comparator<MemoryHole>() {
			@Override
			public int compare(MemoryHole m0, MemoryHole m1) {
				int d = m0.getStartAddress() - m1.getStartAddress();
				if (d == 0) {
					d = m0.getEndAddress() - m1.getEndAddress();
				}
				return d;
			}
		});

		List<MemoryHole> res = new ArrayList<>();
		for (int i = 0; i < holes.size(); i += 2) {
			MemoryHole hole = holes.get(i);
			MemoryHole nextHole = hole;

			if (i < holes.size() - 1) {
				nextHole = holes.get(i + 1);
			}

			int sh = hole.getStartAddress();
			int eh = hole.getEndAddress();
			int snh = nextHole.getStartAddress();
			int enh = nextHole.getEndAddress();

			if (snh > eh) {
				res.add(hole);
				res.add(nextHole);
				continue;
			}

			if (enh < eh) {
				hole = new MemoryHole(sh, eh);
				res.add(hole);
				continue;
			}

			hole = new MemoryHole(sh, enh);
			res.add(hole);
		}

		return res;
	}

}
