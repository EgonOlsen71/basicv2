package com.sixtyfour.parser.optimize;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.PCode;
import com.sixtyfour.elements.commands.Command;
import com.sixtyfour.elements.commands.If;
import com.sixtyfour.elements.commands.Jump;
import com.sixtyfour.elements.commands.Let;
import com.sixtyfour.elements.commands.Rem;
import com.sixtyfour.parser.Line;

/**
 * Optimizes assignments by putting them in one line if possible: While this doesn't help
 * with anything on an abstract level, it enables the native optimizer to aggregate assignments
 * later on, which saves memory and is faster. By default, this is disabled for now as I don't 
 * fully trust it.
 * 
 * @author EgonOlsen
 *
 */
public class AssignmentOptimizer {

	/**
	 * Optimizes assignments
	 * 
	 * @param code
	 * @return
	 */
	public static PCode optimizeAssignments(PCode code) {
		Set<Integer> used = getJumpTargets(code);
		Map<Integer, Line> lineMap = code.getLines();
		Line first = null;
		int cnt=0;
		Logger.log("Optimizing assignments...");
		for (Integer num:code.getLineNumbers()) {
			Line line = lineMap.get(num);
			List<Command> coms = line.getCommands();
			List<Command> newComs = new ArrayList<>(coms);
			for (Command com : coms) {
				if (first != null && used.contains(num)) {
					first = null;
				}
				if (com instanceof Rem) {
					break;
				}
				if (com instanceof If) {
					first = null;
					break;
				}
				if (com instanceof Let) {
					if (first == null) {
						first = line;
						continue;
					} 
					if (first == line) {
						continue;
					}
					newComs.remove(com);
					first.addCommand(com);
					cnt++;
				} else {
					first = null;
					continue;
				}
			}
			if (newComs.size()==0) {
				newComs.add(new Rem());
			}
			line.getCommands().clear();
			line.getCommands().addAll(newComs);
		}
		Logger.log(cnt+" assignments optimized!");
		return code;
	}

	private static Set<Integer> getJumpTargets(PCode code) {
		Set<Integer> used = new HashSet<>();
		Map<Integer, Line> lineMap = code.getLines();
		for (Integer num:code.getLineNumbers()) {
			Line line = lineMap.get(num);
			List<Command> coms = line.getCommands();
			for (Command com : coms) {
				if (com instanceof Jump) {
					Jump jump = (Jump) com;
					used.addAll(jump.getTargetLineNumbers());
				} 
			}
		}
		return used;
	}
}
