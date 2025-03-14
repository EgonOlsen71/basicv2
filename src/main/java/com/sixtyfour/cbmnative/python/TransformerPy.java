package com.sixtyfour.cbmnative.python;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.sixtyfour.Loader;
import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.Generator;
import com.sixtyfour.cbmnative.GeneratorContext;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.Transformer;
import com.sixtyfour.cbmnative.mos6502.AbstractTransformer;
import com.sixtyfour.cbmnative.mos6502.util.Converter;
import com.sixtyfour.cbmnative.python.generators.GeneratorListPy;
import com.sixtyfour.config.CompilerConfig;
import com.sixtyfour.config.MemoryConfig;
import com.sixtyfour.elements.Type;
import com.sixtyfour.elements.Variable;
import com.sixtyfour.system.DataStore;
import com.sixtyfour.system.Machine;
import com.sixtyfour.util.ConstantExtractor;
import com.sixtyfour.util.VarUtils;

/**
 * The transformer for the Python target platform. It generates Python
 * code linked together with a Python runtime. The result can be run
 * using Python 3
 * 
 * @author EgonOlsen
 *
 */
public class TransformerPy implements Transformer {

	@Override
	public List<String> transform(CompilerConfig config, MemoryConfig memConfig, Machine machine,
			PlatformProvider platform, List<String> code) {
		Logger.log("Compiling into python code...");

		addContinues(code);

		List<String> res = new ArrayList<>();
		List<String> consts = new ArrayList<String>();
		List<String> vars = new ArrayList<String>();
		List<String> mnems = new ArrayList<String>();
		List<String> subs = new ArrayList<String>();
		List<String> datas = new ArrayList<String>();

		subs.add("# *** SUBROUTINES ***");
		
		List<String> subys = Arrays.asList(Loader.loadProgram(this.getClass().getResourceAsStream("/subroutines.py"), true));
		subys = platform.getOptimizer().optimize(config, platform, subys, config.getProgressListener());
		subs.addAll(subys);
		AbstractTransformer.addExtensionSubroutines(subs, "py");

		
		Pythonizer py = new Pythonizer();
		Pythonizer pyInd = new Pythonizer(1);

		res.add("import math");
		res.add("import random");
		res.add("import time");
		res.add("import keyboard");
		res.add("import re");
		res.add("import os");
		
		res.add("_flipcasing="+(config.isFlipCasing()?"True":"False"));
		
		res.add("def INIT():");
		py.indent();
		res.add(py.processGlobal("X_REG=0.0"));
		res.add(py.processGlobal("Y_REG=0.0"));
		res.add(py.processGlobal("C_REG=0.0"));
		res.add(py.processGlobal("D_REG=0.0"));
		res.add(py.processGlobal("E_REG=0.0"));
		res.add(py.processGlobal("F_REG=0.0"));
		res.add(py.processGlobal("A_REG=0"));
		res.add(py.processGlobal("B_REG=0"));
		res.add(py.processGlobal("G_REG=0"));
		res.add(py.processGlobal("CMD_NUM=0"));
		res.add(py.processGlobal("CHANNEL=0"));
		res.add(py.processGlobal("JUMP_TARGET=\"\""));
		res.add(py.processGlobal("USR_PARAM=0"));
		res.add(py.processGlobal("_line=\"\""));
		res.add(py.processGlobal("_stack=[]"));
		res.add(py.processGlobal("_forstack=[]"));
		res.add(py.processGlobal("_memory=[0] * 65535"));
		res.add(py.processGlobal("_zeroflag=0"));
		res.add(py.processGlobal("_timeOffset=0"));
		res.add(py.processGlobal("_time=0"));
		res.add(py.processGlobal("_inputQueue=[]"));

		Map<String, Integer> map = ConstantExtractor.getAllConstantMaps();
		for (Entry<String, Integer> entry : map.entrySet()) {
			res.add(py.processGlobal(entry.getKey() + "=" + entry.getValue()));
		}

		int cnt = 0;
		List<String> strVars = new ArrayList<String>();
		List<String> strArrayVars = new ArrayList<String>();
		Map<String, String> name2label = new HashMap<String, String>();

		GeneratorContext context = new GeneratorContext(config, machine);
		for (String line : code) {
			String cmd = line;
			String orgLine = line;

			int sp = line.indexOf(" ");
			if (sp != -1) {
				line = line.substring(sp).trim();
			}

			cnt = extractData(config, platform, machine, consts, vars, strVars, strArrayVars, name2label, cnt, line);

			Generator pm = GeneratorListPy.getGenerator(orgLine);
			if (pm != null) {
				pm.generateCode(context, orgLine, mnems, subs, name2label);
			} else {
				if (cmd.endsWith(":") || cmd.startsWith("CONT")) {
					mnems.add(cmd);
				} else {
					mnems.add("# ignored: " + cmd);
				}
			}
		}

		datas = createDatas(config, py, machine);

		// close the last function body
		res.addAll(globalize(py, consts));
		res.addAll(datas);
		vars.addAll(strVars);
		vars.addAll(strArrayVars);
		res.addAll(globalize(py, vars));
		py.outdent();
		res.addAll(globalize(pyInd, mnems));
		res.addAll(subs);
		res = py.unifyIndentions(res);
		
		return res;
	}
	

