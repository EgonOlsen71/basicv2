package com.sixtyfour.cbmnative.mos6502;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.stream.Collectors;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.Optimizer;
import com.sixtyfour.cbmnative.Pattern;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.ProgressListener;
import com.sixtyfour.cbmnative.Util;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.config.RuntimeAddition;

/**
 * An optimizer implementation for the 6520 cpu. Because it might run a large
 * number of passes, it will take its time especially on larger programs.
 * 
 * @author EgonOlsen
 * 
 */
public class Optimizer6502 implements Optimizer {

	@Override
	public List<String> optimize(CompilerConfig config, PlatformProvider platform, List<String> input,
			ProgressListener pg) {
		// if (true) return input;
		Logger.log("Optimizing native assembly code...");
		long s = System.currentTimeMillis();
		trimLines(config, input);
		input = trackAndModifyRegisterUsage(input);
		input = optimizeInternal(config, platform, input, pg, config.getThreads());
		input = applySpecialRules(config, platform, input);
		input = removeNops(input);
		Logger.log("Assembly code optimized in " + (System.currentTimeMillis() - s) + "ms");
		return input;
	}

	private List<String> optimizeInternal(CompilerConfig conf, PlatformProvider platform, List<String> input,
			ProgressListener pg, int threads) {
		Map<String, Number> const2Value = extractConstants(input);
		int cpus = threads;
		if (cpus <= 0) {
			cpus = Runtime.getRuntime().availableProcessors();
		}
		int[] ps = getStartAndEnd(conf, input);
		int codeStart = ps[0];
		int codeEnd = ps[1];

		if (codeStart == 0 || codeEnd == input.size()) {
			Logger.log("WARNING: Unable to determine code start or end: " + codeStart + "/" + codeEnd + "/"
					+ input.size());
		}

		List<List<String>> parts = new ArrayList<>();
		int dif = Math.max(Math.round((codeEnd - codeStart) / cpus), 1);
		int pos = 0;
		int cnt = 0;
		int lastStart = codeStart;

		parts.add(input.subList(0, codeStart));
		for (pos = codeStart; pos < codeEnd; pos++) {
			String line = input.get(pos);
			cnt++;
			if (line.startsWith("LINE_") && line.endsWith(":")) {
				if (cnt >= dif) {
					parts.add(input.subList(lastStart, pos));
					cnt = 0;
					lastStart = pos;
				}
			}
		}
		parts.add(input.subList(lastStart, input.size()));

		ExecutorService executor = Executors.newFixedThreadPool(cpus);
		List<Future<OptimizationResult>> futures = new ArrayList<>();
		for (List<String> part : parts) {
			List<Pattern> patterns = getPatterns();
			RuntimeAddition add = conf.getRuntimeAddition();
			if (add != null && add.getAdditionalPatterns() != null) {
				patterns.addAll(add.getAdditionalPatterns());
			}
			Future<OptimizationResult> task = executor.submit(() -> {
				return optimizeInternalThreaded(conf, patterns, platform, part, pg, const2Value);
			});
			futures.add(task);
		}
		executor.shutdown();

		List<String> optCode = new ArrayList<>();
		Map<String, Integer> type2count = new HashMap<>();

		try {
			for (Future<OptimizationResult> future : futures) {
				OptimizationResult res = future.get();
				optCode.addAll(res.getCode());
				res.getType2count()
						.forEach((k, v) -> type2count.put(k, type2count.containsKey(k) ? v + type2count.get(k) : v));
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("Failed to run optimizer!", e);
		}

		if (pg != null) {
			pg.done();
		}

		printOutResults(type2count);
		return optCode;
	}

	private void printOutResults(Map<String, Integer> type2count) {
		for (Map.Entry<String, Integer> cnts : type2count.entrySet()) {
			Logger.log("Optimization " + cnts.getKey() + " applied " + cnts.getValue() + " times!");
		}
	}

	private OptimizationResult optimizeInternalThreaded(CompilerConfig conf, List<Pattern> patterns,
			PlatformProvider platform, List<String> input, ProgressListener pg, Map<String, Number> const2Val) {
		return optimizeInternalThreaded(conf, patterns, platform, input, pg, const2Val, false);
	}

	private OptimizationResult optimizeInternalThreaded(CompilerConfig conf, List<Pattern> patterns,
			PlatformProvider platform, List<String> input, ProgressListener pg, Map<String, Number> const2Val,
			boolean allLines) {
		Map<String, Integer> type2count = new HashMap<>();
		Map<String, Number> const2Value = new HashMap<>(const2Val);
		Set<Pattern> used = new HashSet<Pattern>();
		boolean optimized = false;

		int lastPattern = -1;
		int lastLine = input.size();

		int[] ps = getStartAndEnd(conf, input);
		int codeStart = ps[0];
		int codeEnd = ps[1];
		if (allLines) {
			codeEnd = input.size();
		}

		if (pg != null) {
			pg.start();
		}
		do {
			optimized = false;
			if (pg != null) {
				pg.nextStep();
			}

			int start = 0;
			int lastPattern2 = lastPattern;
			if (lastLine != input.size()) {
				start = lastLine;
				lastLine = input.size();
				lastPattern = -1;
			}

			int pcnt = 0;
			for (Pattern pattern : patterns) {
				pcnt++;
				if (pattern.isLooseTypes() && !platform.useLooseTypes()) {
					continue;
				}
				if (used.contains(pattern)) {
					continue;
				}

				int stl = codeStart;
				if (pcnt <= lastPattern2) {
					stl = start;
				}

				for (int i = stl; i < codeEnd; i++) {
					String line = input.get(i);
					if (line.trim().startsWith(";") && pattern.isSkipComments()) {
						continue;
					}
					int sp = pattern.getPos();
					boolean matches = pattern.matches(line, i, const2Value);
					if (matches) {
						String name = pattern.getName();
						Integer cnt = type2count.get(name);
						if (cnt == null) {
							type2count.put(name, 1);
						} else {
							type2count.put(name, cnt + 1);
						}
						int oldSize = input.size();
						input = pattern.apply(input);
						codeEnd -= (oldSize - input.size());
						optimized = true;
						int iLine = i - pattern.getSourceSize() - 1;
						if (iLine <= lastLine) {
							lastLine = iLine;
							lastPattern = pcnt;
						}
						break;
					}
					if (pattern.getPos() == 0 && sp > 1) {
						i--;
					}
				}
				if (optimized) {
					break;
				} else {
					if (!pattern.isSimple()) {
						used.add(pattern);
					}
				}
			}
		} while (optimized);

		return new OptimizationResult(input, type2count);
	}

	private void trimLines(CompilerConfig config, List<String> input) {
		int[] startEnd = getStartAndEnd(config, input);

		for (int i = startEnd[0]; i < startEnd[1]; i++) {
			input.set(i, input.get(i).trim());
		}
	}

	private List<String> removeNops(List<String> input) {
		for (Iterator<String> itty = input.iterator(); itty.hasNext();) {
			if (itty.next().equals("NOP")) {
				itty.remove();
			}
		}
		return input;
	}

	private List<String> applySpecialRules(CompilerConfig config, PlatformProvider platform, List<String> input) {
		input = simplifyBranches(config, input);
		input = applyAdditionalPatterns(config, platform, input);
		input = applyFloatingPointPatterns(config, platform, input);
		input = applyEnhancedOptimizations(config, platform, input);
		input = aggregateLoads(input);
		input = aggregateAssignments(input);
		try {
			input = applyPeekOptimization(config, platform, input);
		} catch (Exception e) {
			Logger.log("!!! Failed to apply peek optimizations: " + e.getMessage());
		}
		try {
			input = applyIntOptimizations(config, platform, input);
		} catch (Exception e) {
			Logger.log("!!! Failed to apply integer optimizations: " + e.getMessage());
		}
		input = doLastCleanups(config, platform, input);
		// input = simplifyRemainingBranches(config, input);
		return input;
	}

	/**
	 * Removes code that might be left over by some of the more advanced
	 * optimizations...
	 * 
	 * @param conf
	 * @param platform
	 * @param ret
	 * @return
	 */
	private List<String> doLastCleanups(CompilerConfig conf, PlatformProvider platform, List<String> ret) {
		List<Pattern> others = new ArrayList<>();
		Pattern tmpPat = new Pattern(false, "Remove PUSH/POP", new String[] { "" }, "JSR PUSHREAL", "JSR POPREAL");
		others.add(tmpPat);

		tmpPat = new Pattern(false, "Remove FAC/PUSH/POP", new String[] { "JSR REALFAC" }, "JSR REALFACPUSH",
				"JSR POPREAL");
		others.add(tmpPat);

		OptimizationResult res = optimizeInternalThreaded(conf, others, platform, ret, null, extractConstants(ret));
		printOutResults(res.getType2count());
		return res.getCode();
	}

	/**
	 * Optimization for things like: ...peek(xxx)=|<>|>=|<=|<|>CONST...because this
	 * is one of the seldom code fragments where one can be sure to deal with actual
	 * byte values.
	 * 
	 * @param conf
	 * @param platform
	 * @param input
	 * @return
	 */

	private List<String> applyPeekOptimization(CompilerConfig conf, PlatformProvider platform, List<String> input) {
		Map<String, Number> const2Value = extractConstants(input);

		int[] ps = getStartAndEnd(conf, input);
		int codeStart = ps[0];
		int codeEnd = ps[1];

		Pattern pattern = new Pattern(true, "Optimized comparison for PEEK", new String[] {}, "LDY {*}", "LDA #0",
				"JSR INTFAC", "JSR FACXREG", "LDA #<{CONST0}", "LDY #>{CONST0}", "JSR REALFAC", "LDA #<X_REG",
				"LDY #>X_REG", "JSR CMPFAC");

		int peekCnt = 0;
		for (int i = codeStart; i < codeEnd; i++) {
			String line = input.get(i);
			if (line.trim().startsWith(";") && pattern.isSkipComments()) {
				continue;
			}
			boolean matches = pattern.matches(line, i, const2Value);
			if (matches) {
				List<List<String>> parts = pattern.split(input);
				List<String> cleaned = parts.get(1).stream().filter(p -> !p.startsWith(";"))
						.collect(Collectors.toList());
				String consty = cleaned.get(4);
				consty = consty.substring(consty.indexOf("<") + 1).trim();
				Number num = const2Value.get(consty);
				double numd = num.doubleValue();
				if (numd == (int) numd && numd >= 0 && numd < 256) {
					List<String> rep = new ArrayList<>();
					rep.add(cleaned.get(0).replace("LDY", "LDA"));
					rep.add("CMP #" + (int) numd);
					rep.add("BCC PEEKLT" + peekCnt);
					rep.add("BEQ PEEKEQ" + peekCnt);
					rep.add("LDA #$FF");
					rep.add("JMP PEEKDONE" + peekCnt);
					rep.add("PEEKLT" + peekCnt + ":");
					rep.add("LDA #$01");
					rep.add("JMP PEEKDONE" + peekCnt);
					rep.add("PEEKEQ" + peekCnt + ":");
					rep.add("LDA #0");
					rep.add("PEEKDONE" + (peekCnt++) + ":");
					rep.add("; " + pattern.getName());
					for (int p = rep.size(); p < parts.get(1).size(); p++) {
						rep.add(";");
					}
					input = new ArrayList<>(parts.get(0));
					input.addAll(rep);
					input.addAll(parts.get(2));
				} else {
					//
				}
				pattern.reset();
			}
		}

		if (peekCnt > 0) {
			Logger.log("Optimization " + pattern.getName() + " applied " + peekCnt + " times!");
		}

		return input;
	}

	private List<String> applyIntOptimizations(CompilerConfig conf, PlatformProvider platform, List<String> input) {

		// if (true) return input;

		Map<String, Number> const2Value = extractConstants(input);
		int[] ps = getStartAndEnd(conf, input);
		int codeStart = ps[0];
		int codeEnd = ps[1];
		List<IntPattern> intPatterns = new ArrayList<>();

		// if l%=h% etc.
		intPatterns.add(new IntPattern(true, "Optimized code for Integer(1)",
				new String[] { "LDY {*}", "LDA {*}", "JSR INTFAC", "JSR FACYREG", "LDY {*}", "LDA {*}", "JSR INTFAC",
						"JSR FACXREG", "JSR YREGFAC", "LDA #<X_REG", "LDY #>X_REG", "JSR CMPFAC" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						List<String> rep = new ArrayList<>();
						rep.add(cleaned.get(0));
						rep.add(cleaned.get(1));
						rep.add("STY TMP_ZP");
						rep.add("STA TMP_ZP+1");
						rep.add(cleaned.get(4));
						rep.add(cleaned.get(5));
						rep.add("JSR ICMP");
						return combine(pattern, rep);
					}
				}));

		// if l%=123 etc.
		intPatterns.add(new IntPattern(true, "Optimized code for Integer(2)",
				new String[] { "LDA #<{CONST0}", "LDY #>{CONST0}", "JSR COPY2_XYA_YREG", "LDY {*}", "LDA {*}",
						"JSR INTFAC", "JSR FACXREG", "JSR YREGFAC", "LDA #<X_REG", "LDY #>X_REG", "JSR CMPFAC" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String consty = cleaned.get(0);
						consty = consty.substring(consty.indexOf("<") + 1).trim();
						Number num = const2Value.get(consty);
						double numd = num.doubleValue();
						if (numd == (int) numd && numd >= -32768 && numd < 32768) {
							String numHex = getHex(numd);
							List<String> rep = new ArrayList<>();
							rep.add("LDA #$" + numHex.substring(2));
							rep.add("LDY #$" + numHex.substring(0, 2));
							rep.add("STA TMP_ZP");
							rep.add("STY TMP_ZP+1");
							rep.add(cleaned.get(3));
							rep.add(cleaned.get(4));
							rep.add("JSR ICMP");
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));

		// if 123=l% etc.
		intPatterns.add(new IntPattern(true, "Optimized code for Integer(3)",
				new String[] { "LDY {*}", "LDA {*}", "JSR INTFAC", "JSR FACYREG", "LDA #<{CONST0}", "LDY #>{CONST0}",
						"JSR COPY2_XYA XREG", "JSR YREGFAC", "LDA #<X_REG", "LDY #>X_REG", "JSR CMPFAC" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String consty = cleaned.get(4);
						consty = consty.substring(consty.indexOf("<") + 1).trim();
						Number num = const2Value.get(consty);
						double numd = num.doubleValue();
						if (numd == (int) numd && numd >= -32768 && numd < 32768) {
							String numHex = getHex(numd);
							List<String> rep = new ArrayList<>();
							rep.add(cleaned.get(0));
							rep.add(cleaned.get(1));
							rep.add("STY TMP_ZP");
							rep.add("STA TMP_ZP+1");
							rep.add("LDA #$" + numHex.substring(2));
							rep.add("LDY #$" + numHex.substring(0, 2));
							rep.add("JSR ICMP");
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));

		// if l%(6)=h% etc.
		intPatterns.add(new IntPattern(true, "Optimized code for Integer(4)", new String[] { "JSR {*}", "LDY {*}",
				"LDA {*}", "JSR INTFAC", "LDA #<X_REG", "LDY #>X_REG", "JSR CMPFAC" }, new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String jumpy = cleaned.get(0);
						if (jumpy.contains("ARRAYACCESS_INTEGER")) {
							List<String> rep = new ArrayList<>();
							rep.add(cleaned.get(0));
							rep.add(cleaned.get(1));
							rep.add(cleaned.get(2));
							rep.add("STY TMP_ZP");
							rep.add("STA TMP_ZP+1");
							rep.add("LDY TMP2_ZP");
							rep.add("LDA TMP2_ZP+1");
							rep.add("JSR ICMP");
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));

		// if h%=l%(6) etc.
		intPatterns.add(new IntPattern(true, "Optimized code for Integer(5)",
				new String[] { "JSR {*}", "LDA #<X_REG", "LDY #>X_REG", "STY TMP3_ZP+1", "LDX #<Y_REG", "LDY #>Y_REG",
						"JSR COPY2_XYA", "LDY {*}", "LDA {*}", "JSR INTFAC", "JSR FACXREG", "JSR YREGFAC",
						"LDA #<X_REG", "LDY #>X_REG", "JSR CMPFAC" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String jumpy = cleaned.get(0);
						if (jumpy.contains("ARRAYACCESS_INTEGER")) {
							List<String> rep = new ArrayList<>();
							rep.add(cleaned.get(0));
							rep.add("LDY TMP2_ZP");
							rep.add("LDA TMP2_ZP+1");
							rep.add("STY TMP_ZP");
							rep.add("STA TMP_ZP+1");
							rep.add(cleaned.get(7));
							rep.add(cleaned.get(8));
							rep.add("JSR ICMP");
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));

		// if i% then...
		intPatterns.add(new IntPattern(true, "Optimized code for Integer(6)",
				new String[] { "LDY {*}", "LDA {*}", "JSR INTFAC", "JSR FACYREG", "LDA Y_REG", "{LABEL}", "BEQ {*}" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						List<String> rep = new ArrayList<>();
						rep.add(cleaned.get(0).replace("LDY", "LDA"));
						rep.add(cleaned.get(1).replace("LDA", "ORA"));
						rep.add(cleaned.get(5));
						rep.add(cleaned.get(6));
						return combine(pattern, rep);
					}
				}));

		// mid$(a$,i,<const>)
		intPatterns.add(new IntPattern(true, "Optimized code for MID",
				new String[] { "LDA #<{CONST0}", "LDY #>{CONST0}", "STY TMP3_ZP+1", "LDX #<D_REG", "LDY #>D_REG",
						"JSR COPY2_XYA", "LDA {*}", "LDY {*}", "STA B_REG", "STY B_REG+1", "JSR MID" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String consty = cleaned.get(0);
						consty = consty.substring(consty.indexOf("<") + 1).trim();
						Number num = const2Value.get(consty);
						int numd = num.intValue();
						List<String> rep = new ArrayList<>();
						// While this isn't what the interpreter would do, it's bs anyway, so we handle
						// it like this...
						if (numd < 0) {
							rep.add(cleaned.get(6));
							rep.add(cleaned.get(7));
							rep.add(cleaned.get(8));
							rep.add(cleaned.get(9));
							rep.add("JSR MIDNEGC");
						} else {
							if (numd > 255) {
								numd = 255;
							}
							rep.add(cleaned.get(6));
							rep.add(cleaned.get(7));
							rep.add(cleaned.get(8));
							rep.add(cleaned.get(9));
							rep.add("LDY #" + numd);
							rep.add("JSR MIDCONST");
						}
						return combine(pattern, rep);
					}
				}));

		// ON XX GOTO/GOSUB...
		intPatterns.add(new IntPattern(true, "Optimized code for ON XX GOYYY",
				new String[] { "JSR BASINT", "JSR {*}", "{LABEL}", "JSR ONETOFAC" }, new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String label = cleaned.get(2);

						// The result of BASINT can either be stored in X or Y, so we have to handle
						// both...
						if (label.startsWith("ON") && label.contains("SUB") && cleaned.get(1).contains("FAC")) {

							// Search for the end of the ON XX block and adjust the lists
							// accordingly...
							List<String> bet = new ArrayList<>(parts.get(1));
							List<String> last = new ArrayList<>(parts.get(2));

							for (Iterator<String> itty = last.iterator(); itty.hasNext();) {
								String line = itty.next();
								if (line.startsWith("GSKIPON")) {
									break;
								}
								itty.remove();
								bet.add(line);
							}

							// Set the new parts...
							parts.set(1, bet);
							parts.set(2, last);

							List<String> rep = new ArrayList<>();
							rep.add("JSR FACWORD");
							rep.add("STY TMP_ZP");
							int cnt = 0;
							int block = 0;
							boolean skip = false;

							// Finally replace the performance heavy section with something much simpler...
							for (String line : bet) {
								cnt++;
								if (cnt < 3) {
									continue;
								}
								if (!skip) {
									rep.add(line);
								}
								if (line.startsWith("ON") && line.contains("SUB")) {
									block++;
									skip = true;
								}
								if (line.equals("JSR CMPFAC")) {
									skip = false;
									rep.add("LDA #" + block);
									rep.add("CMP TMP_ZP");
								}
							}
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));

		// PEEK(XXXX) with XXXX being a constant
		intPatterns.add(new IntPattern(true, "Optimized code for PEEK(<constant>)",
				new String[] { "LDA #<{CONST0}", "LDY #>{CONST0}", "JSR REALFAC", "JSR FACWORD", "STY {*}", "STA {*}" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String consty = cleaned.get(0);
						consty = consty.substring(consty.indexOf("<") + 1).trim();
						Number num = const2Value.get(consty);
						int numd = num.intValue();

						List<String> rep = new ArrayList<>();
						rep.add("LDY #" + (numd & 0xff));
						rep.add("LDA #" + ((numd & 0xff00) >> 8));
						rep.add(cleaned.get(4));
						rep.add(cleaned.get(5));
						return combine(pattern, rep);
					}
				}));

		// POKE I,PEEK(I) AND 234
		intPatterns
				.add(new IntPattern(
						true, "Optimized code for POKE,PEEK", new String[] { "JSR {*}", "JSR POPREAL", "JSR FACWORD",
								"STY {*}", "STA {*}", "JSR XREGFAC", "JSR FACWORD", "{LABEL}", "STY $FFFF" },
						new AbstractCodeModifier() {
							@Override
							public List<String> modify(IntPattern pattern, List<String> input) {
								input = super.modify(pattern, input);
								String jumpy = cleaned.get(0);
								if (jumpy.contains("PEEKBYTE")) {
									List<String> rep = new ArrayList<>();
									rep.add(cleaned.get(0));
									rep.add(cleaned.get(1));
									rep.add(cleaned.get(2));
									rep.add(cleaned.get(3));
									rep.add(cleaned.get(4));
									rep.add("LDY TMP2_ZP");
									rep.add(cleaned.get(7));
									rep.add(cleaned.get(8));
									return combine(pattern, rep);
								}
								pattern.reset();
								return input;
							}
						}));

		// POKE I,PEEK(J%)
		intPatterns.add(new IntPattern(true, "Optimized code for PEEK with Integer",
				new String[] { "LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "JSR FACWORD", "STY {*}", "STA {*}" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String vary = cleaned.get(0);
						if (vary.contains("%") && cleaned.get(4).contains("MOVBSELF")) {
							List<String> rep = new ArrayList<>();
							rep.add(cleaned.get(0));
							rep.add(cleaned.get(1));
							rep.add(cleaned.get(4));
							rep.add(cleaned.get(5));
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));

		// POKE I,X%...(this one takes negative values as bytes instead of causing an
		// error...well, who cares...). It also omits the XREG-storage of the INT, but
		// that shouldn't matter here, because the block is done after the POKE anyway
		// and
		// there should be no further code referencing the value.
		intPatterns.add(new IntPattern(true, "Optimized code for POKE of Integer values",
				new String[] { "LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "JSR FACXREG", "JSR POPREAL", "JSR FACWORD",
						"STY {*}", "STA {*}", "JSR XREGFAC", "JSR FACWORD", "{LABEL}", "STY $FFFF" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String vary = cleaned.get(0);
						String label = cleaned.get(10);
						if (vary.contains("%") && label.startsWith("MOVBSELF")) {
							List<String> rep = new ArrayList<>();
							rep.add(cleaned.get(4));
							rep.add(cleaned.get(5));
							rep.add(cleaned.get(6));
							rep.add(cleaned.get(7));
							rep.add(cleaned.get(0));
							rep.add(cleaned.get(10));
							rep.add(cleaned.get(11));
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));
		
		// Integer array storage with contant index value
		intPatterns.add(new IntPattern(true, "Optimized code for fixed integer index",
				new String[] { "LDA #<{CONST0}", "LDY #>{CONST0}", "JSR COPY2_XYA_XREG", "LDY {*}", "LDA {*}", "STY AS_TMP",
						"STA AS_TMP+1", "LDA #<{MEM0}", "LDY #>{MEM0}", "STA G_REG", "STY G_REG+1", "JSR ARRAYSTORE_INT_INTEGER" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String consty = cleaned.get(0);
						consty = consty.substring(consty.indexOf("<") + 1).trim();
						Number num = const2Value.get(consty);
						int numd = num.intValue();
						List<String> rep = new ArrayList<>();
						
						rep.add(cleaned.get(3));
						rep.add(cleaned.get(4));
						rep.add(cleaned.get(5));
						rep.add(cleaned.get(6));
						rep.add(cleaned.get(7));
						rep.add(cleaned.get(8));
						rep.add(cleaned.get(9));
						rep.add(cleaned.get(10));
						rep.add("LDY #" + (numd & 0xff));
						rep.add("LDA #" + ((numd & 0xff00) >> 8));
						rep.add("JSR ARRAYSTORE_INT_INTEGER_AC");
						return combine(pattern, rep);
					}
				}));
		

		for (int i = codeStart; i < codeEnd; i++) {
			String line = input.get(i);
			if (line.trim().startsWith(";")) {
				continue;
			}

			for (IntPattern pattern : intPatterns) {
				boolean matches = pattern.matches(line, i, const2Value);
				if (matches) {
					input = pattern.modify(input);
				}
			}
		}

		int cnt = intPatterns.stream().map(p -> p.getUsage()).reduce(0, Integer::sum);
		if (cnt > 0) {
			Logger.log("Optimization Optimized code for Integer applied " + cnt + " times!");
		}

		return input;
	}

	private String getHex(double value) {
		int nummy = (((int) value) & 0x0000ffff);
		String numHex = Integer.toHexString(nummy);
		return "0000".substring(numHex.length()) + numHex;
	}

	private List<String> aggregateLoads(List<String> input) {
		boolean loadMode = false;
		for (Iterator<String> itty = input.iterator(); itty.hasNext();) {
			String line = itty.next().trim();
			if (line.startsWith(";") || line.isEmpty() || line.equals("NOP")) {
				continue;
			}
			if (!loadMode && (line.equals("LDA #0") || line.equals("LDA #$0"))) {
				loadMode = true;
			} else {
				if (loadMode) {
					if (line.equals("LDA #0") || line.equals("LDA #$0")) {
						itty.remove();
					} else if (!line.startsWith("STA")) {
						loadMode = false;
					}
				}
			}
		}
		return input;
	}

	private List<String> aggregateAssignments(List<String> input) {
		List<String> res = new ArrayList<>();
		List<String> tmp = new ArrayList<>();
		List<String> buf = new ArrayList<>();
		List<Integer> blockSize = new ArrayList<>();
		int[][] positions = new int[11][6];
		int pos = 0;
		int blocks = 0;
		boolean limit = false;
		String[] pattern = new String[] { "LDX #4", "dcloop", "LDA", "STA VAR", "DEX", "BPL dcloop" };

		for (Iterator<String> itty = input.iterator(); itty.hasNext();) {
			String line = itty.next().trim();
			buf.add(line);
			if (line.startsWith(";") || line.isEmpty() || line.equals("NOP")) {
				continue;
			}
			int oPos = pos;
			if (line.startsWith(pattern[oPos]) && !limit) {
				positions[blocks][oPos] = tmp.size() + buf.size() - 1;
				pos++;
				if (pos == pattern.length) {
					tmp.addAll(buf);
					blockSize.add(buf.size());
					buf.clear();
					pos = 0;
					blocks++;
					if (blocks > 10) {
						limit = true;
					}
				}
			}
			if (!line.startsWith(pattern[oPos]) || limit) {
				if (blocks > 1) {
					for (int b = 0; b < blocks; b++) {
						if (b == 0) {
							res.add(tmp.get(positions[b][0]));
							res.add(tmp.get(positions[b][1]));
						}
						res.add(tmp.get(positions[b][2]));
						res.add(tmp.get(positions[b][3]));
						if (b == blocks - 1) {
							res.add(tmp.get(positions[0][4]));
							res.add(tmp.get(positions[0][5]));
						}
					}
					res.add("; Special rule: Aggregation of assignments (" + blocks + ")");
				} else {
					if (blocks == 1) {
						res.addAll(tmp);
					}
				}
				if (!buf.isEmpty()) {
					res.addAll(buf);
					buf.clear();
				}
				limit = false;
				blocks = 0;
				pos = 0;
				tmp.clear();
				blockSize.clear();
			}
		}
		return res;
	}

	private List<String> trackAndModifyRegisterUsage(List<String> code) {
		Map<String, Integer[]> regState = new HashMap<>();
		Set<Integer> swaps = new HashSet<>();
		String lastReg = "";
		for (int i = 0; i < code.size(); i++) {
			String line = code.get(i);
			if (line.startsWith(";")) {
				continue;
			}

			if (line.startsWith("JMP") || line.startsWith("B") || line.startsWith("RTS")) {
				regState.clear();
				lastReg = "";
			}

			if (line.startsWith("L") && line.endsWith("_REG")) {
				String reg = line.substring(line.indexOf(" ")).trim();
				lastReg = reg;
				Integer[] state = regState.get(reg);

				if (state == null) {
					regState.put(reg, new Integer[] { 0, i }); // Unknown
					// state...yet
				} else {
					if (code.get(i + 2).startsWith("JSR FACMEM")) {
						regState.put(reg, new Integer[] { 1, i });
					}
				}
			} else {
				Integer[] state = regState.get(lastReg);
				if (state != null) {
					if (line.startsWith("JSR FACMEM")) {
						regState.put(lastReg, new Integer[] { 1, state[1] });
					} else {
						if (line.startsWith("JSR REALFAC") || line.startsWith("JSR MEMARG")
								|| line.startsWith("JSR MEMMUL")) {

							if (state[0] < 2) {
								regState.put(lastReg, new Integer[] { 2, state[1] });
							} else {
								if (!swaps.contains(state[1])) {
									// The value from the register is read
									// without
									// being written before again...don't
									// optimize
									// the initial setter away...
									// ...so we swap the order of that setter to
									// prevent this.
									String l1 = code.get(state[1]);
									String l0 = code.get(state[1] - 1);
									code.set(state[1] - 1, l1);
									code.set(state[1], l0);

									Logger.log("Swapped: " + l0 + "/" + l1 + "@" + state[1]);
									swaps.add(state[1]);
								}
							}
						} else {
							lastReg = "";
						}
					}
				} else {
					lastReg = "";
				}
			}
		}
		return code;
	}

	private List<String> simplifyBranches(CompilerConfig conf, List<String> input) {
		List<String> ret = new ArrayList<String>();
		String end = getEndText(conf);
		for (int i = 0; i < input.size() - 2; i++) {
			String line = trimLine(input, i);
			String line2 = trimLine(input, i + 1);
			String line3 = trimLine(input, i + 2);
			if (line.startsWith(end)) {
				ret.addAll(input.subList(i, input.size()));
				break;
			}
			boolean skip = false;
			int add = 1;
			if (line2.startsWith(";")) {
				line2 = line3;
				add = 2;
			}
			if (line.contains("BNE LINE_NSKIP") && line2.contains("JMP LINE_SKIP")) {
				for (int p = i + 1; p < Math.min(input.size(), i + 30); p++) {
					String subLine = input.get(p);
					if (subLine.startsWith("LINE_SKIP")) {
						ret.add(line2.replace("JMP LINE_SKIP", "BEQ LINE_SKIP"));
						ret.add("; Simplified conditional branch");
						skip = true;
						i += add;
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

	private List<String> applyAdditionalPatterns(CompilerConfig conf, PlatformProvider platform, List<String> ret) {
		// Do another run with the normal optimizer method but with some
		// additional rules. Unlike the "big" run, this one happens in a single
		// thread, because it's quite cheap to do anyway.
		List<Pattern> others = new ArrayList<>();
		Pattern tmpPat = new Pattern(false, "Simplified not equal comparison",
				new String[] { "{LINE0}", "{LINE4}", "{LINE6}", "{LINE7}", "{LINE8}", "{LINE9}" }, "JSR CMPFAC",
				"BNE {*}", "LDA #0", "JMP {*}", "{LABEL}", "LDA #$1", "{LABEL}", "{LABEL}", "BEQ {*}", "{LABEL}");
		tmpPat.setSkipComments(true);
		others.add(tmpPat);
		tmpPat = new Pattern(false, "Simplified equal comparison",
				new String[] { "{LINE0}", "{LINE4}", "{LINE6}", "{LINE7}", "{LINE8}|BEQ>BNE", "{LINE9}" }, "JSR CMPFAC",
				"BEQ {*}", "LDA #0", "JMP {*}", "{LABEL}", "LDA #$1", "{LABEL}", "{LABEL}", "BEQ {*}", "{LABEL}");
		tmpPat.setSkipComments(true);
		others.add(tmpPat);
		tmpPat = new Pattern(false, "Direct compare(=) of floats",
				new String[] { "LDX #4", "dceloop{cnt}:", "LDA {MEM0},X", "CMP {MEM1},X", "{LINE9}", "DEX",
						"BPL dceloop{cnt}" },
				"LDA #<{MEM0}", "LDY #>{MEM0}", "JSR REALFAC", "LDA #<{MEM1}", "LDY #>{MEM1}", "JSR CMPFAC", "{LABEL}",
				"{LABEL}", "{LABEL}", "BNE {*}");
		others.add(tmpPat);
		tmpPat = new Pattern(false, "Direct compare(<>) of floats",
				new String[] { "LDX #4", "dcneloop{cnt}:", "LDA {MEM0},X", "CMP {MEM1},X",
						"{LINE9}|BEQ LINE_SKIP>BNE LINE_NSKIP", "DEX", "BPL dcneloop{cnt}", "{LINE9}|BEQ>JMP" },
				"LDA #<{MEM0}", "LDY #>{MEM0}", "JSR REALFAC", "LDA #<{MEM1}", "LDY #>{MEM1}", "JSR CMPFAC", "{LABEL}",
				"{LABEL}", "{LABEL}", "BEQ {*}");
		others.add(tmpPat);
		// Optimizes =0 slightly...nothing to write home about, though...
		tmpPat = new Pattern(true, "Reverted comparison",
				new String[] { "{LINE0}", "{LINE3}|JMP>BEQ", "{LINE4}", "{LINE8}|BEQ>JMP", "{LINE6}", "{LINE7}" },
				"LDA {MEM0}", "BEQ {*}", "LDA #0", "JMP {*}", "{LABEL}", "LDA #$1", "{LABEL}", "{LABEL}", "BEQ {*}");
		others.add(tmpPat);

		OptimizationResult res = optimizeInternalThreaded(conf, others, platform, ret, null, extractConstants(ret));
		printOutResults(res.getType2count());
		return res.getCode();
	}

	private List<String> applyEnhancedOptimizations(CompilerConfig config, PlatformProvider platform,
			List<String> ret) {
		if (config.isEnhancedInstructionSet()) {
			// Do another run with 65C02 specific optimizations
			List<Pattern> others = new ArrayList<>();
			others.add(new Pattern(true, "STZ (1)", new String[] { "{LINE1}|STA>STZ", "{LINE2}|STA>STZ" }, "LDA #0",
					"STA {*}", "STA {*}"));
			others.add(new Pattern(true, "STZ (2)", new String[] { "{LINE1}|STA>STZ" }, "LDA #0", "STA {*}"));
			OptimizationResult res = optimizeInternalThreaded(config, others, platform, ret, null,
					extractConstants(ret), false);
			printOutResults(res.getType2count());
			return res.getCode();
		}
		return ret;
	}

	private List<String> applyFloatingPointPatterns(CompilerConfig config, PlatformProvider platform,
			List<String> ret) {
		if (config.isAggressiveFloatOptimizations()) {
			// Do another run with fp optimizations
			List<Pattern> others = new ArrayList<>();
			others.add(new Pattern(true, "Fast FADD (ARG)", new String[] { "JSR FASTFADDARG" }, "JSR ARGADD"));
			others.add(new Pattern(true, "Fast FADD (MEM)", new String[] { "JSR FASTFADDMEM" }, "JSR FACADD"));
			others.add(new Pattern(true, "Fast FMUL (ARG)", new String[] { "JSR FASTFMULARG" }, "JSR FACMUL"));
			others.add(new Pattern(true, "Fast FMUL (MEM)", new String[] { "JSR FASTFMULMEM" }, "JSR MEMMUL"));
			others.add(new Pattern(true, "Fast FSUB (ARG)", new String[] { "JSR FASTFSUBARG" }, "JSR FACSUB"));
			others.add(new Pattern(true, "Fast FSUB (MEM)", new String[] { "JSR FASTFSUBMEM" }, "JSR MEMSUB"));
			others.add(new Pattern(true, "Fast FSQRT (NEW)", new String[] { "JSR FASTFSQRT" }, "JSR FACSQR"));
			OptimizationResult res = optimizeInternalThreaded(config, others, platform, ret, null,
					extractConstants(ret), true);
			printOutResults(res.getType2count());
			return res.getCode();
		}
		return ret;
	}

	private Map<String, Number> extractConstants(List<String> ret) {
		return Collections.unmodifiableMap(Util.extractNumberConstants(ret));
	}

	private String trimLine(List<String> input, int i) {
		String line3 = input.get(i);
		line3 = line3.replace("\t", " ").trim();
		return line3;
	}

	private int[] getStartAndEnd(CompilerConfig conf, List<String> input) {
		int codeEnd = input.size();
		int codeStart = 0;
		String end = getEndText(conf);

		for (int i = 0; i < input.size(); i++) {
			String line = input.get(i);
			if (line.startsWith("; *** CODE ***")) {
				codeStart = i;
			}
			if (line.startsWith(end)) {
				codeEnd = i;
				break;
			}
		}
		return new int[] { codeStart, codeEnd };
	}

	private String getEndText(CompilerConfig conf) {
		if (conf.isBigRam()) {
			return "; *** CONSTANTS ***";
		}
		return "; *** SUBROUTINES ***";
	}

	private List<Pattern> getPatterns() {
		return new ArrayList<Pattern>() {
			private static final long serialVersionUID = 1L;
			{
				this.add(new Pattern("Simplified setting to 0",
						new String[] { "LDA #0", "STA {MEM0}", "STA {MEM0}+1", "STA {MEM0}+2", "STA {MEM0}+3",
								"STA {MEM0}+4" },
						"LDA #<{#0.0}", "LDY #>{#0.0}", "JSR REALFAC", "LDX #<{MEM0}", "LDY #>{MEM0}", "JSR FACMEM"));
				this.add(new Pattern(false, "Faster logic OR", new String[] { "JSR FASTOR" }, "JSR FACOR"));
				this.add(new Pattern(false, "Faster logic AND", new String[] { "JSR FASTAND" }, "JSR ARGAND"));
				this.add(new Pattern(false, "Simple POKE", new String[] { "{LINE0}", "{LINE2}" }, "LDY {MEM0}",
						"LDA #0", "STY {*}"));
				this.add(new Pattern("REALOUT + LINEBRK", new String[] { "JSR REALOUTBRK" }, "JSR REALOUT",
						"JSR LINEBREAK"));
				this.add(new Pattern("STROUT + LINEBRK", new String[] { "JSR STROUTBRK" }, "JSR STROUT",
						"JSR LINEBREAK"));
				this.add(new Pattern("INTOUT + LINEBRK", new String[] { "JSR INTOUTBRK" }, "JSR INTOUT",
						"JSR LINEBREAK"));
				this.add(new Pattern("POP, REG0, VAR0", new String[] { "{LINE0}", "{LINE1}", "{LINE2}", "{LINE3}" },
						"JSR POPREAL", "LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM", "LDA #<{REG0}", "LDY #>{REG0}",
						"JSR REALFAC"));

				this.add(new Pattern(false, "Array index is integer (store)",
						new String[] { "{LINE10}", "{LINE11}", "{LINE12}", "{LINE13}", "{LINE18}", "{LINE19}",
								"{LINE20}", "{LINE21}", "{LINE0}", "{LINE1}", "{LINE22}_INT" },
						"LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM",
						"LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC", "JSR PUSHREAL", "LDA {*}", "LDY {*}",
						"STA {REG1}", "STY {REG1}", "JSR POPREAL", "LDX #<{REG2}", "LDY #>{REG2}", "JSR FACMEM",
						"LDA #<{MEM2}", "LDY #>{MEM2}", "STA G_REG", "STY G_REG+1", "JSR ARRAYSTORE{*}"));
				this.add(new Pattern(false, "Array index is integer (load)",
						new String[] { "{LINE6}", "{LINE7}", "{LINE8}", "{LINE9}", "{LINE0}", "{LINE1}",
								"{LINE10}_INT" },
						"LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM",
						"LDA #<{MEM1}", "LDY #>{MEM1}", "STA G_REG", "STY G_REG+1", "JSR ARRAYACCESS{*}"));
				this.add(new Pattern(false, "Array content is integer (store)",
						new String[] { "{LINE0}", "{LINE1}", "STY AS_TMP", "STA AS_TMP+1", "{LINE6}", "{LINE7}",
								"{LINE8}", "{LINE9}", "JSR ARRAYSTORE_INT_INTEGER" },
						"LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "LDX #<Y_REG", "LDY #>Y_REG", "JSR FACMEM",
						"LDA #<{MEM1}", "LDY #>{MEM1}", "STA G_REG", "STY G_REG+1", "JSR ARRAYSTORE_INTEGER"));

				this.add(new Pattern("Avoid PUSH/POP", new String[] { "JSR REALFAC" }, "JSR REALFACPUSH", "NOP",
						"JSR POPREAL"));

				this.add(new Pattern("Quick copy into REG",
						new String[] { "{LINE0}", "{LINE1}", "STA TMP3_ZP", "STY TMP3_ZP+1", "{LINE3}", "{LINE4}",
								"JSR COPY2_XY" },
						"LDA #<{MEM0}", "LDY #>{MEM0}", "JSR REALFAC", "LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM"));
				this.add(new Pattern(false, "Simplified CMP with 0", new String[] { "{LINE0}", "LDA FAC" },
						"JSR REALFAC", "LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM", "LDA #<{#0.0}", "LDY #>{#0.0}",
						"JSR REALFAC", "LDA #<{REG0}", "LDY #>{REG0}", "JSR CMPFAC"));
				this.add(new Pattern("REG0->REG1, REG1->REG0", new String[] { "{LINE0}", "{LINE1}", "{LINE2}" },
						"LDX #<{MEM0}", "LDY #>{MEM0}", "JSR FACMEM", "LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC",
						"LDX #<{REG1}", "LDY #>{REG1}", "JSR FACMEM", "LDA #<{REG1}", "LDY #>{REG1}", "JSR REALFAC",
						"LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM", "LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC"));
				this.add(new Pattern("REG0->VAR, REG0->REG1", new String[] { "{LINE6}", "{LINE7}", "{LINE8}" },
						"LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM", "LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC",
						"LDX #<{MEM0}", "LDY #>{MEM0}", "JSR FACMEM", "LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC",
						"LDX #<{REG1}", "LDY #>{REG1}", "JSR FACMEM", "LDA #<{REG1}", "LDY #>{REG1}", "JSR REALFAC"));

				this.add(new Pattern("FAC into REG?, REG? into FAC", null, "LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM",
						"LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC"));

				this.add(new Pattern("INT to FAC, FAC to INT", new String[] { "{LINE0}", "{LINE1}" }, "LDY {*}",
						"LDA {*}", "JSR INTFAC", "JSR FACINT"));

				this.add(new Pattern("STY A...LDY A...STY B", new String[] { "{LINE0}", "{LINE3}" }, "STY {MEM0}",
						"LDY {MEM0}", "LDA #0", "STY {*}"));
				this.add(new Pattern("FAC to INT, INT to FAC", null, "JSR INTFAC", "JSR FACINT"));
				this.add(new Pattern("VAR into FAC, FAC into VAR", null, "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR REALFAC",
						"LDX #<{MEM0}", "LDY #>{MEM0}", "JSR FACMEM"));

				this.add(new Pattern(false, "CHR with integer constant", new String[] { "LDA {MEM0}", "JSR CHRINT" },
						"LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM",
						"JSR CHR"));
				this.add(new Pattern(false, "NEXT check simplified",
						new String[] { "JSR NEXT", "LDA A_REG", "{LINE8}", "JMP (JUMP_TARGET)" }, "JSR NEXT",
						"LDY {MEM0}", "LDA {MEM0}", "CPY A_REG", "BNE {*}", "CMP A_REG+1", "BNE {*}", "{LABEL}",
						"BNE {*}", "JMP (JUMP_TARGET)"));
				this.add(new Pattern(false, "Multiple loads of the same value(1)",
						new String[] { "{LINE0}", "{LINE1}", "{LINE2}", "{LINE3}", "{LINE4}", "{LINE5}", "{LINE9}",
								"{LINE10}", "{LINE11}" },
						"LDA #<{MEM0}", "LDY #>{MEM0}", "JSR REALFAC", "LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM",
						"LDA #<{MEM0}", "LDY #>{MEM0}", "JSR REALFAC", "LDX #<{REG1}", "LDY #>{REG1}", "JSR FACMEM"));
				this.add(new Pattern(false, "Multiple loads of the same value(2)",
						new String[] { "{LINE0}", "{LINE1}", "{LINE2}", "{LINE3}", "{LINE4}", "{LINE5}", "{LINE6}",
								"{LINE11}", "{LINE12}", "{LINE13}" },
						"LDA #<{MEM0}", "LDY #>{MEM0}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG0}", "LDY #>{REG0}",
						"JSR COPY2_XY", "LDA #<{MEM0}", "LDY #>{MEM0}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG1}",
						"LDY #>{REG1}", "JSR COPY2_XY"));
				this.add(new Pattern("Value already in X",
						new String[] { "{LINE0}", "{LINE1}", "{LINE2}", "TXA", "{LINE4}" }, "LDX #<{REG0}",
						"LDY #>{REG0}", "JSR COPY2_XY", "LDA #<{REG0}", "LDY #>{REG0}"));
				this.add(new Pattern(false, "Variable used twice in calculation",
						new String[] { "{LINE3}", "{LINE4}", "{LINE5}", "TXA", "{LINE10}", "{LINE8}", "{LINE9}",
								"{LINE10}", "{LINE11}", "{LINE12}" },
						"LDX #<{REG0}", "LDY #>{REG0}", "JSR COPY2_XY", "LDX #<{REG1}", "LDY #>{REG1}", "JSR COPY2_XY",
						"LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC", "LDA #<{REG1}", "LDY #>{REG1}", "JSR MEMARG",
						"JSR {*}"));
				this.add(new Pattern(false, "Variable used twice in calculation (mul)",
						new String[] { "{LINE3}", "{LINE4}", "{LINE5}", "TXA", "{LINE10}", "{LINE8}", "{LINE9}",
								"{LINE10}", "{LINE11}" },
						"LDX #<{REG0}", "LDY #>{REG0}", "JSR COPY2_XY", "LDX #<{REG1}", "LDY #>{REG1}", "JSR COPY2_XY",
						"LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC", "LDA #<{REG1}", "LDY #>{REG1}", "JSR MEMMUL"));
				this.add(new Pattern("Avoid INTEGER->REAL conversion", true,
						new String[] { "LDA #<{CONST0}R", "LDY #>{CONST0}R", "JSR REALFAC" }, "LDY {CONST0}",
						"LDA {CONST0}", "JSR INTFAC"));
				this.add(new Pattern(false, "Array value used twice in calculation",
						new String[] { "{LINE0}", "{LINE1}", "{LINE2}", "{LINE3}", "{LINE4}", "{LINE5}", "{LINE6}",
								"{LINE7}", "{LINE8}", "{LINE9}", "{LINE10}", "{LINE11}", "{LINE12}", "{LINE13}",
								"{LINE14}", "{LINE12}", "{LINE13}", "JSR MEMARG" },
						"LDA #<{MEM0}", "LDY #>{MEM0}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG0}", "LDY #>{REG0}",
						"JSR COPY2_XY", "LDA #<{MEM1}", "LDY #>{MEM1}", "STA {REG1}", "STY {REG1}", "JSR {*}",
						"LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC", "JSR PUSHREAL", "LDA #<{MEM0}", "LDY #>{MEM0}",
						"STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG0}", "LDY #>{REG0}", "JSR COPY2_XY", "LDA #<{MEM1}",
						"LDY #>{MEM1}", "STA {REG1}", "STY {REG1}", "JSR {*}", "JSR POPREAL", "LDA #<{REG0}",
						"LDY #>{REG0}", "JSR MEMARG"));
				this.add(new Pattern(false, "Array value used twice in calculation (mul)",
						new String[] { "{LINE0}", "{LINE1}", "{LINE2}", "{LINE3}", "{LINE4}", "{LINE5}", "{LINE6}",
								"{LINE7}", "{LINE8}", "{LINE9}", "{LINE10}", "{LINE11}", "{LINE12}", "{LINE13}",
								"{LINE14}", "{LINE12}", "{LINE13}", "JSR MEMMUL" },
						"LDA #<{MEM0}", "LDY #>{MEM0}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG0}", "LDY #>{REG0}",
						"JSR COPY2_XY", "LDA #<{MEM1}", "LDY #>{MEM1}", "STA {REG1}", "STY {REG1}", "JSR {*}",
						"LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC", "JSR PUSHREAL", "LDA #<{MEM0}", "LDY #>{MEM0}",
						"STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG0}", "LDY #>{REG0}", "JSR COPY2_XY", "LDA #<{MEM1}",
						"LDY #>{MEM1}", "STA {REG1}", "STY {REG1}", "JSR {*}", "JSR POPREAL", "LDA #<{REG0}",
						"LDY #>{REG0}", "JSR MEMMUL"));
				this.add(new Pattern("Constant directly into FAC",
						new String[] { "LDA #0", "STA FAC", "{LINE2}", "{LINE3}", "LDA #0", "STA FACMOH", "STA FACMO",
								"STA FACLO", "LDY #128", "STY FACHO", "INY", "STY FAC", "LDY #$FF", "STY FACSGN",
								"{LINE6}", "{LINE8}" },
						"LDA #<REAL_CONST_ZERO", "LDY #>REAL_CONST_ZERO", "JMP {*}", "{LABEL}",
						"LDA #<REAL_CONST_MINUS_ONE", "LDY #>REAL_CONST_MINUS_ONE", "{LABEL}", "JSR REALFAC",
						"LDA FAC"));
				this.add(new Pattern(false, "Highly simplified loading for CMP",
						new String[] { "{LINE0}", "{LINE1}", "JSR REALFAC", "{LINE7}", "{LINE8}", "{LINE19}" },
						"LDA #<{MEM0}", "LDY #>{MEM0}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG0}", "LDY #>{REG0}",
						"JSR COPY2_XY", "LDA #<{MEM1}", "LDY #>{MEM1}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG1}",
						"LDY #>{REG1}", "JSR COPY2_XY", "LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC", "LDA #<{REG1}",
						"LDY #>{REG1}", "JSR CMPFAC"));
				this.add(new Pattern(false, "Highly simplified loading for calculations",
						new String[] { "{LINE0}", "{LINE1}", "JSR REALFAC", "{LINE7}", "{LINE8}", "{LINE19}",
								"{LINE20}" },
						"LDA #<{MEM0}", "LDY #>{MEM0}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG0}", "LDY #>{REG0}",
						"JSR COPY2_XY", "LDA #<{MEM1}", "LDY #>{MEM1}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG1}",
						"LDY #>{REG1}", "JSR COPY2_XY", "LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC", "LDA #<{REG1}",
						"LDY #>{REG1}", "JSR MEMARG", "JSR {*}"));
				this.add(new Pattern(false, "Highly simplified loading for calculations (mul)",
						new String[] { "{LINE0}", "{LINE1}", "JSR REALFAC", "{LINE7}", "{LINE8}", "{LINE19}" },
						"LDA #<{MEM0}", "LDY #>{MEM0}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG0}", "LDY #>{REG0}",
						"JSR COPY2_XY", "LDA #<{MEM1}", "LDY #>{MEM1}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDX #<{REG1}",
						"LDY #>{REG1}", "JSR COPY2_XY", "LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC", "LDA #<{REG1}",
						"LDY #>{REG1}", "JSR MEMMUL"));
				this.add(new Pattern(false, "NEXT with no variable name simplified",
						new String[] { "LDA #0", "STA A_REG", "STA A_REG+1", "JSR NEXT" }, "LDY {CONST0}",
						"LDA {CONST0}", "STY A_REG", "STA A_REG+1", "JSR NEXT"));
				this.add(new Pattern("Improved copy from REG0 to REG1",
						new String[] { "{LINE0}", "{LINE1}", "STA TMP3_ZP", "STY TMP3_ZP+1", "{LINE3}", "{LINE4}",
								"JSR COPY2_XY" },
						"LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC", "LDX #<{REG1}", "LDY #>{REG1}", "JSR FACMEM"));
				this.add(new Pattern(false, "Fast address push", new String[] { "{LINE4}", "{LINE5}", "{LINE6}" },
						"STA {REG0}", "STY {REG0}", "LDA {REG0}", "LDY {REG0}", "STA TMP_ZP", "STY TMP_ZP+1",
						"JSR PUSHINT"));
				this.add(new Pattern(false, "Simplified loading of Strings",
						new String[] { "{LINE4}", "{LINE5}", "{LINE6}", "{LINE7}", "{LINE8}" }, "STA {REG0}",
						"STY {REG0}", "LDA {REG0}", "LDY {REG0}", "STA TMP_ZP", "STY TMP_ZP+1", "LDA #<{MEM0}",
						"LDY #>{MEM0}", "JSR COPYSTRING"));
				this.add(new Pattern("MEM->REG, REG->TMP_ZP",
						new String[] { "{LINE0}", "{LINE1}", "{LINE6}", "{LINE7}" }, "LDA #<{MEM0}", "LDY #>{MEM0}",
						"STA {REG0}", "STY {REG0}", "LDA {REG0}", "LDY {REG0}", "STA TMP_ZP", "STY TMP_ZP+1"));
				this.add(new Pattern("Direct loading of values into FAC",
						new String[] { "{LINE0}", "{LINE1}", "{LINE9}" }, "LDA #<{MEM0}", "LDY #>{MEM0}", "STA TMP3_ZP",
						"STY TMP3_ZP+1", "LDX #<Y_REG", "LDY #>Y_REG", "JSR COPY2_XY", "TXA", "LDY #>Y_REG",
						"JSR REALFAC"));
				this.add(new Pattern(false, "POP, REG0, VAR0 -> direct calc",
						new String[] { "{LINE0}", "{LINE4}", "{LINE5}", "{LINE6}", "{LINE7}" }, "JSR POPREAL",
						"LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM", "LDA #<{REG1}", "LDY #>{REG1}", "JSR MEMARG",
						"JSR {*}"));
				this.add(new Pattern(false, "POP, REG0, VAR0 -> direct calc (mul)",
						new String[] { "{LINE0}", "{LINE4}", "{LINE5}", "{LINE6}" }, "JSR POPREAL", "LDX #<{REG0}",
						"LDY #>{REG0}", "JSR FACMEM", "LDA #<{REG1}", "LDY #>{REG1}", "JSR MEMMUL"));
				this.add(new Pattern(false, "POP, REG0, VAR0 -> to WORD", new String[] { "{LINE0}", "{LINE4}" },
						"JSR POPREAL", "LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM", "JSR FACWORD"));
				this.add(new Pattern(false, "Load and PUSH combined", new String[] { "JSR REALFACPUSH" }, "JSR REALFAC",
						"JSR PUSHREAL"));
				this.add(new Pattern(false, "Memory saving copy",
						new String[] { "{LINE1}", "{LINE2}", "{LINE3}", "JSR COPY2_XYA" }, "STA TMP3_ZP",
						"STY TMP3_ZP+1", "LDX #<{REG0}", "LDY #>{REG0}", "JSR COPY2_XY"));
				this.add(new Pattern(false, "Memory saving array access (real)",
						new String[] { "{LINE0}", "{LINE1}", "JSR ARRAYACCESS_REAL_S" }, "LDA #<{MEM0}", "LDY #>{MEM0}",
						"STA G_REG", "STY G_REG+1", "JSR ARRAYACCESS_REAL"));
				this.add(new Pattern(false, "Memory saving array access (integer)",
						new String[] { "{LINE0}", "{LINE1}", "JSR ARRAYACCESS_INTEGER_S" }, "LDA #<{MEM0}",
						"LDY #>{MEM0}", "STA G_REG", "STY G_REG+1", "JSR ARRAYACCESS_INTEGER"));
				this.add(new Pattern(false, "POPREAL and load X", new String[] { "JSR POPREAL2X" }, "JSR POPREAL",
						"LDA #<X_REG", "LDY #>X_REG", "JSR MEMARG"));
				this.add(new Pattern(false, "Simplified CMP redux",
						new String[] { "{LINE0}", "{LINE2}", "{LINE3}", "LDA #$1", "{LINE14}", "{LINE16}",
								"{LINE17}", },
						"LDA #0", "STA FAC", "JMP {*}", "{LABEL}", "LDA #0", "STA FACMOH", "STA FACMO", "STA FACLO",
						"LDY #128", "STY FACHO", "INY", "STY FAC", "LDY #$FF", "STY FACSGN", "{LABEL}", "LDA FAC",
						"{LABEL}", "BNE {*}"));
				this.add(new Pattern(false, "CMP (REG) = 0", new String[] { "LDA {REG0}", "{LINE6}", "{LINE7}" },
						"LDA #<{#0.0}", "LDY #>{#0.0}", "JSR REALFAC", "LDA #<{REG0}", "LDY #>{REG0}", "JSR CMPFAC",
						"BEQ {*}", "LDA #0"));
				this.add(new Pattern(false, "CMP (REG) != 0", new String[] { "LDA {REG0}", "{LINE6}", "{LINE7}" },
						"LDA #<{#0.0}", "LDY #>{#0.0}", "JSR REALFAC", "LDA #<{REG0}", "LDY #>{REG0}", "JSR CMPFAC",
						"BNE {*}", "LDA #0"));
				this.add(new Pattern(false, "CMP (MEM) = 0", new String[] { "LDA {MEM0}", "{LINE6}", "{LINE7}" },
						"LDA #<{#0.0}", "LDY #>{#0.0}", "JSR REALFAC", "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR CMPFAC",
						"BEQ {*}", "LDA #0"));
				this.add(new Pattern(false, "CMP (MEM) != 0", new String[] { "LDA {MEM0}", "{LINE6}", "{LINE7}" },
						"LDA #<{#0.0}", "LDY #>{#0.0}", "JSR REALFAC", "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR CMPFAC",
						"BNE {*}", "LDA #0"));

				this.add(new Pattern(false, "CMP (REG) = 0(2)", new String[] { "LDA {REG0}", "{LINE6}", "{LINE7}" },
						"LDA #<{#0.0}", "LDY #>{#0.0}", "JSR REALFAC", "LDA #<{REG0}", "LDY #>{REG0}", "JSR CMPFAC",
						"{LABEL}", "BEQ {*}"));
				this.add(new Pattern(false, "CMP (REG) != 0(2)", new String[] { "LDA {REG0}", "{LINE6}", "{LINE7}" },
						"LDA #<{#0.0}", "LDY #>{#0.0}", "JSR REALFAC", "LDA #<{REG0}", "LDY #>{REG0}", "JSR CMPFAC",
						"{LABEL}", "BNE {*}"));
				this.add(new Pattern(false, "CMP (MEM) = 0(2)", new String[] { "LDA {MEM0}", "{LINE6}", "{LINE7}" },
						"LDA #<{#0.0}", "LDY #>{#0.0}", "JSR REALFAC", "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR CMPFAC",
						"{LABEL}", "BEQ {*}"));
				this.add(new Pattern(false, "CMP (MEM) != 0(2)", new String[] { "LDA {MEM0}", "{LINE6}", "{LINE7}" },
						"LDA #<{#0.0}", "LDY #>{#0.0}", "JSR REALFAC", "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR CMPFAC",
						"{LABEL}", "BNE {*}"));
				this.add(new Pattern(
						false, "Direct loading of 0", new String[] { "LDA #$0", "STA FAC", "STA FACHO", "STA FACMOH",
								"STA FACMO", "STA FACLO", "STA FACSGN" },
						"LDA #<{#0.0}", "LDY #>{#0.0}", "JSR REALFAC"));

				this.add(new Pattern(false, "FAC into REG?, REG? into FAC (2)",
						new String[] { "{LINE0}", "{LINE1}", "{LINE2}" }, "LDY #>{REG0}", "LDX #<{REG0}", "JSR FACMEM",
						"LDA #<{REG0}", "LDY #>{REG0}", "JSR REALFAC"));
				this.add(new Pattern(false, "Fast INTEGER array access (1)",
						new String[] { "JSR ARRAYACCESS_INTEGER_SI", "{LINE5}", "{LINE6}" },
						"JSR ARRAYACCESS_INTEGER_S", "LDA #<X_REG", "LDY #>X_REG", "JSR REALFAC", "JSR FACINT",
						"STY {MEM0}", "STA {MEM0}"));

				this.add(new Pattern(false, "Fast INTEGER array access (2)",
						new String[] { "JSR ARRAYACCESS_INTEGER_INT_SI", "{LINE5}", "{LINE6}" },
						"JSR ARRAYACCESS_INTEGER_INT", "LDA #<X_REG", "LDY #>X_REG", "JSR REALFAC", "JSR FACINT",
						"STY {MEM0}", "STA {MEM0}"));

				this.add(new Pattern(false, "Fast INTEGER INC", new String[] { "{LINE0}", "{LINE1}", "JSR FIINX" },
						"LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "LDX #<X_REG", "LDY #>X_REG", "JSR FACMEM",
						"JSR FINX"));
				this.add(new Pattern(false, "Fast INTEGER DEC", new String[] { "{LINE0}", "{LINE1}", "JSR FIDEX" },
						"LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "LDX #<X_REG", "LDY #>X_REG", "JSR FACMEM",
						"JSR FDEX"));
				this.add(new Pattern(false, "Even faster INTEGER INC", new String[] { "JSR SUPERFIINX" }, "JSR FIINX",
						"LDA #<X_REG", "LDY #>X_REG", "JSR REALFAC", "JSR FACINT"));
				this.add(new Pattern(false, "Even faster INTEGER DEC", new String[] { "JSR SUPERFIDEX" }, "JSR FIDEX",
						"LDA #<X_REG", "LDY #>X_REG", "JSR REALFAC", "JSR FACINT"));
				this.add(new Pattern(false, "Store and load", new String[] { "{LINE0}", "{LINE1}", "NOP" },
						"STY {MEM0}", "STA {MEM0}", "NOP", "LDY {MEM0}", "LDA {MEM0}"));
				this.add(new Pattern(false, "Memory saving STROUT", new String[] { "JSR STROUTWL" }, "STA A_REG",
						"STY A_REG+1", "JSR STROUT"));
				this.add(new Pattern(false, "Memory saving STROUTBRK", new String[] { "JSR STROUTBRKWL" }, "STA A_REG",
						"STY A_REG+1", "JSR STROUTBRK"));
				this.add(new Pattern(false, "Simplified loading of A",
						new String[] { "{LINE0}", "{LINE1}", "STX A_REG", "STY A_REG+1", "{LINE2}" }, "LDX #<{MEM0}",
						"LDY #>{MEM0}", "JSR FACMEM", "LDA #<{MEM0}", "LDY #>{MEM0}", "STA A_REG", "STY A_REG+1"));
				this.add(new Pattern(false, "Direct copy of floats into mem",
						new String[] { "LDX #4", "dcloop{cnt}:", "LDA {MEM0},X", "STA {MEM1},X", "DEX",
								"BPL dcloop{cnt}" },
						"LDA #<{MEM0}", "LDY #>{MEM0}", "JSR REALFAC", "LDX #<{MEM1}", "LDY #>{MEM1}", "JSR FACMEM"));
				this.add(new Pattern(false, "Single character output", new String[] { "{LINE0}", "JSR SINGLECHROUT" },
						"LDA  {*}", "JSR CHRINT", "JSR STROUT"));
				this.add(new Pattern(false, "Single character output and break",
						new String[] { "{LINE0}", "JSR SINGLECHROUTBRK" }, "LDA  {*}", "JSR CHRINT", "JSR STROUTBRK"));
				// two mainly X16/VPOKE specific optimizations ahead:
				this.add(new Pattern(false, "Fast byte conversion and store",
						new String[] { "{LINE3}", "{LINE4}", "{LINE0}", "{LINE1}", "JSR REALFAC", "{LINE6}" },
						"LDA #<{MEM0}", "LDY #>{MEM0}", "JSR REALFACPUSH", "LDY {MEM1}", "STY {*}", "JSR POPREAL",
						"JSR FACWORD"));
				this.add(new Pattern(false, "Byte store between PUSH/POP", new String[] { "{LINE1}", "{LINE2}" },
						"JSR PUSHREAL", "LDY {MEM1}", "STY {*}", "JSR POPREAL"));
				this.add(new Pattern(false, "Combine load and add", new String[] { "JSR FACADD" }, "JSR MEMARG",
						"JSR ARGADD"));
				this.add(new Pattern(false, "Combine load and div", new String[] { "JSR FACDIV" }, "JSR MEMARG",
						"JSR ARGDIV"));
				this.add(new Pattern(false, "Combine load and mul", new String[] { "JSR MEMMUL" }, "JSR MEMARG",
						"JSR FACMUL"));
				this.add(new Pattern(false, "Combine load and sub", new String[] { "JSR MEMSUB" }, "JSR MEMARG",
						"JSR FACSUB"));

				this.add(new Pattern(false, "Swap AND order",
						new String[] { "{LINE0}", "{LINE1}", "{LINE2}", "{LINE3}", "{LINE4}", "{LINE8}", "{LINE9}" },
						"LDX #<X_REG", "LDY #>X_REG", "JSR FACMEM", "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR REALFAC",
						"LDA #<X_REG", "LDY #>X_REG", "JSR MEMARG", "JSR FASTAND"));
				this.add(new Pattern(false, "Swap OR order",
						new String[] { "{LINE0}", "{LINE1}", "{LINE2}", "{LINE3}", "{LINE4}", "{LINE8}", "{LINE9}" },
						"LDX #<X_REG", "LDY #>X_REG", "JSR FACMEM", "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR REALFAC",
						"LDA #<X_REG", "LDY #>X_REG", "JSR MEMARG", "JSR FASTOR"));

				this.add(new Pattern(false, "Fast byte copy",
						new String[] { "{LINE0}", "STY TMP_ZP", "{LINE6}", "{LINE7}", "{LINE8}", "{LINE9}",
								"LDY TMP_ZP", "{LINE14}", "{LINE15}" },
						"LDY $FFFF", "LDA #0", "JSR INTFAC", "LDX #<{REG0}", "LDY #>{REG0}", "JSR FACMEM",
						"JSR POPREAL", "JSR FACWORD", "STY {*}", "STA {*}", "LDA #<{REG0}", "LDY #>{REG0}",
						"JSR REALFAC", "JSR FACWORD", "{LABEL}", "STY $FFFF"));
				// This optimizes stuff like: a=i*1:if a>1...by not loading a again for the if
				// if it's already in the FAC: It has to cross the NOP gap between the command
				// to do this though...
				this.add(new Pattern(false, "Omit FAC load",
						new String[] { "{LINE0}", "{LINE1}", "{LINE2}", "{LINE3}" }, "LDX #<{MEM1}", "LDY #>{MEM1}",
						"JSR FACMEM", "NOP", "LDA #<{MEM1}", "LDY #>{MEM1}", "JSR REALFAC"));

				this.add(new Pattern(false, "FAC 2 X_REG(1)", new String[] { "JSR FACXREG" }, "LDY #>X_REG",
						"LDX #<X_REG", "JSR FACMEM"));
				this.add(new Pattern(false, "FAC 2 Y_REG(1)", new String[] { "JSR FACYREG" }, "LDY #>Y_REG",
						"LDX #<Y_REG", "JSR FACMEM"));

				this.add(new Pattern(false, "FAC 2 X_REG(2)", new String[] { "JSR FACXREG" }, "LDX #<X_REG",
						"LDY #>X_REG", "JSR FACMEM"));
				this.add(new Pattern(false, "FAC 2 Y_REG(2)", new String[] { "JSR FACYREG" }, "LDX #<Y_REG",
						"LDY #>Y_REG", "JSR FACMEM"));

				this.add(new Pattern(false, "X_REG 2 FAC(1)", new String[] { "JSR XREGFAC" }, "LDA #<X_REG",
						"LDY #>X_REG", "JSR REALFAC"));
				this.add(new Pattern(false, "X_REG 2 FAC(2)", new String[] { "JSR XREGFAC" }, "TXA", "LDY #>X_REG",
						"JSR REALFAC"));
				this.add(new Pattern(false, "Y_REG 2 FAC(1)", new String[] { "JSR YREGFAC" }, "LDA #<Y_REG",
						"LDY #>Y_REG", "JSR REALFAC"));

				this.add(new Pattern(false, "X_REG 2 ARG", new String[] { "JSR XREGARG" }, "LDA #<X_REG", "LDY #>X_REG",
						"JSR MEMARG"));

				this.add(new Pattern(false, "MEM 2 X_REG", new String[] { "{LINE0}", "{LINE1}", "JSR COPY2_XYA_XREG" },
						"LDA #<{MEM0}", "LDY #>{MEM0}", "STY TMP3_ZP+1", "LDX #<X_REG", "LDY #>X_REG",
						"JSR COPY2_XYA"));
				this.add(new Pattern(false, "MEM 2 Y_REG", new String[] { "{LINE0}", "{LINE1}", "JSR COPY2_XYA_YREG" },
						"LDA #<{MEM0}", "LDY #>{MEM0}", "STY TMP3_ZP+1", "LDX #<Y_REG", "LDY #>Y_REG",
						"JSR COPY2_XYA"));

				this.add(new Pattern(false, "Faster PEEKBYTEAND", new String[] { "JSR PEEKBYTEANDFAST", "{LINE3}" },
						"JSR PEEKBYTEAND", "JSR XREGFAC", "JSR FACWORD", "STY {*}"));
				this.add(new Pattern(false, "Faster PEEKBYTEOR", new String[] { "JSR PEEKBYTEORFAST", "{LINE3}" },
						"JSR PEEKBYTEOR", "JSR XREGFAC", "JSR FACWORD", "STY {*}"));

				this.add(new Pattern(false, "Shorter SHL", new String[] { "{LINE0}", "{LINE2}", "{LINE4}", "{LINE5}" },
						"LDY {*}", "LDA {*}", "STY A_REG", "STA A_REG+1", "JSR XREGFAC", "JSR SHL"));

				this.add(new Pattern(false, "Shorter SHR", new String[] { "{LINE0}", "{LINE2}", "{LINE4}", "{LINE5}" },
						"LDY {*}", "LDA {*}", "STY A_REG", "STA A_REG+1", "JSR XREGFAC", "JSR SHR"));

				this.add(new Pattern(false, "Faster PEEKBYTEADDAND",
						new String[] { "JSR PEEKBYTEADDANDFAST", "{LINE1}", "{LINE2}", "{LINE3}", "{LINE4}",
								"LDY A_REG", "{LINE7}", "{LINE8}" },
						"JSR PEEKBYTEADDAND", "JSR POPREAL", "JSR FACWORD", "STY MOVBSELF1+1", "STA MOVBSELF1+2",
						"JSR XREGFAC", "JSR FACWORD", "{LABEL}", "STY $FFFF"));

				this.add(new Pattern(false, "Faster PEEKBYTEADDOR",
						new String[] { "JSR PEEKBYTEADDORFAST", "{LINE1}", "{LINE2}", "{LINE3}", "{LINE4}", "LDY A_REG",
								"{LINE7}", "{LINE8}" },
						"JSR PEEKBYTEADDOR", "JSR POPREAL", "JSR FACWORD", "STY MOVBSELF1+1", "STA MOVBSELF1+2",
						"JSR XREGFAC", "JSR FACWORD", "{LABEL}", "STY $FFFF"));

				this.add(new Pattern(true, "Faster POKE,PEEK", new String[] { "{LINE0}", "{LINE4}" }, "LDY {MEM1}",
						"LDA #0", "JSR INTFAC", "JSR FACWORD", "STY {MEM2}"));

				this.add(new Pattern(true, "Faster setting to 1", new String[] { "JSR ONETOFAC" }, "LDA #<{#1.0}",
						"LDY #>{#1.0}", "JSR REALFAC"));

				// The following two optimizations trigger very seldom. But when they do, they
				// can improve performance up to 10% for these cases.
				this.add(new Pattern(false, "Avoid PUSH/POP(2)",
						new String[] { "{LINE3}", "{LINE4}", "{LINE5}", "{LINE6}", "JSR XREGARG", "{LINE0}", "{LINE1}",
								"JSR REALFAC" },
						"LDA #<{MEM1}", "LDY #>{MEM1}", "JSR REALFACPUSH", "LDY {*}", "LDA #0", "JSR INTFAC",
						"JSR FACXREG", "JSR POPREAL2X"));

				this.add(new Pattern(false, "Avoid PUSH/POP(3)",
						new String[] { "{LINE3}", "{LINE4}", "{LINE5}", "{LINE6}", "JSR XREGARG", "{LINE0}", "{LINE1}",
								"JSR REALFAC" },
						"LDA #<Y_REG", "LDY #>Y_REG", "JSR REALFACPUSH", "LDY {*}", "LDA #0", "JSR INTFAC",
						"JSR FACXREG", "JSR POPREAL2X"));

				// This optimizes a special case, which happens in my affine texture mapper
				// quite a lot but maybe not much elsewhere...
				this.add(new Pattern(true, "Omit XREG->FAC", new String[] { "{LINE0}", "{LINE1}", "{LINE2}" },
						"JSR FACXREG", "LDY {*}", "STY {*}", "JSR XREGFAC"));

				this.add(new Pattern(true, "Combine copy and real par", new String[] { "JSR COPY2_XREG_REALPAR" },
						"JSR COPY2_XYA_XREG", "JSR COPYREALPAR"));

				this.add(new Pattern(true, "Combine copy and add colon", new String[] { "JSR COPY_AND_ADDCOLON" },
						"JSR COPY2_XREG_REALPAR", "JSR ADDCOLON"));

				this.add(new Pattern(true, "Combine dynamic sys call and pull down",
						new String[] { "JSR SYS_AND_PULLDOWN" }, "JSR COPY2_XYA_XREG", "JSR SYSTEMCALLDYN",
						"JSR PULLDOWNMULTIPARS"));

				this.add(new Pattern(true, "Combine static sys call and pull down",
						new String[] { "JSR SYS_AND_PULLDOWN_SIMPLE" }, "JSR SYSTEMCALL", "JSR PULLDOWNMULTIPARS"));

				this.add(new Pattern("Direct copy from X to Y", new String[] { "JSR COPY_XREG2YREG" }, "LDA #<X_REG",
						"LDY #>X_REG", "STY TMP3_ZP+1", "LDX #<Y_REG", "LDY #>Y_REG", "JSR COPY2_XYA"));

				// This conflicted with the "already in X optimization". See COPY2_XYA_CREG for
				// a dirty fix...
				this.add(new Pattern(true, "Direct copy from MEM to C",
						new String[] { "{LINE0}", "{LINE1}", "JSR COPY2_XYA_CREG" }, "LDA #<{MEM0}", "LDY #>{MEM0}",
						"STY TMP3_ZP+1", "LDX #<C_REG", "LDY #>C_REG", "JSR COPY2_XYA"));

				this.add(new Pattern(true, "Value already in FAC(1)",
						new String[] { "{LINE0}", "{LINE1}", "{LINE2}", "{LINE3}", "{LINE4}",
								"JSR ARRAYSTORE_INTEGER_NX" },
						"JSR FACXREG", "LDA #<{MEM0}", "LDY #>{MEM0}", "STA G_REG", "STY G_REG+1",
						"JSR ARRAYSTORE_INTEGER"));

				this.add(new Pattern(true, "Value already in FAC(2)",
						new String[] { "{LINE0}", "{LINE1}", "{LINE2}", "JSR ARRAYACCESS_INTEGER_SNX" }, "JSR FACXREG",
						"LDA #<{MEM0}", "LDY #>{MEM0}", "JSR ARRAYACCESS_INTEGER_S"));

				this.add(new Pattern(true, "POP and XREG combined", new String[] { "JSR POPREALXREG" }, "JSR POPREAL",
						"JSR FACXREG"));

				// Avoid int conversions...
				this.add(new Pattern(false, "Avoid multiple int conversions",
						new String[] { "{LINE0}", "{LINE1}", "{LINE2}", "{LINE3}", "{LINE4}" }, "STY {MEM0}",
						"STA {MEM0}", "NOP", "JSR INTFAC", "JSR PUSHREAL", "LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC"));

				// Note: This ignores the fact that the variable might be negative. Instead of
				// throwing an error, this will just
				// POKE nonsense, but that shouldn't really matter too much...
				this.add(new Pattern(false, "Remove INTFAC/FACWORD", new String[] { "{LINE0}", "{LINE4}" },
						"LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "JSR FACWORD", "STY {*}"));

				this.add(new Pattern(false, "Memory saving single char out(1)",
						new String[] { "{LINE1}", "JSR SINGLECHROUTMAX" }, "JSR COMPACTMAX", "LDA {*}",
						"JSR SINGLECHROUT"));

				this.add(new Pattern(false, "Memory saving single char out(2)",
						new String[] { "{LINE1}", "JSR SINGLECHROUTBRKMAX" }, "JSR COMPACTMAX", "LDA {*}",
						"JSR SINGLECHROUTBRK"));

				this.add(new Pattern(false, "LEN to integer variable",
						new String[] { "{LINE0}", "LDA #0", "LDY TMP2_ZP", "{LINE3}", "{LINE4}" }, "JSR LEN",
						"JSR XREGFAC", "JSR FACINT", "STY {MEM0}", "STA {MEM0}"));

				this.add(new Pattern(false, "ASC to integer variable",
						new String[] { "{LINE0}", "LDA #0", "LDY TMP2_ZP", "{LINE3}", "{LINE4}" }, "JSR ASC",
						"JSR XREGFAC", "JSR FACINT", "STY {MEM0}", "STA {MEM0}"));

				/*
				 * this.add(new Pattern(true, "Simplified string array assignment", new String[]
				 * { "{LINE3}", "{LINE4}", "{LINE5}", "{LINE6}", "{LINE0}", "{LINE1}",
				 * "JSR COPY2_XYA_XREG" }, "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR REALFACPUSH",
				 * "LDA #<{MEM1}", "LDY #>{MEM1}", "STA A_REG", "STY A_REG+1",
				 * "JSR POPREALXREG"));
				 */

				this.add(new Pattern(false, "Simplified string array assignment",
						new String[] { "{LINE4}", "{LINE5}", "{LINE6}", "{LINE7}", "{LINE0}", "{LINE1}",
								"JSR COPY2_XYA_XREG" },
						"LDA #<{MEM0}", "LDY #>{MEM0}", "JSR REALFACPUSH", "NOP", "LDA #<{MEM1}", "LDY #>{MEM1}",
						"STA A_REG", "STY A_REG+1", "JSR POPREALXREG"));

				this.add(new Pattern(false, "Simplified POPINT", new String[] { "JSR POPINT2B" }, "JSR POPINT",
						"LDY TMP_ZP", "LDA TMP_ZP+1", "STY B_REG", "STA B_REG+1"));

				this.add(new Pattern(false, "No need for INT(1)", new String[] { "JSR FASTAND" }, "JSR FASTAND",
						"JSR BASINT"));
				
				this.add(new Pattern(false, "No need for INT(2)", new String[] { "JSR FASTOR" }, "JSR FASTOR",
						"JSR BASINT"));
				
				this.add(new Pattern(false, "No need for INT(3)", new String[] { "JSR FACINT" }, "JSR BASINT",
						"JSR FACINT"));
			}
		};
	}
}
