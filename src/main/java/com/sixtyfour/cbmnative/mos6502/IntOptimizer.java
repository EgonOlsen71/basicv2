package com.sixtyfour.cbmnative.mos6502;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.Util;
import com.sixtyfour.config.CompilerConfig;

/**
 * Bundles Integer optimizations, because they look quite messy...
 * 
 * @author EgonOlsen
 *
 */
public class IntOptimizer {

	public List<String> applyIntOptimizations(CompilerConfig conf, PlatformProvider platform, List<String> input,
			int[] startAndEnd) {

		//input.forEach(System.out::println);
		
		Map<String, Number> const2Value = extractConstants(input);
		Map<String, String> strConst2Value = extractStringConstants(input);
		int[] ps = startAndEnd;
		int codeStart = ps[0];
		int codeEnd = ps[1];
		List<IntPattern> intPatterns = new ArrayList<>();
		
		// A very special case for ASC*256...because ASC is save to be >0 and <256
		intPatterns.add(new IntPattern(true, "Optimized ASC*256",
				new String[] { "JSR ASC","LDY {CONST0}","STY A_REG","JSR XREGFAC","JSR SHL","JSR {*}" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String consty = cleaned.get(1);
						consty = consty.substring(consty.indexOf(" ") + 1).trim();
						Number num = const2Value.get(consty);
						if (num.doubleValue() == 8d && (cleaned.get(5).endsWith("FACXREG") ||  cleaned.get(5).endsWith("FACYREG"))) {
							List<String> rep = new ArrayList<>();
							rep.add(cleaned.get(0)+"NXREG");
							rep.add("LDY #0");
							rep.add("LDA TMP2_ZP");
							rep.add("JSR INTFAC");
							rep.add(cleaned.get(5));
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));
		
		// faster, constant array access...not really an int optimization in itself, but still...somehow it is...
		intPatterns.add(new IntPattern(true, "Optimized code for constant array access",
				new String[] { "LDA #<{MEM0}", "LDY #>{MEM0}", "STA G_REG", "STY G_REG+1", "LDY {CONST0}", "LDA {CONST0}",
						"JSR {*}" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String consty = cleaned.get(4);
						String jumpy = cleaned.get(6);
						if (jumpy.endsWith("ARRAYACCESS_REAL_INT") || jumpy.endsWith("ARRAYACCESS_INTEGER_INT")) {
							try {
								consty = consty.substring(consty.indexOf(" ") + 1).trim();
								int iNum = const2Value.get(consty).intValue();
								iNum*=jumpy.endsWith("ARRAYACCESS_INTEGER_INT")?2:5;
								List<String> rep = new ArrayList<>();
								rep.add(cleaned.get(0)+"+"+iNum);
								rep.add(cleaned.get(1)+"+"+iNum);
								rep.add(cleaned.get(2));
								rep.add(cleaned.get(3));
								rep.add(cleaned.get(6)+"_PRE");
								return combine(pattern, rep);
							} catch(Exception e) {
								// Just in case...
							}
						}
						pattern.reset();
						return input;
					}
				}));
		
		
		// intvar+<const> - Variant 1
		intPatterns.add(new IntPattern(true, "Optimized code for adding INTs (1)",
				new String[] { "LDA #<{CONST0}", "LDY #>{CONST0}", "JSR COPY2_XYA_YREG", "LDY {*}", "LDA {*}",
						"JSR INTFAC", "JSR FACXREG", "JSR YREGFAC", "LDA #<X_REG", "LDY #>X_REG", "JSR FASTFADDMEM" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String consty = cleaned.get(0);
						consty = consty.substring(consty.indexOf("<") + 1).trim();
						Number num = const2Value.get(consty);
						double numd = num.doubleValue();
						if (numd == (int) numd && numd >= 0 && numd <= 16383) {
							String numHex = getHex(numd);
							List<String> rep = new ArrayList<>();
							rep.add("LDY #$" + numHex.substring(0, 2));
							rep.add("LDA #$" + numHex.substring(2));
							rep.add("STA TMP3_ZP");
							rep.add("STY TMP3_ZP+1");
							rep.add(cleaned.get(3));
							rep.add(cleaned.get(4));
							rep.add("JSR INTADD");
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));

		// intvar+<const> - Variant 2
		intPatterns.add(new IntPattern(true, "Optimized code for adding INTs (2)",
				new String[] { "LDY {*}", "LDA {*}", "JSR INTFAC", "LDA #<{CONST0}", "LDY #>{CONST0}",
						"JSR COPY2_XYA_XREG", "LDA #<X_REG", "LDY #>X_REG", "JSR FASTFADDMEM" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String consty = cleaned.get(3);
						consty = consty.substring(consty.indexOf("<") + 1).trim();
						Number num = const2Value.get(consty);
						double numd = num.doubleValue();
						if (numd == (int) numd && numd >= 0 && numd <= 16383) {
							String numHex = getHex(numd);
							List<String> rep = new ArrayList<>();
							rep.add("LDY #$" + numHex.substring(0, 2));
							rep.add("LDA #$" + numHex.substring(2));
							rep.add("STA TMP3_ZP");
							rep.add("STY TMP3_ZP+1");
							rep.add(cleaned.get(0));
							rep.add(cleaned.get(1));
							rep.add("JSR INTADD");
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));
		
		// intvar+<const> - Variant 3
		intPatterns.add(new IntPattern(true, "Optimized code for adding INTs (3)",
				new String[] { "JSR INTFAC", "JSR FACXREG", "LDA #<{CONST0}", "LDY #>{CONST0}",
						"JSR REALFAC", "LDA #<X_REG", "LDY #>X_REG", "JSR FASTFADDMEM", "JSR FACINT" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String consty = cleaned.get(2);
						consty = consty.substring(consty.indexOf("<") + 1).trim();
						Number num = const2Value.get(consty);
						double numd = num.doubleValue();
						if (numd == (int) numd && numd >= 0 && numd <= 16383) {
							String numHex = getHex(numd);
							List<String> rep = new ArrayList<>();
							rep.add("LDX #$" + numHex.substring(0, 2));
							rep.add("STX TMP3_ZP+1");
							rep.add("LDX #$" + numHex.substring(2));
							rep.add("STX TMP3_ZP");
							rep.add("JSR INTADDOPT");
							rep.add("JSR INTCONV");
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));
		
		// intvar-<const> - Variant 1
		intPatterns.add(new IntPattern(true, "Optimized code for subtracting INTs (1)",
				new String[] { "LDA #<{CONST0}", "LDY #>{CONST0}", "JSR COPY2_XYA_YREG", "LDY {*}", "LDA {*}", "JSR INTFAC", "JSR FACXREG", "JSR YREGFAC", "LDA #<X_REG", "LDY #>X_REG", "JSR FASTFSUBMEM" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String consty = cleaned.get(0);
						consty = consty.substring(consty.indexOf("<") + 1).trim();
						Number num = const2Value.get(consty);
						double numd = num.doubleValue();
						if (numd == (int) numd && numd >= 0) {
							String numHex = getHex(numd);
							List<String> rep = new ArrayList<>();
							rep.add("LDY #$" + numHex.substring(0, 2));
							rep.add("LDA #$" + numHex.substring(2));
							rep.add("STA TMP3_ZP");
							rep.add("STY TMP3_ZP+1");
							rep.add(cleaned.get(3));
							rep.add(cleaned.get(4));
							rep.add("JSR INTSUB");
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));

		// intvar+-intvar
		intPatterns.add(new IntPattern(true, "Optimized code for adding/subtracting INT variables",
				new String[] { "LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "JSR FACYREG", "LDY {MEM1}", "LDA {MEM1}",
						"JSR INTFAC", "JSR FACXREG", "JSR YREGFAC", "LDA #<X_REG", "LDY #>X_REG", "JSR FAST{*}" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String func = cleaned.get(11);
						if (func.contains("FASTFADDMEM") || func.contains("FASTFSUBMEM")) {
							List<String> rep = new ArrayList<>();
							rep.add(cleaned.get(4));
							rep.add(cleaned.get(5));
							rep.add("STY TMP3_ZP");
							rep.add("STA TMP3_ZP+1");
							rep.add(cleaned.get(0));
							rep.add(cleaned.get(1));
							if (func.contains("FASTFADDMEM")) {
								rep.add("JSR INTADDVAR");
							} else {
								rep.add("JSR INTSUBVAR");
							}
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));
		
		// Optimized ICMP
		intPatterns.add(new IntPattern(true, "Optimized ICMP",
				new String[] { "STY TMP2_ZP", "STA TMP2_ZP+1", "LDY {*}", "LDA {*}",
						"STY TMP_ZP", "STA TMP_ZP+1", "LDY TMP2_ZP", "LDA TMP2_ZP+1", "JSR ICMP" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						List<String> rep = new ArrayList<>();
						rep.add(cleaned.get(2).replace("LDY", "LDX"));
						rep.add("STX TMP_ZP");
						rep.add(cleaned.get(3).replace("LDA", "LDX"));
						rep.add("STX TMP_ZP+1");
						rep.add(cleaned.get(8));
						return combine(pattern, rep);
					}
				}));
		
		// int+int into int
		intPatterns.add(new IntPattern(true, "Optimized code for adding/subtracting ints and store in int",
				new String[] { "LDY {*}", "LDA {*}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDY {*}", "LDA {*}",
						"JSR {*}", "JSR FACINT", "STY {*}", "STA {*}" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String func2 = cleaned.get(6);
						String func = cleaned.get(8);
						if (func.contains("%") && (func2.contains("INTADD") || func2.contains("INTSUB"))) {
							List<String> rep = new ArrayList<>();
							rep.add(cleaned.get(0));
							rep.add(cleaned.get(1));
							rep.add("STY TMP4_REG+1");
							rep.add("STA TMP4_REG");
							rep.add(cleaned.get(4));
							rep.add(cleaned.get(5));
							rep.add(func2+"16X");
							rep.add(cleaned.get(8));
							rep.add(cleaned.get(9));
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));
		
		
		/*
		// Actually slower in my test case...!?
		// intvarArray+-intvar
		intPatterns.add(new IntPattern(true, "Optimized code for adding/subtracting INT variables from array",
				new String[] { "JSR ARRAYACCESS_INTEGER_INT", "LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "LDA #<X_REG", "LDY #>X_REG", "JSR FAST{*}" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String func = cleaned.get(6);
						if (func.contains("FASTFADDMEM") || func.contains("FASTFSUBMEM")) {
							List<String> rep = new ArrayList<>();
							rep.add(cleaned.get(0));
							rep.add("LDY TMP2_ZP");
							rep.add("LDA TMP2_ZP+1");
							rep.add("STY TMP3_ZP");
							rep.add("STA TMP3_ZP+1");
							rep.add(cleaned.get(1));
							rep.add(cleaned.get(2));
							if (func.contains("FASTFADDMEM")) {
								rep.add("JSR INTADDVAR");
							} else {
								rep.add("JSR INTSUBVAR");
							}
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));
		*/
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

		// if peek(56233)=s% etc.
		intPatterns.add(new IntPattern(true, "Optimized code for Integer(xx)",
				new String[] { "LDY {*}", "LDA {*}", "JSR INTFAC", "JSR PUSHREAL", "LDY {*}", "LDA {*}", "JSR INTFAC",
						"JSR FACXREG", "JSR POPREAL", "JSR FACYREG", "LDA #<X_REG", "LDY #>X_REG", "JSR CMPFAC" },
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
		
		
		// if 123=l%(xx) etc.
		intPatterns.add(new IntPattern(true, "Optimized code for Integer(5)",
				new String[] { "JSR {*}","JSR COPY_XREG2YREG","LDA #<{CONST0}", "LDY #>{CONST0}", "JSR COPY2_XYA_XREG", "JSR YREGFAC", "LDA #<X_REG", "LDY #>X_REG", "JSR CMPFAC" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String jumpy = cleaned.get(0);
						if (jumpy.endsWith("ARRAYACCESS_INTEGER_S") || jumpy.endsWith("ARRAYACCESS_INTEGER_INT")) {
							String consty = cleaned.get(2);
							consty = consty.substring(consty.indexOf("<") + 1).trim();
							Number num = const2Value.get(consty);
							double numd = num.doubleValue();
							if (numd == (int) numd && numd >= -32768 && numd < 32768) {
								String numHex = getHex(numd);
								List<String> rep = new ArrayList<>();
								rep.add(cleaned.get(0));
								rep.add("LDY TMP2_ZP");
								rep.add("STY TMP_ZP");
								rep.add("LDA TMP2_ZP+1");
								rep.add("STA TMP_ZP+1");
								rep.add("LDY #$" + numHex.substring(2));
								rep.add("LDA #$" + numHex.substring(0, 2));
								rep.add("JSR ICMP");
								return combine(pattern, rep);
							}
						}
						pattern.reset();
						return input;
					}
				}));
		
		// if l%(xx)=1 etc....which is a sepcial case because of some former optimization earlier in the pipeline
		intPatterns.add(new IntPattern(true, "Optimized code for Integer(6)",
				new String[] { "JSR {*}","JSR ONETOFAC", "LDA #<X_REG", "LDY #>X_REG", "JSR CMPFAC" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String jumpy = cleaned.get(0);
						if (jumpy.endsWith("ARRAYACCESS_INTEGER_S") || jumpy.endsWith("ARRAYACCESS_INTEGER_INT")) {
							List<String> rep = new ArrayList<>();
							rep.add(cleaned.get(0));
							rep.add("LDA #$01");
							rep.add("LDY #$00");
							rep.add("STA TMP_ZP");
							rep.add("STY TMP_ZP+1");
							rep.add("LDY TMP2_ZP");
							rep.add("LDA TMP2_ZP+1");
							rep.add("JSR ICMP");
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));
		
		
		// if l%(xx)=123 etc.
		intPatterns.add(new IntPattern(true, "Optimized code for Integer(4)",
				new String[] { "JSR {*}","LDA #<{CONST0}", "LDY #>{CONST0}", "JSR REALFAC", "LDA #<X_REG", "LDY #>X_REG", "JSR CMPFAC" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String jumpy = cleaned.get(0);
						if (jumpy.endsWith("ARRAYACCESS_INTEGER_S") || jumpy.endsWith("ARRAYACCESS_INTEGER_INT")) {
							String consty = cleaned.get(1);
							consty = consty.substring(consty.indexOf("<") + 1).trim();
							Number num = const2Value.get(consty);
							double numd = num.doubleValue();
							if (numd == (int) numd && numd >= -32768 && numd < 32768) {
								String numHex = getHex(numd);
								List<String> rep = new ArrayList<>();
								rep.add(cleaned.get(0));
								rep.add("LDA #$" + numHex.substring(2));
								rep.add("LDY #$" + numHex.substring(0, 2));
								rep.add("STA TMP_ZP");
								rep.add("STY TMP_ZP+1");
								rep.add("LDY TMP2_ZP");
								rep.add("LDA TMP2_ZP+1");
								rep.add("JSR ICMP");
								return combine(pattern, rep);
							}
						}
						pattern.reset();
						return input;
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
						"JSR COPY2_XYA_XREG", "JSR YREGFAC", "LDA #<X_REG", "LDY #>X_REG", "JSR CMPFAC" },
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
							rep.add("LDY #$" + numHex.substring(2));
							rep.add("LDA #$" + numHex.substring(0, 2));
							rep.add("JSR ICMP");
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));

		// if len(a$)=12 etc.
		intPatterns.add(new IntPattern(true, "Optimized code for LEN(1)",
				new String[] { "LDA #<{CONST0}", "LDY #>{CONST0}", "JSR REALFACPUSH", "LDA {*}", "LDY {*}", "STA B_REG",
						"STY B_REG+1", "JSR LEN", "JSR POPREAL", "JSR FACYREG", "LDA #<X_REG", "LDY #>X_REG",
						"JSR CMPFAC" },
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
							rep.add(cleaned.get(3));
							rep.add(cleaned.get(4));
							rep.add(cleaned.get(5));
							rep.add(cleaned.get(6));
							rep.add(cleaned.get(7));
							rep.add("LDA #$" + numHex.substring(2));
							rep.add("LDY #$" + numHex.substring(0, 2));
							rep.add("STA TMP_ZP");
							rep.add("STY TMP_ZP+1");
							rep.add("LDY TMP2_ZP");
							rep.add("LDA #0");
							rep.add("JSR ICMP");
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));

		// if 12=len(a$) etc.
		intPatterns.add(new IntPattern(true, "Optimized code for LEN(2)",
				new String[] { "LDA {*}", "LDY {*}", "STA B_REG", "STY B_REG+1", "JSR LEN", "JSR COPY_XREG2YREG",
						"LDA #<{CONST0}", "LDY #>{CONST0}", "JSR COPY2_XYA_XREG", "JSR YREGFAC", "LDA #<X_REG",
						"LDY #>X_REG", "JSR CMPFAC" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String consty = cleaned.get(6);
						consty = consty.substring(consty.indexOf("<") + 1).trim();
						Number num = const2Value.get(consty);
						double numd = num.doubleValue();
						if (numd == (int) numd && numd >= -32768 && numd < 32768) {
							String numHex = getHex(numd);
							List<String> rep = new ArrayList<>();
							rep.add(cleaned.get(0));
							rep.add(cleaned.get(1));
							rep.add(cleaned.get(2));
							rep.add(cleaned.get(3));
							rep.add(cleaned.get(4));
							rep.add("LDA TMP2_ZP");
							rep.add("STA TMP_ZP");
							rep.add("LDA #0");
							rep.add("STA TMP_ZP+1");
							rep.add("LDY #$" + numHex.substring(2));
							rep.add("LDA #$" + numHex.substring(0, 2));
							rep.add("JSR ICMP");
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));

		
		// if peek(..)=o% etc...
		intPatterns.add(new IntPattern(true, "Optimized code for PEEK/CMP(1)", new String[] { "JSR INTFAC", "JSR FACXREG",
				"LDY {*}", "LDA {*}", "JSR INTFAC", "LDA #<X_REG", "LDY #>X_REG", "JSR CMPFAC" }, new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						List<String> rep = new ArrayList<>();
						rep.add("STY TMP2_ZP");
						rep.add("STA TMP2_ZP+1");
						rep.add(cleaned.get(2));
						rep.add(cleaned.get(3));
						rep.add("STY TMP_ZP");
						rep.add("STA TMP_ZP+1");
						rep.add("LDY TMP2_ZP");
						rep.add("LDA TMP2_ZP+1");
						rep.add("JSR ICMP");
						return combine(pattern, rep);
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
		intPatterns.add(new IntPattern(true, "Optimized code for MID(1)",
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

		// mid$(a$,i,<const>)
		intPatterns.add(new IntPattern(true, "Optimized code for MID(2)",
				new String[] { "LDA #<{CONST0}", "LDY #>{CONST0}", "STY TMP3_ZP+1", "LDX #<D_REG", "LDY #>D_REG",
						"JSR COPY2_XYA", "JSR MID" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String consty = cleaned.get(0);
						consty = consty.substring(consty.indexOf("<") + 1).trim();
						Number num = const2Value.get(consty);
						int numd = num.intValue();
						List<String> rep = new ArrayList<>();
						if (numd >= 0) {
							if (numd > 255) {
								numd = 255;
							}
							rep.add("LDY #" + numd);
							rep.add("JSR MIDCONST");
						}
						return combine(pattern, rep);
					}
				}));
		
		// mid$(a$,i,<int>)
		intPatterns
				.add(new IntPattern(true, "Optimized code for MID (2)",
						new String[] { "LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "LDX #<D_REG", "LDY #>D_REG",
								"JSR FACMEM", "LDA {*}", "LDY {*}", "STA B_REG", "STY B_REG+1", "JSR MID" },
						new AbstractCodeModifier() {
							@Override
							public List<String> modify(IntPattern pattern, List<String> input) {
								input = super.modify(pattern, input);
								List<String> rep = new ArrayList<>();
								// While this isn't what the interpreter would do, it's bs anyway, so we handle
								// it like this...
								rep.add(cleaned.get(6));
								rep.add(cleaned.get(7));
								rep.add(cleaned.get(8));
								rep.add(cleaned.get(9));
								rep.add(cleaned.get(0));
								rep.add(cleaned.get(1));
								rep.add("JSR MIDCONSTA");
								return combine(pattern, rep);
							}
						}));

		// left$(a$,<const>)/right$(a$, <const>)
		intPatterns.add(new IntPattern(
				true, "Optimized code for LEFT/RIGHT", new String[] { "LDA #<{CONST0}", "LDY #>{CONST0}",
						"JSR COPY2_XYA_CREG", "LDA {*}", "LDY {*}", "STA B_REG", "STY B_REG+1", "JSR {*}" },
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
						String func = cleaned.get(7).replace("JSR", "").trim();
						if (numd <= 0 || (!func.equals("LEFT") && !func.equals("RIGHT"))) {
							pattern.reset();
							return input;
						} else {
							if (numd > 255) {
								numd = 255;
							}
							rep.add(cleaned.get(3));
							rep.add(cleaned.get(4));
							rep.add(cleaned.get(5));
							rep.add(cleaned.get(6));
							rep.add("LDY #" + numd);
							rep.add("JSR " + func + "CONST");
						}
						return combine(pattern, rep);
					}
				}));

		// left$(a$,<int>)/right$(a$, <int>)
		intPatterns
				.add(new IntPattern(true, "Optimized code for LEFT/RIGHT (2)",
						new String[] { "LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "LDX #<C_REG", "LDY #>C_REG",
								"JSR FACMEM", "LDA {*}", "LDY {*}", "STA B_REG", "STY B_REG+1", "JSR {*}" },
						new AbstractCodeModifier() {
							@Override
							public List<String> modify(IntPattern pattern, List<String> input) {
								input = super.modify(pattern, input);
								List<String> rep = new ArrayList<>();
								String func = cleaned.get(10).replace("JSR", "").trim();
								if (!func.equals("LEFT") && !func.equals("RIGHT")) {
									pattern.reset();
									return input;
								} else {
									rep.add(cleaned.get(6));
									rep.add(cleaned.get(7));
									rep.add(cleaned.get(8));
									rep.add(cleaned.get(9));
									rep.add(cleaned.get(0));
									rep.add(cleaned.get(1));
									rep.add("JSR " + func + "CONSTA");
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
							boolean firstLoad = true;
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
									if (firstLoad) {
										rep.add("LDX #" + block);
										firstLoad=false;
									} else {
										rep.add("INX");
									}
									rep.add("CPX TMP_ZP");
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
				new String[] { "LDA #<{CONST0}", "LDY #>{CONST0}", "JSR REALFAC", "JSR FACWORD", "STY {*}", "STA {*}", "{LABEL}", "LDA $FFFF" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String consty = cleaned.get(0);
						consty = consty.substring(consty.indexOf("<") + 1).trim();
						Number num = const2Value.get(consty);
						int numd = num.intValue();

						List<String> rep = new ArrayList<>();
						//rep.add("LDY #" + (numd & 0xff));
						//rep.add("LDA #" + ((numd & 0xff00) >> 8));
						//rep.add(cleaned.get(4));
						//rep.add(cleaned.get(5));
						rep.add("LDA $"+getHex(numd));
						return combine(pattern, rep);
					}
				}));

		// CONST into Y/A
		intPatterns
				.add(new IntPattern(
						true, "Optimized code for CONST into Y/A", new String[] { "LDA #<{CONST0}", "LDY #>{CONST0}",
								"JSR COPY2_XYA_YREG", "NOP", "JSR YREGFAC", "JSR FACWORD" },
						new AbstractCodeModifier() {
							@Override
							public List<String> modify(IntPattern pattern, List<String> input) {
								input = super.modify(pattern, input);
								String consty = cleaned.get(0);
								consty = consty.substring(consty.indexOf("<") + 1).trim();
								Number num = const2Value.get(consty);
								int numd = num.intValue();
								// Apply to constants only
								List<String> rep = new ArrayList<>();
								rep.add("LDY #" + (numd & 0xff));
								rep.add("LDA #" + ((numd & 0xff00) >> 8));
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
								if (jumpy.contains("PEEKBYTEAND") || jumpy.contains("PEEKBYTEOR")) {
									List<String> rep = new ArrayList<>();
									rep.add(cleaned.get(0)+"FAST");
									rep.add("STY A_REG");
									rep.add(cleaned.get(1));
									rep.add(cleaned.get(2));
									rep.add(cleaned.get(3));
									rep.add(cleaned.get(4));
									rep.add("LDY A_REG");
									rep.add(cleaned.get(7));
									rep.add(cleaned.get(8));
									return combine(pattern, rep);
								} else {
									if (jumpy.contains("PEEKBYTE")) {
										// Is this triggered?
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
								}
								pattern.reset();
								return input;
							}
						}));
		
		// C%=-<CONST> ... these aren't covered by the "normal" optimization for this, because that doesn't trigger for negative values.
		intPatterns.add(new IntPattern(true, "Optimized code for negative constants)",
				new String[] { "LDA #<{CONST0}", "LDY #>{CONST0}", "JSR REALFAC", "JSR FACINT", "STY {*}", "STA {*}" },
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


		// POKE I,PEEK(J%)...
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
		intPatterns.add(new IntPattern(true, "Optimized code for POKE of Integer values(1)",
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

		// POKE a%,b% - happens in the second pass
		intPatterns.add(new IntPattern(true, "Optimized code for POKE of Integer values(2)",
				new String[] { "LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "JSR FACYREG", "NOP", "LDA #<Y_REG", "LDY #>Y_REG",
						"JSR REALFACPUSH", "JSR POPREAL", "JSR FACWORD", "STY {*}",  "STA {*}"},
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String vary = cleaned.get(0);
						String store = cleaned.get(10);
						if (vary.contains("%") && store.contains("MOVBSELF")) {
							List<String> rep = new ArrayList<>();
							rep.add(cleaned.get(0));
							rep.add(cleaned.get(1));
							rep.add(cleaned.get(10));
							rep.add(cleaned.get(11));
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));
		
		// POKE k%,<*> with k% being calculated before
		intPatterns.add(new IntPattern(true, "Optimized code for POKE of Integer values(3)",
				new String[] { "JSR FACXREG", "JSR FACINT", "STY {*}",  "STA {*}", "JSR XREGFAC", "JSR FACWORD" , "STY {*}",  "STA {*}"},
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String vary = cleaned.get(2);
						String store = cleaned.get(6);
						if (vary.contains("%") && store.contains("MOVBSELF")) {
							List<String> rep = new ArrayList<>();
							rep.add(cleaned.get(1));
							rep.add(cleaned.get(2));
							rep.add(cleaned.get(3));
							rep.add(cleaned.get(6));
							rep.add(cleaned.get(7));
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
		
		// POKE CONST, CONST (calculated)
		intPatterns.add(new IntPattern(true, "Optimized code for POKE",
				new String[] { "LDA #<{CONST0}", "LDY #>{CONST0}", "JSR REALFAC", "JSR FACWORD", "STY {*}", "NOP"},
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
						rep.add(cleaned.get(4));
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
						// Avoid interference with another optimization that changes the underlying code unnoticed from this one...hacky...
						if (vary.contains("%") && !cleaned.get(9).contains("_PRE")) {
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
		// stored as float, but anyway. This is quite a special case anyway...
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
						// Avoid interference with another optimization that changes the underlying code unnoticed from this one...hacky...
						if (vary.contains("%") && !cleaned.get(11).contains("_PRE")) {
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

		// CHR$(X%+-CONST)...yes, that's quite a special and rare case...
		intPatterns.add(new IntPattern(true, "Optimized code CHR plus ADD/SUB",
				new String[] { "LDA #<{CONST0}", "LDY #>{CONST0}", "JSR COPY2_XYA_YREG", "LDY {MEM0}", "LDA {MEM0}",
						"JSR INTFAC", "JSR FACXREG", "JSR YREGFAC", "LDA #<X_REG", "LDY #>X_REG", "JSR {*}",
						"JSR FACYREG", "JSR CHR" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String consty = cleaned.get(0);
						String vary = cleaned.get(3);
						String calcy = cleaned.get(10);
						consty = consty.substring(consty.indexOf("<") + 1).trim();
						Number num = const2Value.get(consty);
						int numd = num.intValue();
						if (vary.contains("%") && (calcy.contains("SUBMEM") || calcy.contains("ADDMEM"))) {
							List<String> rep = new ArrayList<>();
							rep.add("LDA #" + (numd & 0xff));
							rep.add("STA TMP2_ZP");
							if (calcy.contains("SUBMEM")) {
								rep.add("LDA #0");
							} else {
								rep.add("LDA #1");
							}
							rep.add("STA TMP2_ZP+1");
							rep.add(cleaned.get(3));
							rep.add("JSR CHRINTCALC");
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));

		// p% and/or <const>0>
		intPatterns.add(new IntPattern(true, "Optimized code for AND/OR",
				new String[] { "LDA #<{CONST0}", "LDY #>{CONST0}", "JSR COPY2_XYA_YREG", "LDY {*}", "LDA {*}",
						"JSR INTFAC", "JSR FACXREG", "JSR YREGFAC", "JSR XREGARG", "JSR FAST{*}", "JSR {*}" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String consty = cleaned.get(0);
						consty = consty.substring(consty.indexOf("<") + 1).trim();
						Number num = const2Value.get(consty);
						double numd = num.doubleValue();
						boolean isFacInt = cleaned.get(10).contains("FACINT");
						boolean isXreg = cleaned.get(10).contains("FACXREG");
						if ((isFacInt || isXreg) && numd == (int) numd && numd >= -32767 && numd < 32768) {
							String op = cleaned.get(9).substring(8).replace("OR", "ORA");
							if (op.contains("ORA") || op.contains("AND")) {
								String numHex = getHex(numd);
								List<String> rep = new ArrayList<>();
								rep.add(cleaned.get(4));
								rep.add(op + " #$" + numHex.substring(0, 2));
								rep.add("TAX");
								rep.add(cleaned.get(3));
								rep.add("TYA");
								rep.add(op + " #$" + numHex.substring(2));
								rep.add("TAY");
								rep.add("TXA");
								if (isXreg) {
									rep.add("JSR INTFAC");
									rep.add("JSR BASINT"); // Actually, this isn't needed but it triggers the ON
															// GOTO-Optimization in the second pass
									rep.add("JSR FACXREG");
								}
								return combine(pattern, rep);
							}
						}
						pattern.reset();
						return input;
					}
				}));
		
		// p% and/or o%
		intPatterns.add(new IntPattern(true, "Optimized code for AND/OR(2)",
				new String[] { "LDY {*}", "LDA {*}", "JSR INTFAC", "JSR FACYREG", "LDY {*}", "LDA {*}",
						"JSR INTFAC", "JSR FACXREG", "JSR YREGFAC", "JSR XREGARG", "JSR FAST{*}", "JSR FACINT" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String op = cleaned.get(10).substring(8).replace("OR", "ORA");
						if (op.contains("ORA") || op.contains("AND")) {
							List<String> rep = new ArrayList<>();
							rep.add(cleaned.get(5));
							rep.add(op + " "+cleaned.get(1).replace("LDA ", ""));
							rep.add("TAX");
							rep.add(cleaned.get(4));
							rep.add("TYA");
							rep.add(op + " "+cleaned.get(0).replace("LDY ", ""));
							rep.add("TAY");
							rep.add("TXA");
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));

		// p and/or o% => (int)
		intPatterns.add(new IntPattern(true, "Optimized code for AND/OR(3)",
				new String[] { "LDA #<{CONST0}", "LDY #>{CONST0}", "JSR MEMARG", "JSR FAST{*}", "JSR FACWORD" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String op = cleaned.get(3).substring(8).replace("OR", "ORA");
						String consty = cleaned.get(0);
						consty = consty.substring(consty.indexOf("<") + 1).trim();
						Number num = const2Value.get(consty);
						double numd = num.doubleValue();
						if (numd == (int) numd && numd >= -32767 && numd < 32768) {
							if (op.contains("ORA") || op.contains("AND")) {
								String numHex = getHex(numd);
								List<String> rep = new ArrayList<>();
								rep.add("JSR FACINT");
								rep.add(op + " #$" + numHex.substring(0, 2));
								rep.add("TAX");
								rep.add("TYA");
								rep.add(op + " #$" + numHex.substring(2));
								rep.add("TAY");
								rep.add("TXA");
								return combine(pattern, rep);
							}
						}
						pattern.reset();
						return input;
					}
				}));
		
		
		// p%+1 and/or <const>0>
		intPatterns.add(new IntPattern(
				true, "Optimized code for +1 AND/OR", new String[] { "LDY {*}", "LDA {*}", "JSR FI{*}",
						"LDA #<{CONST0}", "LDY #>{CONST0}", "JSR REALFAC", "JSR XREGARG", "JSR FAST{*}", "JSR {*}" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String consty = cleaned.get(3);
						consty = consty.substring(consty.indexOf("<") + 1).trim();
						Number num = const2Value.get(consty);
						double numd = num.doubleValue();
						boolean isIncDec = cleaned.get(2).contains("FIINX") || cleaned.get(2).contains("FIDEX");
						boolean isFacInt = cleaned.get(8).contains("FACINT");
						boolean isXreg = cleaned.get(8).contains("FACXREG");
						if ((isFacInt || isXreg) && isIncDec && numd == (int) numd && numd >= -32767 && numd < 32768) {
							String op = cleaned.get(7).substring(8).replace("OR", "ORA");
							if (op.contains("ORA") || op.contains("AND")) {
								String numHex = getHex(numd);
								List<String> rep = new ArrayList<>();
								rep.add(cleaned.get(0));
								rep.add(cleaned.get(1));
								rep.add(cleaned.get(2).replace("JSR ", "JSR SUPER"));
								rep.add(op + " #$" + numHex.substring(0, 2));
								rep.add("TAX");
								rep.add("TYA");
								rep.add(op + " #$" + numHex.substring(2));
								rep.add("TAY");
								rep.add("TXA");
								if (isXreg) {
									rep.add("JSR INTFAC");
									rep.add("JSR BASINT"); // Actually, this isn't needed but it triggers the ON
															// GOTO-Optimization in the second pass
									rep.add("JSR FACXREG");
								}
								return combine(pattern, rep);
							}
						}
						pattern.reset();
						return input;
					}
				}));
		
		// faster integer print
		intPatterns.add(new IntPattern(true, "Fast integer print",
				new String[] { "LDY {*}", "LDA {*}", "JSR INTFAC", "JSR FACXREG", "JSR INTOUT{*}"},
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						List<String> rep = new ArrayList<>();
						rep.add(cleaned.get(0));
						rep.add("STY TMP_ZP");
						rep.add(cleaned.get(1));
						rep.add("STA TMP_ZP+1");
						rep.add(cleaned.get(4)+"FAST");
						return combine(pattern, rep);
						
					}
				}));
		
		// faster integer print of const
		intPatterns.add(new IntPattern(true, "Fast integer print (2)",
				new String[] { "LDA #<{CONST0}", "LDY #>{CONST0}", "JSR COPY2_XYA_XREG", "JSR INTOUT{*}"},
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String consty = cleaned.get(0);
						consty = consty.substring(consty.indexOf("<") + 1).trim();
						Number num = const2Value.get(consty);
						double numd = num.doubleValue();
						if (numd >= -32767 && numd < 32768) {
							List<String> rep = new ArrayList<>();
							String numHex = getHex(numd);
							rep.add("LDY #$" + numHex.substring(2));
							rep.add("STY TMP_ZP");
							rep.add("LDA #$" + numHex.substring(0, 2));
							rep.add("STA TMP_ZP+1");
							rep.add(cleaned.get(3)+"FAST");
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
						
					}
				}));
		
		// Value already in Y/A
		intPatterns.add(new IntPattern(true, "Value already in Y/A",
				new String[] { "STY {MEM0}","STA {MEM0}", "NOP", "LDY {MEM0}","LDA {MEM0}"},
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						List<String> rep = new ArrayList<>();
						rep.add(cleaned.get(0));
						rep.add(cleaned.get(1));
						return combine(pattern, rep);
					}
				}));
		
		
		// No need for back and forth conversion of ints...
		intPatterns.add(new IntPattern(true, "Optimized conversion of ints (1)",
				new String[] { "JSR INTADD", "JSR FACINT" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						List<String> rep = new ArrayList<>();
						rep.add(cleaned.get(0)+"OPT");
						rep.add("JSR INTCONV");
						return combine(pattern, rep);
					}
				}));
		
		// No need for back and forth conversion of ints...
		intPatterns.add(new IntPattern(true, "Optimized conversion of ints (2)",
				new String[] { "JSR INTSUB", "JSR FACINT" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						List<String> rep = new ArrayList<>();
						rep.add(cleaned.get(0)+"OPT");
						rep.add("JSR INTCONV");
						return combine(pattern, rep);
					}
				}));

		// Simplified NOT for ints
		intPatterns.add(new IntPattern(true, "Optimized NOT of int",
				new String[] { "JSR INTFAC", "JSR FACNOT" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						List<String> rep = new ArrayList<>();
						rep.add("EOR #$FF");
						rep.add("TAX");
						rep.add("TYA");
						rep.add("EOR #$FF");
						rep.add("TAY");
						rep.add("TXA");
						rep.add(cleaned.get(0));
						return combine(pattern, rep);
					}
				}));
		
		// Simplified POKE(X),PEEK(X)+1...a very special case, but fun to do anyway...
		intPatterns.add(new IntPattern(true, "Simplified POKE(X),PEEK(X)+1",
				new String[] { "LDA #<{CONST0}", "LDY #>{CONST0}", "JSR COPY2_XYA_YREG", "LDY {CONST1}", "LDA {CONST1}", "STY A_REG",
						"STA A_REG+1", "JSR PEEKBYTEADD", "JSR XREGFAC", "JSR FACWORD", "STY {*}"},
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String consty = cleaned.get(0);
						consty = consty.substring(consty.indexOf("<") + 1).trim();
						Number num = const2Value.get(consty);
						double numd = num.doubleValue();
						
						consty = cleaned.get(3);
						consty = consty.substring(consty.indexOf("LDY") + 4).trim();
						num = const2Value.get(consty);
						double numd3 = num.doubleValue();
						
						String consty2 = cleaned.get(10);
						consty2 = consty2.substring(consty2.indexOf("STY") + 4).trim();
						int numd2 = Integer.parseInt(consty2);
						if (numd == numd2 && numd3==1) {
							List<String> rep = new ArrayList<>();
							rep.add("INC "+numd2);
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));

		// Faster SHL/SHR for ints, like A%=A%/256
		intPatterns.add(new IntPattern(true, "Fast integer SHL/SHR",
				new String[] { "LDY {CONST0}", "LDA {CONST0}", "STY A_REG", "STA A_REG+1", "LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "JSR {*}", "JSR {*}"},
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String constL = cleaned.get(0);
						constL = constL.substring(constL.indexOf(" ") + 1).trim();
						Number num = const2Value.get(constL);
						double numL = num.doubleValue();
						String call = cleaned.get(7);
						String call2 = cleaned.get(8);
						if (call2.contains("FACINT")) {
							if (numL > 0 && (call.endsWith("SHR") || call.endsWith("SHL"))) {
								if (numL == (int) numL && numL  <= 16) {
									List<String> rep = new ArrayList<>();
									rep.add(cleaned.get(4));
									rep.add(cleaned.get(5));
									rep.add(cleaned.get(2));
									rep.add(cleaned.get(3));
									rep.add(cleaned.get(0));
									rep.add(call.replace("SHR", "INTSHR").replace("SHL", "INTSHL"));
									return combine(pattern, rep);
								}
							}
						}
						pattern.reset();
						return input;
						
					}
				}));
		
		
		intPatterns.add(new IntPattern(true, "Faster POKE of integers",
				new String[] { "JSR INTFAC", "JSR PUSHREAL", "JSR POPREAL", "JSR FACWORD", "STY {*}", "STA {*}" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						List<String> rep = new ArrayList<>();
						String poky = cleaned.get(4);
						if (poky.contains("MOVBSELF")) {
							rep.add(cleaned.get(4));
							rep.add(cleaned.get(5));
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));
		
		intPatterns.add(new IntPattern(true, "Faster POKE of float into int",
				new String[] { "LDY {*}", "LDA {*}", "JSR INTFAC", "JSR PUSHREAL", "LDA #<{*}", "LDY #>{*}", "JSR REALFAC", "JSR FACWORD", "STY {*}", "STA {*}", "JSR POPREAL", "JSR FACWORD", "STY {*}", "STA {*}" },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						List<String> rep = new ArrayList<>();
						String poky1 = cleaned.get(8);
						String poky2 = cleaned.get(12);
						if (poky1.contains("MOVBSELF") && poky2.contains("MOVBSELF")) {
							
							rep.add(cleaned.get(4));
							rep.add(cleaned.get(5));
							rep.add(cleaned.get(6));
							rep.add(cleaned.get(7));
							rep.add(cleaned.get(8));
							rep.add(cleaned.get(9));
							
							rep.add(cleaned.get(0));
							rep.add(cleaned.get(1));
							rep.add(cleaned.get(12));
							rep.add(cleaned.get(13));
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));

		
		intPatterns.add(new IntPattern(true, "Fast add/sub of integers",
				new String[] { "JSR INTFAC", "JSR FACXREG", "LDY {MEM0}", "LDA {MEM0}", "JSR INTFAC", "LDA #<X_REG", "LDY #>X_REG", "JSR {*}", "JSR FACINT"  },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						List<String> rep = new ArrayList<>();
						String call = cleaned.get(7);
						if (call.contains("FASTFSUBMEM") || call.contains("FASTFADDMEM")){
							rep.add(cleaned.get(2).replace("LDY", "LDX"));
							rep.add("STX TMP3_ZP");
							rep.add(cleaned.get(3).replace("LDA", "LDX"));
							rep.add("STX TMP3_ZP+1");
							rep.add(cleaned.get(7).replace("FASTF", "INT").replace("MEM", "")+"OPT");
							rep.add("JSR INTCONV");
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));
		
		intPatterns.add(new IntPattern(true, "Faster ON <int>+1",
				new String[] { "LDY {MEM0}", "LDA {MEM0}", "JSR FIINX", "JSR XREGFAC", "JSR FACWORD", "STY TMP_ZP", "{LABEL}"  },
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						List<String> rep = new ArrayList<>();
						String label = cleaned.get(6);
						if (label.startsWith("ON")){
							rep.add(cleaned.get(0));
							rep.add(cleaned.get(1));
							rep.add("JSR SUPERFIINX");
							rep.add(cleaned.get(5));
							rep.add(cleaned.get(6));
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
					}
				}));
		
		// peek(sm%+i%)
		intPatterns.add(new IntPattern(true, "Fast add for PEEK",
				new String[] { "LDY {*}", "LDA {*}", "STA TMP3_ZP", "STY TMP3_ZP+1", "LDY {*}", "LDA {*}", "JSR INTADD", "JSR FACWORD", "STY {*}","STA {*}", "{LABEL}"},
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						if (cleaned.get(8).contains("MOVBSELF")) {
							List<String> rep = new ArrayList<>();
							rep.add(cleaned.get(0));
							rep.add(cleaned.get(1));
							rep.add(cleaned.get(2).replace("TMP3_ZP", "TMP4_REG"));
							rep.add(cleaned.get(3).replace("TMP3_ZP", "TMP4_REG"));
							rep.add(cleaned.get(4));
							rep.add(cleaned.get(5));
							rep.add("JSR INTADD16X");
							rep.add(cleaned.get(8));
							rep.add(cleaned.get(9));
							rep.add(cleaned.get(10));
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
						
					}
				}));
		
		// poke(x%),peek(y%)
		intPatterns.add(new IntPattern(true, "POKE from PEEK",
				new String[] { "LDY {*}", "LDA {*}", "JSR INTFAC", "JSR PUSHREAL", "LDY {*}", "LDA {*}", "STY {*}", "STA {*}", "JSR POPREAL", "JSR FACWORD", "STY {*}", "STA {*}", "{LABEL}"},
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						if (cleaned.get(6).contains("MOVBSELF") && cleaned.get(10).contains("MOVBSELF")) {
							List<String> rep = new ArrayList<>();
							rep.add(cleaned.get(0));
							rep.add(cleaned.get(1));
							rep.add(cleaned.get(10));
							rep.add(cleaned.get(11));
							rep.add(cleaned.get(4));
							rep.add(cleaned.get(5));
							rep.add(cleaned.get(6));
							rep.add(cleaned.get(7));
							rep.add(cleaned.get(12));
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
						
					}
				}));
		
		// ADD VARs + STORE
		intPatterns.add(new IntPattern(true, "ADD VARs + STORE simplified",
				new String[] { "JSR INTADDVAR", "JSR FACINT"},
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						List<String> rep = new ArrayList<>();
						rep.add(cleaned.get(0)+"OPT");
						rep.add("JSR INTCONV");
						return combine(pattern, rep);
						
					}
				}));
		
		// SUB VARs + STORE
		intPatterns.add(new IntPattern(true, "SUB VARs + STORE simplified",
				new String[] { "JSR INTSUBVAR", "JSR FACINT"},
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						List<String> rep = new ArrayList<>();
						rep.add(cleaned.get(0)+"OPT");
						rep.add("JSR INTCONV");
						return combine(pattern, rep);
						
					}
				}));
		
		// POKE P+<CONST>,CONST
		intPatterns.add(new IntPattern(true, "Fast add for POKE(1)",
				new String[] { "LDA #<{CONST0}", "LDY #>{CONST0}", "JSR REALFAC", "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR FASTFADDMEM", "JSR FACWORD", "STY {*}", "STA {*}"},
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String consty = cleaned.get(0);
						consty = consty.substring(consty.indexOf("<") + 1).trim();
						Number num = const2Value.get(consty);
						double numd = num.doubleValue();
						if (numd >= 0 && numd < 65536 && numd==(int) numd && cleaned.get(7).contains("MOVBSELF")) {
							List<String> rep = new ArrayList<>();
							String numHex = getHex(numd);
							rep.add("LDY #$" + numHex.substring(2));
							rep.add("STY TMP_ZP");
							rep.add("LDA #$" + numHex.substring(0, 2));
							rep.add("STA TMP_ZP+1");
							rep.add(cleaned.get(3));
							rep.add(cleaned.get(4));
							rep.add("JSR INTADDPOKE");
							rep.add(cleaned.get(7));
							rep.add(cleaned.get(8));
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
						
					}
				}));
		
		intPatterns.add(new IntPattern(true, "Fast add for POKE(1.1)",
				new String[] { "LDA #<{CONST0}", "LDY #>{CONST0}", "JSR REALFAC", "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR FASTFADDMEM", "JSR PUSHREAL", "JSR POPREAL", "JSR FACWORD", "STY {*}", "STA {*}"},
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						String consty = cleaned.get(0);
						consty = consty.substring(consty.indexOf("<") + 1).trim();
						Number num = const2Value.get(consty);
						double numd = num.doubleValue();
						if (numd >= 0 && numd < 65536 && numd==(int) numd && cleaned.get(9).contains("MOVBSELF")) {
							List<String> rep = new ArrayList<>();
							String numHex = getHex(numd);
							rep.add("LDY #$" + numHex.substring(2));
							rep.add("STY TMP_ZP");
							rep.add("LDA #$" + numHex.substring(0, 2));
							rep.add("STA TMP_ZP+1");
							rep.add(cleaned.get(3));
							rep.add(cleaned.get(4));
							rep.add("JSR INTADDPOKE");
							rep.add(cleaned.get(9));
							rep.add(cleaned.get(10));
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
						
					}
				}));
		
		intPatterns.add(new IntPattern(true, "Fast add for POKE(2)",
				new String[] { "JSR ONETOFAC", "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR FASTFADDMEM", "JSR FACWORD", "STY {*}", "STA {*}"},
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						if (cleaned.get(5).contains("MOVBSELF")) {
							List<String> rep = new ArrayList<>();
							rep.add("LDY #$01");
							rep.add("STY TMP_ZP");
							rep.add("LDA #$00");
							rep.add("STA TMP_ZP+1");
							rep.add(cleaned.get(1));
							rep.add(cleaned.get(2));
							rep.add("JSR INTADDPOKE");
							rep.add(cleaned.get(5));
							rep.add(cleaned.get(6));
							return combine(pattern, rep);
						}
						pattern.reset();
						return input;
						
					}
				}));
		
		intPatterns.add(new IntPattern(true, "Fast add for POKE(2.1)",
				new String[] { "JSR ONETOFAC", "LDA #<{MEM0}", "LDY #>{MEM0}", "JSR FASTFADDMEM", "JSR PUSHREAL", "JSR POPREAL",  "JSR FACWORD", "STY {*}", "STA {*}"},
				new AbstractCodeModifier() {
					@Override
					public List<String> modify(IntPattern pattern, List<String> input) {
						input = super.modify(pattern, input);
						if (cleaned.get(7).contains("MOVBSELF")) {
							List<String> rep = new ArrayList<>();
							rep.add("LDY #$01");
							rep.add("STY TMP_ZP");
							rep.add("LDA #$00");
							rep.add("STA TMP_ZP+1");
							rep.add(cleaned.get(1));
							rep.add(cleaned.get(2));
							rep.add("JSR INTADDPOKE");
							rep.add(cleaned.get(7));
							rep.add(cleaned.get(8));
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
				boolean matches = pattern.matches(line, i, const2Value, strConst2Value);
				if (matches) {
					try {
						input = pattern.modify(input);
					} catch(Exception e) {
						Logger.log("Failed to apply: "+pattern.getName());
					}
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

	private Map<String, Number> extractConstants(List<String> ret) {
		return Collections.unmodifiableMap(Util.extractNumberConstants(ret));
	}

	private Map<String, String> extractStringConstants(List<String> ret) {
		return Collections.unmodifiableMap(Util.extractStringConstants(ret));
	}

}