	private List<String> globalize(Pythonizer py, List<String> lines) {
		List<String> res = new ArrayList<>();
		for (String line:lines) {
			String sub = py.processGlobal(line);
			String[] subs = sub.split("\n");
			if (subs.length>1) {
				res.addAll(Arrays.asList(subs));
			} else {
				res.add(sub);
			}
		}
		return res;
	}

	private List<String> createDatas(CompilerConfig config, Pythonizer py, Machine machine) {
		DataStore datas = machine.getDataStore();
		List<String> ret = new ArrayList<String>();
		if (datas.size() > 0) {
			String strDat = py.processGlobal("_datas=[");
			ret.add(py.processGlobal("_dataPtr=0"));

			datas.restore();
			Object obj = null;
			while ((obj = datas.read()) != null) {
				Type type = Type.STRING;
				if (VarUtils.isInteger(obj)) {
					type = Type.INTEGER;
				} else if (VarUtils.isFloat(obj) || VarUtils.isDouble(obj)) {
					type = Type.REAL;
				}
				if (obj.toString().equals("\\0")) {
					obj = "";
				}

				if (type == Type.INTEGER) {
					strDat += obj.toString() + ",";
				} else if (type == Type.REAL) {
					strDat += obj.toString() + ",";
				} else {
					String name = obj.toString();
					if (config.isConvertStringToLower() || config.isFlipCasing()) {
						name = Converter.convertCase(name, !config.isFlipCasing());
					}
					strDat += "\"" + name + "\"" + ",";
				}
			}
			strDat = strDat.substring(0, strDat.length() - 1) + "]";
			ret.add(strDat);
		}
		return ret;
	}

	private void addContinues(List<String> code) {
		int cnt = 0;
		int forCnt = 0;
		for (int i = 0; i < code.size(); i++) {
			String line = code.get(i);
			if (line.equals("JSR GOSUB")) {
				String cont = "GOSUBCONT" + cnt++;
				int add = 2;
				// Catch the NOP introduced by a gosub in a list of conditionals.
				// It would be better to search for the first non-NOP instead, but I can't be
				// bothered
				if (code.get(i + 1).equals("NOP")) {
					add = 3;
				}
				code.add(i + add, cont + ":");
				code.set(i, "JSR GOSUB(\"" + cont + "\")");
			} else if (line.equals("JSR INITFOR")) {
				String cont = "FORLOOP" + forCnt++;
				String var = code.get(i - 1);
				var = var.substring(var.indexOf("(") + 1, var.lastIndexOf("{"));
				code.add(i + 1, cont + ":");
				code.set(i, "JSR INITFOR(\"" + cont + "\",\"VAR_" + var + "\")");
				code.set(i - 1, "NOP");
			} else if (line.equals("JSR NEXT")) {
				String var = code.get(i - 1);
				if (var.contains("{}")) {
					var = "VAR_" + var.substring(var.indexOf("(") + 1, var.indexOf("{"));
				} else {
					var = "0";
				}
				code.set(i - 1, "NOP");
				code.set(i, "JSR NEXT(\"" + var + "\")");
			}
		}

	}

