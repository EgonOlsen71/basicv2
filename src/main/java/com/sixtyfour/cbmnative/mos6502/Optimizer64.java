package com.sixtyfour.cbmnative.mos6502;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.Optimizer;
import com.sixtyfour.cbmnative.Pattern;
import com.sixtyfour.cbmnative.PlatformProvider;

/**
 * @author EgonOlsen
 * 
 */
public class Optimizer64 implements Optimizer {
	private List<Pattern> patterns = new ArrayList<Pattern>() {
		private static final long serialVersionUID = 1L;
		{
			this.add(new Pattern("REALOUT + LINEBRK", new String[] { "JSR REALOUTBRK" }, "JSR REALOUT", "JSR LINEBREAK"));
			this.add(new Pattern("STROUT + LINEBRK", new String[] { "JSR STROUTBRK" }, "JSR STROUT", "JSR LINEBREAK"));
			this.add(new Pattern("Quick copy into REG", new String[] { "{LINE0}", "{LINE1}", "STA TMP3_ZP", "STY TMP3_ZP+1", "{LINE3}", "{LINE4}", "JSR COPY2_XY" },
					"LDA #<{MEM0}", "LDY #>{MEM0}", "JSR $BBA2", "LDX #<{REG0}", "LDY #>{REG0}", "JSR $BBD7"));
			this.add(new Pattern("Simplified CMP with 0", new String[] { "{LINE0}", "LDA $61" }, "JSR $BBA2", "LDX #<{REG0}", "LDY #>{REG0}", "JSR $BBD7", "LDA #<{#0.0}",
					"LDY #>{#0.0}", "JSR $BBA2", "LDA #<{REG0}", "LDY #>{REG0}", "JSR $BC5B"));
			this.add(new Pattern("REG0->REG1, REG1->REG0", new String[] { "{LINE0}", "{LINE1}", "{LINE2}" }, "LDX #<{MEM0}", "LDY #>{MEM0}", "JSR $BBD7", "LDA #<{REG0}",
					"LDY #>{REG0}", "JSR $BBA2", "LDX #<{REG1}", "LDY #>{REG1}", "JSR $BBD7", "LDA #<{REG1}", "LDY #>{REG1}", "JSR $BBA2", "LDX #<{REG0}", "LDY #>{REG0}",
					"JSR $BBD7", "LDA #<{REG0}", "LDY #>{REG0}", "JSR $BBA2"));
			this.add(new Pattern("REG0->VAR, REG0->REG1", new String[] { "{LINE6}", "{LINE7}", "{LINE8}" }, "LDX #<{REG0}", "LDY #>{REG0}", "JSR $BBD7", "LDA #<{REG0}",
					"LDY #>{REG0}", "JSR $BBA2", "LDX #<{MEM0}", "LDY #>{MEM0}", "JSR $BBD7", "LDA #<{REG0}", "LDY #>{REG0}", "JSR $BBA2", "LDX #<{REG1}", "LDY #>{REG1}",
					"JSR $BBD7", "LDA #<{REG1}", "LDY #>{REG1}", "JSR $BBA2"));
			this.add(new Pattern("FAC into REG?, REG? into FAC", null, "LDX #<{REG0}", "LDY #>{REG0}", "JSR $BBD7", "LDA #<{REG0}", "LDY #>{REG0}", "JSR $BBA2"));
			this.add(new Pattern("INT to FAC, FAC to INT", new String[] { "{LINE0}", "{LINE1}" }, "LDY {*}", "LDA {*}", "JSR $B391", "JSR $B1AA"));
			this.add(new Pattern("STY A...LDY A...STY B", new String[] { "{LINE0}", "{LINE3}" }, "STY {MEM0}", "LDY {MEM0}", "LDA #0", "STY {*}"));
			this.add(new Pattern("FAC to INT, INT to FAC", null, "JSR $B391", "JSR $B1AA"));
			this.add(new Pattern("VAR into FAC, FAC into VAR", null, "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR $BBA2", "LDX #<{MEM0}", "LDY #>{MEM0}", "JSR $BBD7"));
			this.add(new Pattern("CMP with 0", new String[] { "LDA {REG0}" }, "LDA #<{#0.0}", "LDY #>{#0.0}", "JSR $BBA2", "LDA #<{REG0}", "LDY #>{REG0}", "JSR $BC5B"));
			this.add(new Pattern("POKE with integer constant@real location",
					new String[] { "JSR $BBA2", "JSR $B7F7", "STY 105", "STA 106", "LDA {MEM0}", "LDY #0", "STA (105),Y" }, "JSR $BBA2", "JSR PUSHREAL", "LDY {MEM0}",
					"LDA {MEM0}", "JSR $B391", "LDX #<{REG0}", "LDY #>{REG0}", "JSR $BBD7", "JSR POPREAL", "JSR $B7F7", "STY 105", "STA 106", "LDA #<{REG0}", "LDY #>{REG0}",
					"JSR $BBA2", "JSR $B7F7", "TYA", "LDY #0", "STA (105),Y"));
			this.add(new Pattern("NEXT check simplified", new String[] { "JSR NEXT", "LDA A_REG", "{LINE8}", "JMP (JUMP_TARGET)" }, "JSR NEXT", "LDY {MEM0}", "LDA {MEM0}",
					"CPY A_REG", "BNE {*}", "CMP A_REG+1", "BNE {*}", "{LABEL}", "BNE {*}", "JMP (JUMP_TARGET)"));
			this.add(new Pattern("Multiple loads of the same value(1)", new String[] { "{LINE0}", "{LINE1}", "{LINE2}", "{LINE3}", "{LINE4}", "{LINE5}", "{LINE9}", "{LINE10}",
					"{LINE11}" }, "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR $BBA2", "LDX #<{REG0}", "LDY #>{REG0}", "JSR $BBD7", "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR $BBA2",
					"LDX #<{REG1}", "LDY #>{REG1}", "JSR $BBD7"));
			this.add(new Pattern("Multiple loads of the same value(2)", new String[] { "{LINE0}", "{LINE1}", "{LINE2}", "{LINE3}", "{LINE4}", "{LINE5}", "{LINE6}", "{LINE11}",
					"{LINE12}", "{LINE13}" }, "LDA #<{MEM0}", "LDY #>{MEM0}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG0}", "LDY #>{REG0}", "JSR COPY2_XY", "LDA #<{MEM0}",
					"LDY #>{MEM0}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG1}", "LDY #>{REG1}", "JSR COPY2_XY"));
			this.add(new Pattern("Value already in X", new String[] { "{LINE0}", "{LINE1}", "{LINE2}", "TXA", "{LINE4}" }, "LDX #<{REG0}", "LDY #>{REG0}", "JSR COPY2_XY",
					"LDA #<{REG0}", "LDY #>{REG0}"));
			this.add(new Pattern("Variable used twice in calculation", new String[] { "{LINE3}", "{LINE4}", "{LINE5}", "TXA", "{LINE10}", "{LINE8}", "{LINE9}", "{LINE10}",
					"{LINE11}", "{LINE12}" }, "LDX #<{REG0}", "LDY #>{REG0}", "JSR COPY2_XY", "LDX #<{REG1}", "LDY #>{REG1}", "JSR COPY2_XY", "LDA #<{REG0}", "LDY #>{REG0}",
					"JSR $BBA2", "LDA #<{REG1}", "LDY #>{REG1}", "JSR $BA8C", "JSR {*}"));
			this.add(new Pattern("Avoid INTEGER->REAL conversion", true, new String[] { "LDA #<{CONST0}R", "LDY #>{CONST0}R", "JSR $BBA2" }, "LDY {CONST0}", "LDA {CONST0}",
					"JSR $B391"));
			this.add(new Pattern("Array value used twice in calculation", new String[] { "{LINE0}", "{LINE1}", "{LINE2}", "{LINE3}", "{LINE4}", "{LINE5}", "{LINE6}", "{LINE7}",
					"{LINE8}", "{LINE9}", "{LINE10}", "{LINE11}", "{LINE12}", "{LINE13}", "{LINE14}", "{LINE12}", "{LINE13}", "JSR $BA8C" }, "LDA #<{MEM0}", "LDY #>{MEM0}",
					"STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG0}", "LDY #>{REG0}", "JSR COPY2_XY", "LDA #<{MEM1}", "LDY #>{MEM1}", "STA {REG1}", "STY {REG1}", "JSR {*}",
					"LDA #<{REG0}", "LDY #>{REG0}", "JSR $BBA2", "JSR PUSHREAL", "LDA #<{MEM0}", "LDY #>{MEM0}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG0}", "LDY #>{REG0}",
					"JSR COPY2_XY", "LDA #<{MEM1}", "LDY #>{MEM1}", "STA {REG1}", "STY {REG1}", "JSR {*}", "JSR POPREAL", "LDA #<{REG0}", "LDY #>{REG0}", "JSR $BA8C"));
			this.add(new Pattern("Constant directly into FAC", new String[] { "LDA #0", "STA $61", "STA $62", "STA $63", "STA $64", "STA $65", "STA $66", "{LINE2}", "{LINE3}",
					"LDA #0", "STA $63", "STA $64", "STA $65", "LDY #128", "STY $62", "INY", "STY $61", "LDY #$FF", "STY $66", "{LINE6}", "{LINE8}" }, "LDA #<REAL_CONST_ZERO",
					"LDY #>REAL_CONST_ZERO", "JMP {*}", "{LABEL}", "LDA #<REAL_CONST_MINUS_ONE", "LDY #>REAL_CONST_MINUS_ONE", "{LABEL}", "JSR $BBA2", "LDA $61"));
			this.add(new Pattern("Highly simplified loading for CMP", new String[] { "{LINE0}", "{LINE1}", "JSR $BBA2", "{LINE7}", "{LINE8}", "{LINE19}" }, "LDA #<{MEM0}",
					"LDY #>{MEM0}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG0}", "LDY #>{REG0}", "JSR COPY2_XY", "LDA #<{MEM1}", "LDY #>{MEM1}", "STA TMP3_ZP", "STY TMP3_ZP+1",
					"LDX #<{REG1}", "LDY #>{REG1}", "JSR COPY2_XY", "LDA #<{REG0}", "LDY #>{REG0}", "JSR $BBA2", "LDA #<{REG1}", "LDY #>{REG1}", "JSR $BC5B"));
			this.add(new Pattern("Highly simplified loading for calculations", new String[] { "{LINE0}", "{LINE1}", "JSR $BBA2", "{LINE7}", "{LINE8}", "{LINE19}", "{LINE20}" },
					"LDA #<{MEM0}", "LDY #>{MEM0}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG0}", "LDY #>{REG0}", "JSR COPY2_XY", "LDA #<{MEM1}", "LDY #>{MEM1}", "STA TMP3_ZP",
					"STY TMP3_ZP+1", "LDX #<{REG1}", "LDY #>{REG1}", "JSR COPY2_XY", "LDA #<{REG0}", "LDY #>{REG0}", "JSR $BBA2", "LDA #<{REG1}", "LDY #>{REG1}", "JSR $BA8C",
					"JSR {*}"));
			this.add(new Pattern("NEXT with no variable name simplified", new String[] { "LDA #0", "STA A_REG", "STA A_REG+1", "JSR NEXT" }, "LDY {CONST0}", "LDA {CONST0}",
					"STY A_REG", "STA A_REG+1", "JSR NEXT"));
			this.add(new Pattern("POKE and NEXT combined", new String[] { "LDY #0", "STA (105),Y", "STY A_REG", "STY A_REG+1" }, "LDY #0", "STA (105),Y", "LDA #0", "STA A_REG",
					"STA A_REG+1"));
			this.add(new Pattern("Improved copy from REG0 to REG1", new String[] { "{LINE0}", "{LINE1}", "STA TMP3_ZP", "STY TMP3_ZP+1", "{LINE3}", "{LINE4}", "JSR COPY2_XY" },
					"LDA #<{REG0}", "LDY #>{REG0}", "JSR $BBA2", "LDX #<{REG1}", "LDY #>{REG1}", "JSR $BBD7"));
			this.add(new Pattern("FAST SQRT", new String[] { "JSR SQRT" }, "JSR $BF71"));
			this.add(new Pattern("Simplified loading of Strings", new String[] { "{LINE4}", "{LINE5}", "{LINE6}", "{LINE7}", "{LINE8}" }, "STA {REG0}", "STY {REG0}", "LDA {REG0}",
					"LDY {REG0}", "STA TMP_ZP", "STY TMP_ZP+1", "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR COPYSTRING"));
		}
	};

