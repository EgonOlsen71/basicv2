package com.sixtyfour.cbmnative.javascript;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sixtyfour.Loader;
import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.Generator;
import com.sixtyfour.cbmnative.GeneratorContext;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.Transformer;
import com.sixtyfour.cbmnative.javascript.generators.GeneratorListJs;
import com.sixtyfour.elements.Type;
import com.sixtyfour.system.DataStore;
import com.sixtyfour.system.Machine;

public class TransformerJs implements Transformer {

    @Override
    public List<String> transform(Machine machine, PlatformProvider platform, List<String> code) {
	Logger.log("Compiling into javascript code...");

	addContinues(code);

	List<String> res = new ArrayList<>();
	List<String> consts = new ArrayList<String>();
	List<String> vars = new ArrayList<String>();
	List<String> mnems = new ArrayList<String>();
	List<String> subs = new ArrayList<String>();
	List<String> datas = new ArrayList<String>();

	subs.add("// *** SUBROUTINES ***");
	subs.addAll(Arrays.asList(Loader.loadProgram(this.getClass().getResourceAsStream("/subroutines.js"))));

	res.add("function Compiled() {");
	
	res.add("this.INIT = function() {");
	res.add("this.X_REG=0.0;");
	res.add("this.Y_REG=0.0;");
	res.add("this.C_REG=0.0;");
	res.add("this.D_REG=0.0;");
	res.add("this.E_REG=0.0;");
	res.add("this.F_REG=0.0;");
	res.add("this.A_REG=0;");
	res.add("this.B_REG=0;");
	res.add("this.G_REG=0;");
	res.add("this.CMD_NUM=0;");
	res.add("this.CHANNEL=0;");
	res.add("this.JUMP_TARGET=\"\";");
	res.add("this.USR_PARAM=0;");
	res.add("this._line=\"\";");
	res.add("this._stack=new Array();");
	res.add("this._forstack=new Array();");
	res.add("this._memory=new Array(65535);");
	res.add("this._zeroflag=0");
	res.add("this._timeOffset=0");
	res.add("this._time=0");
	res.add("this._inputQueue=new Array();");

	int cnt = 0;
	List<String> strVars = new ArrayList<String>();
	List<String> strArrayVars = new ArrayList<String>();
	Map<String, String> name2label = new HashMap<String, String>();

	GeneratorContext context = new GeneratorContext();
	for (String line : code) {
	    String cmd = line;
	    String orgLine = line;

	    int sp = line.indexOf(" ");
	    if (sp != -1) {
		line = line.substring(sp).trim();
	    }

	    cnt = extractData(platform, machine, consts, vars, strVars, strArrayVars, name2label, cnt, line);

	    Generator pm = GeneratorListJs.getGenerator(orgLine);
	    if (pm != null) {
		pm.generateCode(context, orgLine, mnems, subs, name2label);
	    } else {
		if (cmd.endsWith(":")) {
		    mnems.add(cmd);
		} else {
		    mnems.add("// ignored: " + cmd);
		}
	    }
	}
	
	datas=createDatas(machine);

	// close the last function body
	mnems.add("}");
	res.addAll(consts);
	res.addAll(datas);
	vars.addAll(strVars);
	vars.addAll(strArrayVars);
	res.addAll(vars);
	res.add("}");
	res.addAll(mnems);
	res.addAll(subs);
	res.add("}");
	addFrame(res);

	return res;
    }

    private List<String> createDatas(Machine machine) {
	DataStore datas = machine.getDataStore();
	List<String> ret = new ArrayList<String>();
	if (datas.size()>0) {
	String strDat="this._datas=[";
	ret.add("this._dataPtr=0;");

	datas.restore();
	Object obj = null;
	while ((obj = datas.read()) != null) {
		Type type = Type.STRING;
		if (obj instanceof Integer) {
		    type = Type.INTEGER;
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
			strDat+=obj.toString()+",";
		} else if (type == Type.REAL) {
		    strDat+=obj.toString()+",";
		} else {
		    strDat+="\""+obj.toString()+"\""+",";
		}
	}
	strDat=strDat.substring(0, strDat.length()-1)+"];";
	ret.add(strDat);
	}
	return ret;
}
    
    private void addContinues(List<String> code) {
	int cnt = 0;
	int forCnt=0;
	for (int i = 0; i < code.size(); i++) {
	    String line = code.get(i);
	    if (line.equals("JSR GOSUB")) {
		String cont="GOSUBCONT" + cnt++;
		code.add(i + 2, cont+":");
		code.set(i, "JSR GOSUB(\""+cont+"\")");
	    } else if (line.equals("JSR INITFOR")) {
		String cont="FORLOOP" + forCnt++;
		String var=code.get(i-1);
		var=var.substring(var.indexOf("(")+1, var.lastIndexOf("{"));
		code.add(i + 1, cont+":");
		code.set(i, "JSR INITFOR(\""+cont+"\",\"VAR_"+var+"\")");
		code.set(i-1, "NOP");
	    } else if (line.equals("JSR NEXT")) {
		String var=code.get(i-1);
		if (var.contains("{}")) {
		    var="VAR_"+var.substring(var.indexOf("(")+1,var.indexOf("{"));
		} else {
		    var="0";
		}
		code.set(i-1, "NOP");
		code.set(i, "JSR NEXT(\""+var+"\")");
	    }
	}

    }

    private int extractData(PlatformProvider platform, Machine machine, List<String> consts, List<String> vars,
	    List<String> strVars, List<String> strArrayVars, Map<String, String> name2label, int cnt, String line) {
	String[] parts = line.split(",", 2);
	List<String> tmp = new ArrayList<String>();
	for (int p = 0; p < parts.length; p++) {
	    String part = parts[p];
	    if (part.contains("{") && part.endsWith("}")) {
		int pos = part.lastIndexOf("{");
		String name = part.substring(0, pos);
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
			    consts.add("this." + label + "=" + name + ";");
			} else if (type == Type.REAL) {
			    consts.add("this." + label + "=" + name + ";");
			} else if (type == Type.STRING) {
			    consts.add("this." + label + "=\"" + name + "\";");
			}
		    }
		} else {
		    if (!name2label.containsKey(name)) {
			tmp.clear();
			String label = "VAR_" + name;
			name2label.put(name, label);

			Type type = Type.valueOf(part.substring(pos + 1, part.length() - 1));
			if (name.endsWith("_array")) {
			    tmp.add("this." + label + "=new Array();");
			} else {
			    if (type == Type.INTEGER) {
				tmp.add("this." + label + "=0;");
			    } else if (type == Type.REAL) {
				tmp.add("this." + label + "=0.0;");
			    } else if (type == Type.STRING) {
				tmp.add("this." + label + "=\"\";");
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
	// TODO Auto-generated method stub
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

    private void addFrame(List<String> res) {
	res.add(0, "<script type='text/javascript'>");
	res.add(0, "<html>");
	res.add("new Compiled().execute();");
	res.add("</script>");
	res.add("</html>");
    }

}