	private int extractData(CompilerConfig config, PlatformProvider platform, Machine machine, List<String> consts, List<String> vars,
			List<String> strVars, List<String> strArrayVars, Map<String, String> name2label, int cnt, String line) {
		String[] parts = line.split(",", 2);
		List<String> tmp = new ArrayList<String>();
		for (int p = 0; p < parts.length; p++) {
			String part = parts[p];
			if (part.contains("{") && part.endsWith("}")) {
				int pos = part.lastIndexOf("{");
				String name = part.substring(0, pos);
				
				Variable vary = machine.getVariable(name);
				
				name = name.replace("%", "_int");
				name = name.replace("[]", "_array");
				if (name.startsWith("#")) {
					Type type = Type.valueOf(part.substring(pos + 1, part.length() - 1));
					String keyName = name;
					if (type == Type.STRING) {
						name = "$" + name.substring(1);
						keyName = name;
					}

					if (!name2label.containsKey(keyName)) {
						String label = "CONST_" + (cnt++);
						name2label.put(keyName, label);
						name = name.substring(1);

						if (type == Type.INTEGER) {
							consts.add(label + "=" + name + "");
						} else if (type == Type.REAL) {
							consts.add(label + "=" + name + "");
						} else if (type == Type.STRING) {
							if (config.isConvertStringToLower() || config.isFlipCasing()) {
								name = Converter.convertCase(name, !config.isFlipCasing());
							}
							consts.add(label + "=\"" + name + "\"");
						}
					}
				} else {
					if (!name2label.containsKey(name)) {
						tmp.clear();
						String label = "VAR_" + name;
						name2label.put(name, label);

						Type type = Type.valueOf(part.substring(pos + 1, part.length() - 1));
						if (name.endsWith("_array")) {
							String init="[0]";
							if (type == Type.STRING) {
								init="[\"\"]";
							}
							tmp.add(label + "="+init+"*"+vary.elements());
						} else {
							if (type == Type.INTEGER) {
								tmp.add(label + "=0");
							} else if (type == Type.REAL) {
								tmp.add(label + "=0.0");
							} else if (type == Type.STRING) {
								tmp.add(label + "=\"\"");
							}
						}
						if (name.contains("$")) {
							if (name.endsWith("_array")) {
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

	@Override
	public void setVariableStart(int variableStart) {
		//
	}

	@Override
	public int getStringMemoryEnd() {
		return 0;
	}

	@Override
	public void setStringMemoryEnd(int stringMemoryEnd) {
		//
	}

	@Override
	public int getVariableStart() {
		return 0;
	}

	@Override
	public int getStartAddress() {
		return 0;
	}

	@Override
	public void setStartAddress(int addr) {
		//
	}

	@Override
	public int getRuntimeStart() {
		return 0;
	}

	@Override
	public void setRuntimeStart(int runtimeStart) {
		//
	}

	@Override
	public boolean isOptimizedTempStorage() {
		return false;
	}

	@Override
	public void setOptimizedTempStorage(boolean optimizedTemp) {
		//
	}

	@Override
	public List<String> createCaller(final String calleeName) {
		return null;
	}

	public boolean isOptimizedStringPointers() {
		return false;
	}

	@Override
	public void setOptimizedStringPointers(boolean optimized) {
		//
	}

}
