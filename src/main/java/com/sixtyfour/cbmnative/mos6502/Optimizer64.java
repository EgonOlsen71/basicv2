package com.sixtyfour.cbmnative.mos6502;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sixtyfour.Logger;
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
			this.add(new Pattern("CMP with 0", new String[]{"LDA {REG0}"}, "LDA #<{#0.0}", "LDY #>{#0.0}", "JSR $BBA2", "LDA #<{REG0}", "LDY #>{REG0}", "JSR $BC5B"));
		}
	};

	@Override
	public List<String> optimize(List<String> input) {
		// if (true) return input;

	    	Map<String, Number> const2Value=new HashMap<>();
	    	for (String line:input) {
	    	    line=line.replace("\t", " ");
	    	    if (line.startsWith("CONST_")) {
	    		int pos=line.indexOf(" ");
	    		if (pos!=-1) {
	    		    String name=line.substring(0, pos).trim();
	    		    String right=line.substring(pos+1).trim();
	    		    pos=right.indexOf(" ");
	    		    if (pos!=-1) {
        	    		    String type=right.substring(0, pos).trim();
        	    		    String number=right.substring(pos+1).trim();
        	    		    if (type.equals(".REAL") || type.equals(".WORD")) {
        	    			try {
        	    			    Float num=Float.valueOf(number);
        	    			    if (type.equals(".REAL")) {
        	    				const2Value.put(name, num);
        	    			    } else {
        	    				const2Value.put(name, num.intValue());
        	    			    }
        	    			} catch(Exception e) {
        	    			    Logger.log("Failed to parse "+number+" as a number!");
        	    			}
        	    		    }
	    		    }
	    		}
	    	    }
	    	}
	    
		boolean optimized = false;
		do {
			optimized = false;
			for (Pattern pattern : patterns) {
				for (int i = 0; i < input.size(); i++) {
					String line = input.get(i);
					if (line.startsWith("; *** SUBROUTINES ***")) {
						break;
					}
					boolean matches = pattern.matches(line, i, const2Value);
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
