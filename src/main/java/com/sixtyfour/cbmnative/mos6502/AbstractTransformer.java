package com.sixtyfour.cbmnative.mos6502;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import com.sixtyfour.Basic;
import com.sixtyfour.Loader;
import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.Generator;
import com.sixtyfour.cbmnative.GeneratorContext;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.Transformer;
import com.sixtyfour.cbmnative.mos6502.generators.GeneratorList;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.extensions.BasicExtension;
import com.sixtyfour.system.DataStore;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.ConstantExtractor;

/**
 * Transformer base class for Commodore based target platforms.
 * 
 * @author EgonOlsen
 *
 */
public abstract class AbstractTransformer implements Transformer {

	protected int variableStart = -1;
	protected int runtimeStart = -1;
	protected int stringMemoryEnd = 0;
	protected int startAddress = 0;
	protected boolean preferZeropage = true;

	public static void addExtensionSubroutines(List<String> addTo, String postFix) {
		List<BasicExtension> exts = Basic.getExtensions();
		if (exts != null) {
			for (BasicExtension ext : exts) {
				try {
					for (String inc : ext.getAdditionalIncludes()) {
						List<String> adds = Arrays.asList(Loader.loadProgram(
								AbstractTransformer.class.getResourceAsStream("/ext/" + inc + "." + postFix)));
						addTo.addAll(adds);
					}
				} catch (Exception e) {
					// ignore
				}
			}
		}
	}

	public void addExtensionConstants(List<String> res) {
		Map<String, Integer> map = ConstantExtractor.getAllConstantMaps();
		for (Entry<String, Integer> entry : map.entrySet()) {
			res.add(entry.getKey() + "=" + entry.getValue());
		}
	}

        protected void addFacLocations(List<String> res) {
        	res.add("ARGSGN=$6E");
        	res.add("ARGLO=$6D");
        	res.add("ARGMO=$6C");
        	res.add("ARGMOH=$6B");
        	res.add("ARGHO=$6A");
        	res.add("ARGEXP=$69");
        	res.add("FACSGN=$66");
        	res.add("FACLO=$65");
        	res.add("FACMO=$64");
        	res.add("FACMOH=$63");
        	res.add("FACHO=$62");
        	res.add("FACEXP=$61");
        	res.add("FACOV=$70");
        	res.add("OLDOV=$56");
        	res.add("ARISGN=$6F");
        	res.add("FAC=$61");
        	res.add("RESLO=$29");
        	res.add("RESMO=$28");
        	res.add("RESMOH=$27");
        	res.add("RESHO=$26");
        	res.add("RESOV=$2A");
        	res.add("RESHOP=$6F");
        	res.add("FACHOP=$56");
        }

	protected List<String> createDatas(CompilerConfig config, Machine machine) {
		DataStore datas = machine.getDataStore();
		List<String> ret = new ArrayList<String>();
		ret.add("; ******** DATA ********");
		ret.add("DATAS");

		int cnt = 0;
		datas.restore();
		Object obj = null;
		while ((obj = datas.read()) != null) {
			Type type = Type.STRING;
			if (obj instanceof Integer) {
				Integer num = (Integer) obj;
				if (num < -32768 || num > 32767) {
					obj = num.floatValue();
					type = Type.REAL;
				} else {
					type = Type.INTEGER;
				}
			} else if (obj instanceof Float) {
				type = Type.REAL;
			}

			if (obj.toString().equals("\\0")) {
				if (type == Type.STRING) {
					obj = "";
				} else if (type == Type.REAL) {
					obj = 0.0f;
				} else {
					obj = 0;
				}
			}

			if (type == Type.INTEGER) {
				int val = ((Number) obj).intValue();
				if (val < 0 || val > 255) {
					ret.add(".BYTE 0");
					ret.add(".WORD " + obj.toString());
					cnt += 3;
				} else {
					if (val > 3 && val < 255) {
						// If larger than the largest type (3) and smaller than the end flag (255),
						/// the we can use the type's location as data and skip storing the typ itself.
						ret.add(".BYTE " + obj.toString());
						cnt += 1;
					} else {
						ret.add(".BYTE 3");
						ret.add(".BYTE " + obj.toString());
						cnt += 2;
					}
				}
			} else if (type == Type.REAL) {
				ret.add(".BYTE 1");
				ret.add(".REAL " + obj.toString());
				cnt += 6;
			} else {
				ret.add(".BYTE 2");
				ret.add(".BYTE " + obj.toString().length());
				String ds = obj.toString();
				if (config.isConvertStringToLower()) {
					ds = ds.toLowerCase(Locale.ENGLISH);
				}
				ret.add(".STRG \"" + ds + "\"");
				cnt += 2 + obj.toString().length();
			}
		}
		ret.add(".BYTE $FF");
		ret.add("; ******** DATA END ********");

		Logger.log("DATA lines converted, " + cnt + " bytes used!");
		return ret;
	}

