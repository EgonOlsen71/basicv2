package com.sixtyfour.parser.optimize;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.PCode;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.Data;
import com.sixtyfour.elements.commands.End;
import com.sixtyfour.elements.commands.Goto;
import com.sixtyfour.elements.commands.If;
import com.sixtyfour.elements.commands.Jump;
import com.sixtyfour.elements.commands.New;
import com.sixtyfour.elements.commands.Return;
import com.sixtyfour.elements.commands.Run;
import com.sixtyfour.elements.commands.Stop;
import com.sixtyfour.parser.Line;

/**
 * Experimental dead code checker and remover. Seems to work fine, but is
 * disabled for now.
 * 
 * @author EgonOlsen
 *
 */
public class DeadCodeChecker {

	public static PCode removeDeadCode(PCode code) {
		Logger.log("Detecting dead code...");
		List<Integer> nums = code.getLineNumbers();
		Map<Integer, Line> lineMap = code.getLines();

		Set<Integer> used = new HashSet<>();

		if (nums.isEmpty()) {
			return code;
		}

		addDatas(lineMap, used);

		trackCode(nums, lineMap, used, 0);
		Logger.log((nums.size() - used.size() + " lines of dead code removed!"));
		for (Integer num : nums) {
			if (!used.contains(num)) {
				lineMap.remove(num);
				// Logger.log("Line " + num + " contains dead code!");
			}
		}
		nums.retainAll(used);
		return new PCode(nums, lineMap);
	}

	private static void addDatas(Map<Integer, Line> lineMap, Set<Integer> used) {
		for (Entry<Integer, Line> lineEntry : lineMap.entrySet()) {
			Line line = lineEntry.getValue();
			List<Command> coms = line.getCommands();
			for (Command com : coms) {
				if (com instanceof Data) {
					used.add(lineEntry.getKey());
					break;
				}
			}
		}
	}

	private static void trackCode(List<Integer> nums, Map<Integer, Line> lineMap, Set<Integer> used, int idx) {
		if (idx < 0) {
			throw new RuntimeException("Jump to undefined line " + idx);
		}

		Integer num = nums.get(idx);
		if (used.contains(num)) {
			return;
		}
		used.add(num);
		Line line = lineMap.get(num);
		List<Command> coms = line.getCommands();
		boolean cond = false;
		for (Command com : coms) {
			if (com instanceof If) {
				cond = true;
			}
			if (com instanceof Jump) {
				Jump jump = (Jump) com;
				List<Integer> tnums = jump.getTargetLineNumbers();
				for (Integer tnum : tnums) {
					trackCode(nums, lineMap, used, getIndex(tnum, nums));
				}
				if (com instanceof Goto && !cond) {
					return;
				}
			} else {
				if (!cond) {
					if ((com instanceof End) || (com instanceof Stop) || (com instanceof New)) {
						return;
					}
					if (com instanceof Return) {
						return;
					}
				}
				if (com instanceof Run) {
					trackCode(nums, lineMap, used, 0);
				}
			}
		}
		if (++idx < nums.size()) {
			trackCode(nums, lineMap, used, idx);
		}
	}

	private static int getIndex(Integer tnum, List<Integer> nums) {
		int idx = 0;
		for (Integer num : nums) {
			if (num.equals(tnum)) {
				return idx;
			}
			idx++;
		}
		return -1;
	}

}
