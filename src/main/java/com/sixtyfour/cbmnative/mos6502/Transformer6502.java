package com.sixtyfour.cbmnative.mos6502;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sixtyfour.Loader;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.Transformer;
import com.sixtyfour.cbmnative.mos6502.generators.Generator;
import com.sixtyfour.cbmnative.mos6502.generators.GeneratorContext;
import com.sixtyfour.cbmnative.mos6502.generators.GeneratorList;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.parser.assembly.AssemblyParser;
import com.sixtyfour.system.Machine;

/**
 * @author EgonOlsen
 * 
 */
public class Transformer6502 implements Transformer {
	@Override
	public List<String> transform(Machine machine, PlatformProvider platform, List<String> code) {
		List<String> res = new ArrayList<>();
		List<String> consts = new ArrayList<String>();
		List<String> vars = new ArrayList<String>();
		List<String> mnems = new ArrayList<String>();
		List<String> subs = new ArrayList<String>();
		mnems.add("; *** CODE ***");
		subs.add("; *** SUBROUTINES ***");

		subs.addAll(Arrays.asList(Loader.loadProgram(this.getClass().getResourceAsStream("/subroutines.asm"))));

		consts.add("; *** CONSTANTS ***");
		consts.add("CONSTANTS");
		vars.add("; *** VARIABLES ***");
		vars.add("VARIABLES");
		Map<String, String> name2label = new HashMap<String, String>();

		res.add("TMP_ZP = 105");
		res.add("TMP2_ZP = 107");
		res.add("TMP3_ZP = 34");
		res.add(";make sure that JUMP_TARGET's low can't be $ff");
		res.add("JUMP_TARGET = 69");
		res.add("*=" + platform.getStartAddress());
		int cnt = 0;

		GeneratorContext context = new GeneratorContext();
		for (String line : code) {
			String cmd = line;
			line = convertConstantsToReal(line, platform);
			line = AssemblyParser.truncateComments(line);
			String orgLine = line;

			int sp = line.indexOf(" ");
			if (sp != -1) {
				line = line.substring(sp).trim();
			}
			cnt = extractData(platform, machine, consts, vars, name2label, cnt, line);

			Generator pm = GeneratorList.getGenerator(orgLine);
			if (pm != null) {
				pm.generateCode(context, orgLine, mnems, subs, name2label);
			} else {
				mnems.add("; not supported: " + cmd);
			}
		}

		if (!mnems.get(mnems.size() - 1).equals("RTS")) {
			mnems.add("RTS");
		}

		res.addAll(mnems);
		res.addAll(subs);
		res.addAll(consts);
		res.addAll(vars);

		res.add("; *** INTERNAL ***");
		res.add("X_REG\t.REAL 0.0");
		res.add("Y_REG\t.REAL 0.0");
		res.add("C_REG\t.REAL 0.0");
		res.add("D_REG\t.REAL 0.0");
		res.add("E_REG\t.REAL 0.0");
		res.add("F_REG\t.REAL 0.0");
		res.add("A_REG\t.WORD 0");
		res.add("B_REG\t.WORD 0");
		res.add("G_REG\t.WORD 0");
		res.add("TMP_REG\t.WORD 0");
		res.add("TMP2_REG\t.WORD 0");
		res.add("TMP3_REG\t.WORD 0");
		res.add("TMP4_REG\t.WORD 0");
		res.add("TMP_FREG\t.REAL 0");
		res.add("TMP2_FREG\t.REAL 0");
		res.add("TMP_FLAG\t.BYTE 0");
		// res.add("JUMP_TARGET\t.WORD 0");
		res.add("REAL_CONST_ONE\t.REAL 1.0");
		res.add("REAL_CONST_ZERO\t.REAL 0.0");
		res.add("REAL_CONST_MINUS_ONE\t.REAL -1.0");
		res.add("FPSTACKP\t.WORD FPSTACK");
		res.add("FPSTACK .ARRAY " + Math.min(256, platform.getStackSize() * 5));
		res.add("FORSTACKP\t.WORD FORSTACK");
		res.add("FORSTACK .ARRAY " + Math.min(1024, platform.getStackSize() * 17));
		res.add("EMPTYSTR\t.BYTE 0");
		res.add("WORKBUFP\t.WORD WORKBUF");
		res.add("WORKBUF\t.ARRAY 256");
		res.add("STRBUFP\t.WORD STRBUF");
		res.add("STRBUF\t.BYTE 0");
		return res;
	}

