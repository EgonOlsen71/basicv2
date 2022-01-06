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
import com.sixtyfour.util.PatternProcessor;

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
		// if (true) return input;
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
				new String[] { "LDA #<{CONST0}", "LDY #>{CONST0}", "JSR COPY2_XYA_XREG", "LDY {*}", "LDA {*}",
						"STY AS_TMP", "STA AS_TMP+1", "LDA #<{MEM0}", "LDY #>{MEM0}", "STA G_REG", "STY G_REG+1",
						"JSR ARRAYSTORE_INT_INTEGER" },
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

		// f%(l%)=f%(r%)...still semi-optimal, because the intermediate result is stored
		// as float, but anyway...
		intPatterns.add(new IntPattern(true, "Optimized code for copying from int-array to int-array(1)",
				new String[] { "LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "JSR PUSHREAL", "NOP", "LDA #<{MEM1}",
						"LDY #>{MEM1}", "STA G_REG", "STY G_REG+1", "LDY {MEM2}", "LDA {MEM2}",
						"JSR ARRAYACCESS_INTEGER_INT", "JSR COPY_XREG2YREG", "JSR POPREALXREG", "LDA #<{MEM1}",
						"LDY #>{MEM1}", "STA G_REG", "STY G_REG+1", "JSR ARRAYSTORE_INTEGER_NX" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String vary = cleaned.get(0);
						if (vary.contains("%")) {
							List<String> rep = new ArrayList<>();
							rep.add(cleaned.get(5));
							rep.add(cleaned.get(6));
							rep.add(cleaned.get(7));
							rep.add(cleaned.get(8));
							rep.add(cleaned.get(9));
							rep.add(cleaned.get(10));
							rep.add(cleaned.get(11));
							rep.add(cleaned.get(12));
							rep.add(cleaned.get(14));
							rep.add(cleaned.get(15));
							rep.add(cleaned.get(16));
							rep.add(cleaned.get(17));
							rep.add(cleaned.get(0));
							rep.add(cleaned.get(1));
							rep.add("JSR ARRAYSTORE_INTEGER_INT");
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));

		// f%(l%+1)=f%(r%)...still semi-optimal, because the intermediate result is
		// stored as float, but anyway. This is quite a special case, but anyway...
		intPatterns.add(new IntPattern(true, "Optimized code for copying from int-array to int-array(2)",
				new String[] { "LDY {MEM0}", "LDA {MEM0}", "JSR FIINX", "LDA #<X_REG", "LDY #>X_REG", "JSR REALFACPUSH",
						"NOP", "LDA #<{MEM1}", "LDY #>{MEM1}", "STA G_REG", "STY G_REG+1", "LDY {MEM2}", "LDA {MEM2}",
						"JSR ARRAYACCESS_INTEGER_INT", "JSR COPY_XREG2YREG", "JSR POPREALXREG", "LDA #<{MEM1}",
						"LDY #>{MEM1}", "STA G_REG", "STY G_REG+1", "JSR ARRAYSTORE_INTEGER_NX" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String vary = cleaned.get(0);
						if (vary.contains("%")) {
							List<String> rep = new ArrayList<>();
							rep.add(cleaned.get(7));
							rep.add(cleaned.get(8));
							rep.add(cleaned.get(9));
							rep.add(cleaned.get(10));
							rep.add(cleaned.get(11));
							rep.add(cleaned.get(12));
							rep.add(cleaned.get(13));
							rep.add(cleaned.get(14));
							rep.add(cleaned.get(16));
							rep.add(cleaned.get(17));
							rep.add(cleaned.get(18));
							rep.add(cleaned.get(19));
							rep.add(cleaned.get(0));
							rep.add(cleaned.get(1));
							rep.add("JSR SUPERFIINX");
							rep.add("JSR ARRAYSTORE_INTEGER_INT");
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
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

		List<Pattern> others = new PatternProcessor().getPatterns("optimizer6502x.txt");
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

	public List<Pattern> getPatterns() {
		return new PatternProcessor().getPatterns("optimizer6502.txt");
	}
}