	protected List<String> createInitScript(List<String> vars) {
		List<String> inits = new ArrayList<String>();
		inits.add("; ******* INITVARS ********");
		inits.add(";###############################");
		inits.add("INITVARS");

		inits.add("JSR INITSTRVARS");

		inits.add("LDA #0");
		for (String var : vars) {
			var = var.trim().replace("\t", " ");
			if (var.startsWith("VAR_")) {
				String[] parts = var.split(" ");
				boolean isArray = var.contains("[]");
				if (!parts[0].contains("$")) {
					if (parts[1].equals(".REAL")) {
						// INT and REAL arrays are both marked "ARRAY", so this
						// branch can only happen if it a single REAL.
						inits.add("STA " + parts[0]);
						inits.add("STA " + parts[0] + "+1");
						// inits.add("STA " + parts[0] + "+2");
						// inits.add("STA " + parts[0] + "+3");
						// inits.add("STA " + parts[0] + "+4");
					} else {
						// INT or ARRAY
						if (isArray) {
							if (inits.get(inits.size() - 1).equals("LDA #0")) {
								// The LDA #0 is obsolete in this case.
								inits.remove(inits.size() - 1);
							}
							inits.add("LDA #<" + parts[0]);
							inits.add("LDY #>" + parts[0]);
							inits.add("JSR INITSPARAMS"); // This should save A and Y
							// inits.add("LDA #<" + parts[0]);
							// inits.add("LDY #>" + parts[0]);
							inits.add("JSR INITNARRAY");
							inits.add("LDA #0");
						} else {
							inits.add("STA " + parts[0]);
							inits.add("STA " + parts[0] + "+1");
						}
					}
				}
			}
		}
		inits.add("RTS");
		inits.add(";###############################");
		return inits;
	}