	@Override
	public List<String> optimize(PlatformProvider platform, List<String> input) {
		// if (true) return input;
		long s = System.currentTimeMillis();
		Map<String, Integer> type2count = new HashMap<>();
		Map<String, Number> const2Value = new HashMap<>();
		for (String line : input) {
			line = line.replace("\t", " ");
			if (line.startsWith("CONST_")) {
				int pos = line.indexOf(" ");
				if (pos != -1) {
					String name = line.substring(0, pos).trim();
					String right = line.substring(pos + 1).trim();
					pos = right.indexOf(" ");
					if (pos != -1) {
						String type = right.substring(0, pos).trim();
						String number = right.substring(pos + 1).trim();
						if (type.equals(".REAL") || type.equals(".WORD")) {
							try {
								Float num = Float.valueOf(number);
								if (type.equals(".REAL")) {
									const2Value.put(name, num);
								} else {
									const2Value.put(name, num.intValue());
								}
							} catch (Exception e) {
								Logger.log("Failed to parse " + number + " as a number!");
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
				if (pattern.isLooseTypes() && !platform.useLooseTypes()) {
					continue;
				}
				for (int i = 0; i < input.size(); i++) {
					String line = input.get(i);
					if (line.startsWith("; *** SUBROUTINES ***")) {
						break;
					}
					boolean matches = pattern.matches(line, i, const2Value);
					if (matches) {
						String name = pattern.getName();
						Integer cnt = type2count.get(name);
						if (cnt == null) {
							type2count.put(name, 1);
						} else {
							type2count.put(name, cnt + 1);
						}
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

		for (Map.Entry<String, Integer> cnts : type2count.entrySet()) {
			Logger.log("Optimization " + cnts.getKey() + " applied " + cnts.getValue() + " times!");
		}
		Logger.log("Assembly code optimized in " + (System.currentTimeMillis() - s) + "ms");

		return applySpecialRules(input);
	}

	private List<String> applySpecialRules(List<String> input) {
		return simplifyBranches(input);
	}

	private List<String> simplifyBranches(List<String> input) {
		List<String> ret = new ArrayList<String>();
		for (int i = 0; i < input.size() - 1; i++) {
			String line = input.get(i);
			line = line.replace("\t", " ").trim();
			String line2 = input.get(i + 1);
			line2 = line2.replace("\t", " ").trim();
			if (line.startsWith("; *** SUBROUTINES ***")) {
				ret.addAll(input.subList(i, input.size()));
				break;
			}
			boolean skip = false;
			if (line.contains("BNE LINE_NSKIP") && line2.contains("JMP LINE_SKIP")) {
				for (int p = i + 1; p < Math.min(input.size(), i + 30); p++) {
					String subLine = input.get(p);
					if (subLine.startsWith("LINE_SKIP")) {
						ret.add(line2.replace("JMP LINE_SKIP", "BEQ LINE_SKIP"));
						ret.add("; Simplified conditional branch");
						skip = true;
						i++;
						break;
					}
				}
			}
			if (skip) {
				continue;
			}
			ret.add(line);
		}
		return ret;
	}
}
