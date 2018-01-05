package com.sixtyfour.cbmnative.mos6502;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.cbmnative.Optimizer;
import com.sixtyfour.cbmnative.Pattern;

/**
 * @author EgonOlsen
 * 
 */
public class Optimizer64 implements Optimizer {
	private List<Pattern> patterns = new ArrayList<Pattern>() {
		private static final long serialVersionUID = 1L;
		{
			this.add(new Pattern("FAC into REG?, REG? into FAC", null, "LDX #<{REG0}", "LDY #>{REG0}", "JSR $BBD7", "LDA #<{REG0}", "LDY #>{REG0}", "JSR $BBA2"));
			this.add(new Pattern("INT to FAC, FAC to INT", new String[] { "{LINE0}", "{LINE1}" }, "LDY {*}", "LDA {*}", "JSR $B391", "JSR $B1AA"));
			this.add(new Pattern("STY A...LDY A...STY B", new String[] { "{LINE0}", "{LINE3}" }, "STY {MEM0}", "LDY {MEM0}", "LDA #0", "STY {*}"));
			this.add(new Pattern("FAC to INT, INT to FAC", null, "JSR $B391", "JSR $B1AA"));
			this.add(new Pattern("VAR into FAC, FAC into VAR", null, "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR $BBA2", "LDX #<{MEM0}", "LDY #>{MEM0}", "JSR $BBD7"));
		}
	};

	@Override
	public List<String> optimize(List<String> input) {
		// if (true) return input;

		boolean optimized = false;
		do {
			optimized = false;
			for (Pattern pattern : patterns) {
				for (int i = 0; i < input.size(); i++) {
					String line = input.get(i);
					if (line.startsWith("; *** SUBROUTINES ***")) {
						break;
					}
					boolean matches = pattern.matches(line, i);
					if (matches) {
						input = pattern.apply(input);
						optimized = true;
						break;
					}
				}
				if (optimized) {
					break;
				}
			}
		} while (optimized);
		return input;
	}

}