	protected String convertConstantsToReal(String line, PlatformProvider platform) {
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

	protected int getConstantValue(String line) {
		String sval = line.substring(line.indexOf("#") + 1, line.indexOf("{INTEGER}"));
		int val = Integer.parseInt(sval);
		return val;
	}

	protected int extractData(CompilerConfig config, PlatformProvider platform, Machine machine, List<String> consts,
			List<String> vars, List<String> strVars, List<String> strArrayVars, Map<String, String> name2label, int cnt,
			String line) {
		String[] parts = line.split(",", 2);
		List<String> tmp = new ArrayList<String>();
		for (int p = 0; p < parts.length; p++) {
			String part = parts[p];
			if (part.contains("{") && part.endsWith("}")) {
				int pos = part.lastIndexOf("{");
				String name = part.substring(0, pos);
				if (name.startsWith("#")) {
					Type type = Type.valueOf(part.substring(pos + 1, part.length() - 1));
					String keyName = name;
					if (type == Type.STRING) {
						name = "$" + name.substring(1);
						keyName = name;
					}

					if (!name2label.containsKey(keyName)) {

						consts.add("; CONST: " + keyName);
						String label = "CONST_" + (cnt++);
						name2label.put(keyName, label);

						name = name.substring(1);
						if (type == Type.INTEGER) {
							// Range check...convert to real if needed
							int num = Integer.parseInt(name);
							if (num < -32768 || num > 32767) {
								name += ".0";
								type = Type.REAL;
							}
						}

						if (type == Type.INTEGER) {
							consts.add(label + "\t" + ".WORD " + name);
							if (platform.useLooseTypes()) {
								consts.add(label + "R\t" + ".REAL " + name + ".0");
							}
						} else if (type == Type.REAL) {
							consts.add(label + "R");
							consts.add(label + "\t" + ".REAL " + name);
						} else if (type == Type.STRING) {
							consts.add(label + "\t" + ".BYTE " + name.length());
							if (config.isConvertStringToLower()) {
								name = name.toLowerCase(Locale.ENGLISH);
							}
							consts.add("\t" + ".STRG \"" + name + "\"");
						}
					}
				} else {
					if (!name2label.containsKey(name)) {
						tmp.clear();
						tmp.add("; VAR: " + name);
						String label = "VAR_" + name;
						name2label.put(name, label);

						Type type = Type.valueOf(part.substring(pos + 1, part.length() - 1));
						if (name.contains("[]")) {
							Variable var = machine.getVariable(name);
							@SuppressWarnings("unchecked")
							List<Object> vals = (List<Object>) var.getInternalValue();
							if (type == Type.INTEGER) {
								tmp.add("\t" + ".BYTE 0");
								tmp.add("\t" + ".WORD " + vals.size() * 2);
								tmp.add(label + "\t" + ".ARRAY " + vals.size() * 2);
							} else if (type == Type.REAL) {
								tmp.add("\t" + ".BYTE 1");
								tmp.add("\t" + ".WORD " + vals.size() * 5);
								tmp.add(label + "\t" + ".ARRAY " + vals.size() * 5);
							} else if (type == Type.STRING) {
								tmp.add("\t" + ".BYTE 2");
								tmp.add("\t" + ".WORD " + vals.size() * 2);
								tmp.add(label);
								for (int pp = 0; pp < vals.size(); pp = pp + 10) {
									StringBuilder sb = new StringBuilder();
									sb.append("\t" + ".WORD ");
									for (int ppp = pp; ppp < vals.size() && ppp < pp + 10; ppp++) {
										sb.append("EMPTYSTR ");
									}
									tmp.add(sb.toString());
									sb.setLength(0);
								}
							}
						} else {
							if (type == Type.INTEGER) {
								tmp.add(label + "\t" + ".WORD 0");
							} else if (type == Type.REAL) {
								tmp.add(label + "\t" + ".REAL 0.0");
							} else if (type == Type.STRING) {
								tmp.add(label + "\t" + ".WORD EMPTYSTR");
							}
						}
						if (name.contains("$")) {
							if (name.contains("[]")) {
								strArrayVars.addAll(tmp);
							} else {
								strVars.addAll(tmp);
							}
						} else {
							vars.addAll(tmp);
						}
					}
				}
			}
		}

		return cnt;
	}

	protected void addStructures(CompilerConfig config, Machine machine, PlatformProvider platform, List<String> code,
			List<String> res, List<String> consts, List<String> vars, List<String> mnems, List<String> subs) {
		addStructures(config, machine, platform, code, res, consts, vars, mnems, subs, null);
	}

	protected void addStructures(CompilerConfig config, Machine machine, PlatformProvider platform, List<String> code,
			List<String> res, List<String> consts, List<String> vars, List<String> mnems, List<String> subs,
			List<String> addOns) {
		Map<String, String> name2label = new HashMap<String, String>();
		int cnt = 0;

		List<String> strVars = new ArrayList<String>();
		List<String> strArrayVars = new ArrayList<String>();
		GeneratorContext context = new GeneratorContext();
		for (String line : code) {
			String cmd = line;
			line = convertConstantsToReal(line, platform);

			// Intermediate code should contain no comments, so this actually
			// hurts for Strings like "blah;"
			// line = AssemblyParser.truncateComments(line);
			String orgLine = line;

			int sp = line.indexOf(" ");
			if (sp != -1) {
				line = line.substring(sp).trim();
			}

			cnt = extractData(config, platform, machine, consts, vars, strVars, strArrayVars, name2label, cnt, line);

			Generator pm = GeneratorList.getGenerator(orgLine);
			Generator altPm = platform.getGenerator(orgLine);
			if (altPm != null) {
				pm = altPm;
			}
			if (pm != null) {
				pm.generateCode(context, orgLine, mnems, subs, name2label);
			} else {
				if (cmd.endsWith(":") || cmd.startsWith("CONT")) {
					mnems.add(cmd);
				} else {
					mnems.add("; ignored: " + cmd);
				}
			}
		}

		if (!mnems.get(mnems.size() - 1).equals("RTS")) {
			mnems.add("RTS");
		}

		List<String> inits = createInitScript(vars);
		List<String> datas = createDatas(config, machine);

		subs.addAll(inits);
		subs.add("; *** SUBROUTINES END ***");
		subs.add("SQRTTABLE");
		subs.add(".BYTE 03 11 18 25 32 38 44 50");
		subs.add(".BYTE 58 69 79 89 98 107 115 123");
		res.addAll(mnems);
		res.addAll(subs);
		if (addOns != null) {
			addOns.add(0, ";###################################");
			res.addAll(addOns);
		}
		res.addAll(consts);
		res.addAll(datas);
		res.add("CONSTANTS_END");
		if (!strVars.contains("; VAR: TI$")) {
			strVars.add("; VAR: TI$");
			strVars.add("VAR_TI$ .WORD EMPTYSTR");
		}
		vars.add("STRINGVARS_START");
		vars.addAll(strVars);
		vars.add("STRINGVARS_END");
		vars.add("STRINGARRAYS_START");
		vars.addAll(strArrayVars);
		vars.add("STRINGARRAYS_END");

		res.addAll(vars);
		res.add("VARIABLES_END");
		res.add("; *** INTERNAL ***");
		res.add("X_REG\t.REAL 0.0");
		res.add("Y_REG\t.REAL 0.0");
		res.add("C_REG\t.REAL 0.0");
		res.add("D_REG\t.REAL 0.0");
		res.add("E_REG\t.REAL 0.0");
		res.add("F_REG\t.REAL 0.0");
		res.add("A_REG\t.WORD 0");
		res.add("B_REG\t.WORD 0");
		if (!preferZeropage) {
			res.add("G_REG\t.WORD 0");
		}
		res.add("CMD_NUM\t.BYTE 0");
		res.add("CHANNEL\t.BYTE 0");
		res.add("SP_SAVE\t.BYTE 0");
		if (!preferZeropage) {
			res.add("TMP_REG\t.WORD 0");
		}
		res.add("TMP2_REG\t.WORD 0");
		res.add("TMP3_REG\t.WORD 0");
		res.add("TMP4_REG\t.WORD 0");
		res.add("AS_TMP\t.WORD 0");
		res.add("STORE1\t.WORD 0");
		res.add("STORE2\t.WORD 0");
		res.add("STORE3\t.WORD 0");
		res.add("GCSTART\t.WORD 0");
		res.add("GCLEN\t.WORD 0");
		res.add("GCWORK\t.WORD 0");
		res.add("TMP_FREG\t.REAL 0");
		res.add("TMP2_FREG\t.REAL 0");
		res.add("TMP_FLAG\t.BYTE 0");
		// res.add("JUMP_TARGET\t.WORD 0");
		res.add("REAL_CONST_ONE\t.REAL 1.0");
		res.add("REAL_CONST_ZERO\t.REAL 0.0");
		res.add("REAL_CONST_MINUS_ONE\t.REAL -1.0");
		res.add("EMPTYSTR\t.BYTE 0");
		res.add("FPSTACKP\t.WORD FPSTACK");
		res.add("FORSTACKP\t.WORD FORSTACK");
		res.add("DATASP\t.WORD DATAS");
		res.add("LASTVAR\t.WORD 0");
		res.add("LASTVARP\t.WORD 0");
		res.add("HIGHP\t.WORD STRBUF");
		res.add("STRBUFP\t.WORD STRBUF");
		res.add("ENDSTRBUF\t.WORD " + this.stringMemoryEnd);
		res.add("INPUTQUEUEP\t.BYTE 0");
		res.add("PROGRAMEND");
		res.add("INPUTQUEUE\t.ARRAY $0F");
		res.add("FPSTACK .ARRAY " + Math.min(256, platform.getStackSize() * 5));
		res.add("FORSTACK .ARRAY " + Math.min(1024, platform.getForStackSize() * 17));
		res.add("STRBUF\t.BYTE 0");
	}

	@Override
	public void setVariableStart(int variableStart) {
		this.variableStart = variableStart;
	}

	@Override
	public int getVariableStart() {
		return variableStart;
	}

	@Override
	public int getStringMemoryEnd() {
		return stringMemoryEnd;
	}

	@Override
	public void setStringMemoryEnd(int stringMemoryEnd) {
		this.stringMemoryEnd = stringMemoryEnd;
	}

	@Override
	public void setStartAddress(int addr) {
		startAddress = addr;
	}

	@Override
	public int getStartAddress() {
		return startAddress;
	}

	@Override
	public int getRuntimeStart() {
		return runtimeStart;
	}

	@Override
	public void setRuntimeStart(int runtimeStart) {
		this.runtimeStart = runtimeStart;
	}

	@Override
	public boolean isOptimizedTempStorage() {
		return preferZeropage;
	}

	@Override
	public void setOptimizedTempStorage(boolean optimizedTemp) {
		this.preferZeropage = optimizedTemp;
	}

	@Override
	public List<String> createCaller(String calleeName) {
		return null;
	}
}
