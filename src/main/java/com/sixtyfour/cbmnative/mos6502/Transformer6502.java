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
import com.sixtyfour.system.DataStore;
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

		int memStackSize = Math.min(255, platform.getMemoryStackSize() * 3);
		res.add("MEMORY_STACK_SIZE = " + memStackSize);
		res.add("SGNFAC = $BC2B");
		res.add("MEMARG = $BA8C");
		res.add("ARGADD = $B86A");
		res.add("ARGAND = $AFE9");
		res.add("ARGDIV = $BB14");
		res.add("FACMUL = $BA30");
		res.add("FACADD = $B867");
		res.add("FACLOG = $B9EA");
		res.add("FACSQR = $BF71");
		res.add("FACEXP = $BFED");
		res.add("FACABS = $BC58");
		res.add("FACSIN = $E26B");
		res.add("FACCOS = $E264");
		res.add("FACTAN = $E2B4");
		res.add("FACATN = $E30E");
		res.add("FACSGN = $BC39");
		res.add("FACRND = $E097");
		res.add("FACWORD = $B7F7");
		res.add("FACDIV = $BB0F");
		res.add("BASINT = $BCCC");
		res.add("FACPOW = $BF7B");
		res.add("FACSUB = $B853");
		res.add("FACOR = $AFE6");
		res.add("FACMEM = $BBD7");
		res.add("ARGFAC = $BBFC");
		res.add("FACSTR = $BDDF");
		res.add("FACINT = $B1AA");
		res.add("REALFAC = $BBA2");
		res.add("INTFAC = $B391");
		res.add("WRITETIS = $A9E7");
		res.add("GETTI = $BE68");
		res.add("GETTIME = $AF7E");
		res.add("COPYTIME = $AF87");
		res.add("TI2FAC = $AF84");
		res.add("CHROUT = $FFD2");
		res.add("PRINTSTRS = $AB25");
		res.add("VALS = $B7B5");
		res.add("CMPFAC = $BC5B");
		res.add("BYTEFAC = $B3A2");
		res.add("CRSRPOS = $FFF0");
		res.add("CRSRRIGHT = $AB3B");
		res.add("GETIN = $FFE4");
		res.add("INPUT = $A560");

		res.add("TMP_ZP = 105");
		res.add("TMP2_ZP = 107");
		res.add("TMP3_ZP = 34");
		res.add(";make sure that JUMP_TARGET's low can't be $ff");
		res.add("JUMP_TARGET = 69");
		res.add("*=" + platform.getStartAddress());
		res.add("TSX");
		res.add("STX SP_SAVE");
		
		int cnt = 0;

		List<String> strVars = new ArrayList<String>();
		List<String> strArrayVars = new ArrayList<String>();
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
			cnt = extractData(platform, machine, consts, vars, strVars, strArrayVars, name2label, cnt, line);

			Generator pm = GeneratorList.getGenerator(orgLine);
			if (pm != null) {
				pm.generateCode(context, orgLine, mnems, subs, name2label);
			} else {
				if (cmd.endsWith(":")) {
					mnems.add(cmd);
				} else {
					mnems.add("; not supported: " + cmd);
				}
			}
		}

		if (!mnems.get(mnems.size() - 1).equals("RTS")) {
			mnems.add("RTS");
		}

		List<String> inits = createInitScript(vars);
		List<String> datas=createDatas(machine);

		subs.addAll(inits);
		subs.add("; *** SUBROUTINES END ***");
		subs.add("SQRTTABLE");
		subs.add(".BYTE 03 11 18 25 32 38 44 50");
		subs.add(".BYTE 58 69 79 89 98 107 115 123");
		res.addAll(mnems);
		res.addAll(subs);
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
		res.add("G_REG\t.WORD 0");
		res.add("SP_SAVE\t.BYTE 0");
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
		res.add("EMPTYSTR\t.BYTE 0");
		res.add("FPSTACKP\t.WORD FPSTACK");
		res.add("FORSTACKP\t.WORD FORSTACK");
		res.add("DATASP\t.WORD DATAS");
		res.add("LASTVAR\t.WORD 0");
		res.add("LASTVARP\t.WORD 0");
		res.add("HIGHP\t.WORD STRBUF");
		res.add("STRBUFP\t.WORD STRBUF");
		res.add("ENDSTRBUF\t.WORD " + platform.getStringMemoryEnd());
		res.add("INPUTQUEUEP\t.BYTE 0");
		res.add("CONCATBUFP\t.BYTE 0");
		res.add("PROGRAMEND");
		// Don't stick anything here between CONCATBUFP and CONCATBUF...
		res.add("CONCATBUF\t.ARRAY 256");
		res.add("INPUTQUEUE\t.ARRAY $0F");
		res.add("FPSTACK .ARRAY " + Math.min(256, platform.getStackSize() * 5));
		res.add("FORSTACK .ARRAY " + Math.min(1024, platform.getStackSize() * 17));
		res.add("STRBUF\t.BYTE 0");
		return res;
	}

	private List<String> createDatas(Machine machine) {
	    DataStore datas=machine.getDataStore();
	    List<String> ret=new ArrayList<String>();
	    ret.add("; ******** DATA ********");
	    ret.add("DATAS");
	    
	    datas.restore();
		Object obj = null;
		while ((obj = datas.read()) != null) {
			Type type = Type.STRING;
			if (obj instanceof Integer) {
			    Integer num = (Integer) obj;
				if (num < -32768 || num > 32767) {
				    obj=num.floatValue();
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
				ret.add(".BYTE 0");
				ret.add(".WORD "+obj.toString());
			} else if (type == Type.REAL) {
			    ret.add(".BYTE 1");
			    ret.add(".REAL "+obj.toString());
			} else {
			    ret.add(".BYTE 2");
			    ret.add(".BYTE "+obj.toString().length());
			    ret.add(".TEXT \""+obj.toString()+"\"");
			}
		}
		ret.add(".BYTE $FF");
		ret.add("; ******** DATA END ********");
	    return ret;
	}

	private List<String> createInitScript(List<String> vars) {
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
						// inits.add("STA " + parts[0] + "+1");
						// inits.add("STA " + parts[0] + "+2");
						// inits.add("STA " + parts[0] + "+3");
						// inits.add("STA " + parts[0] + "+4");
					} else {
						// INT or ARRAY
						if (isArray) {
							inits.add("LDA #<" + parts[0]);
							inits.add("LDY #>" + parts[0]);
							inits.add("JSR INITSPARAMS");
							inits.add("LDA #<" + parts[0]);
							inits.add("LDY #>" + parts[0]);
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

	private int extractData(PlatformProvider platform, Machine machine, List<String> consts, List<String> vars, List<String> strVars, List<String> strArrayVars,
			Map<String, String> name2label, int cnt, String line) {
		String[] parts = line.split(",", 2);
		List<String> tmp = new ArrayList<String>();
		for (int p = 0; p < parts.length; p++) {
			String part = parts[p];
			if (part.contains("{") && part.endsWith("}")) {
				int pos = part.lastIndexOf("{");
				String name = part.substring(0, pos);
				if (name.startsWith("#")) {
					Type type = Type.valueOf(part.substring(pos + 1, part.length() - 1));
					if (type == Type.STRING) {
						name = "$" + name.substring(1);
					}
					if (!name2label.containsKey(name)) {
						consts.add("; CONST: " + name);
						String label = "CONST_" + (cnt++);
						name2label.put(name, label);

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
}