	private String convertConstantsToReal(String line, PlatformProvider platform) {
		if (platform.useLooseTypes()) {
			if (line.contains("#") && line.endsWith("{INTEGER}")) {
				int val = getConstantValue(line);
				if (val < 0 || val > 255) {
					line = line.replace("{INTEGER}", "{REAL}");
				}
			}
		}
		return line;
	}

	private int getConstantValue(String line) {
		String sval = line.substring(line.indexOf("#") + 1, line.indexOf("{INTEGER}"));
		int val = Integer.parseInt(sval);
		return val;
	}

	private int extractData(PlatformProvider platform, Machine machine, List<String> consts, List<String> vars, Map<String, String> name2label, int cnt, String line) {
		String[] parts = line.split(",");
		for (int p = 0; p < parts.length; p++) {
			String part = parts[p];
			if (part.contains("{") && part.endsWith("}")) {
				int pos = part.indexOf("{");
				String name = part.substring(0, pos);
				if (name.startsWith("#")) {
					if (!name2label.containsKey(name)) {
						consts.add("; CONST: " + name);
						String label = "CONST_" + (cnt++);
						name2label.put(name, label);

						Type type = Type.valueOf(part.substring(pos + 1, part.length() - 1));
						name = name.substring(1);
						if (type == Type.INTEGER) {
							// Range check...convert to real if needed
							int num = Integer.parseInt(name);
							if (num < -32768 || num > 32767) {
								name = name + ".0";
								type = Type.REAL;
							}
						}

						if (type == Type.INTEGER) {
							consts.add(label + "\t" + ".WORD " + name);
							if (platform.useLooseTypes()) {
								int val = getConstantValue(line);
								if (val >= 0 || val < 256) {
									consts.add(label + "R\t" + ".REAL " + name + ".0");
								}
							}
						} else if (type == Type.REAL) {
							consts.add(label + "\t" + ".REAL " + name);
						} else if (type == Type.STRING) {
							consts.add(label + "\t" + ".BYTE " + name.length());
							consts.add("\t" + ".TEXT \"" + name + "\"");
						}
					}
				} else {
					if (!name2label.containsKey(name)) {
						vars.add("; VAR: " + name);
						String label = "VAR_" + name;
						name2label.put(name, label);

						Type type = Type.valueOf(part.substring(pos + 1, part.length() - 1));
						if (name.contains("[]")) {
							Variable var = machine.getVariable(name);
							@SuppressWarnings("unchecked")
							List<Object> vals = (List<Object>) var.getInternalValue();
							if (type == Type.INTEGER) {
								vars.add("\t" + ".BYTE 0");
								vars.add("\t" + ".WORD " + vals.size() * 2);
								vars.add(label + "\t" + ".ARRAY " + vals.size() * 2);
							} else if (type == Type.REAL) {
								vars.add("\t" + ".BYTE 1");
								vars.add("\t" + ".WORD " + vals.size() * 5);
								vars.add(label + "\t" + ".ARRAY " + vals.size() * 5);
							} else if (type == Type.STRING) {
								vars.add("\t" + ".BYTE 2");
								vars.add("\t" + ".WORD " + vals.size() * 2);
								vars.add(label);
								for (int pp = 0; pp < vals.size(); pp = pp + 10) {
									StringBuilder sb = new StringBuilder();
									sb.append("\t" + ".WORD ");
									for (int ppp = pp; ppp < vals.size() && ppp < pp + 10; ppp++) {
										vars.add("EMPTYSTR ");
									}
									vars.add(sb.toString());
									sb.setLength(0);
								}
							}
						} else {
							if (type == Type.INTEGER) {
								vars.add(label + "\t" + ".WORD 0");
							} else if (type == Type.REAL) {
								vars.add(label + "\t" + ".REAL 0.0");
							} else if (type == Type.STRING) {
								vars.add(label + "\t" + ".WORD EMPTYSTR");
							}
						}
					}
				}
			}
		}
		return cnt;
	}
}
