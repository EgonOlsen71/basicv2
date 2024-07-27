package com.sixtyfour.cbmnative.python;

import java.util.ArrayList;
import java.util.List;

/**
 * Handles indentions and other Python related shenanigans
 * 
 * @author EgonOlsen
 *
 */
public class Pythonizer {
	
	private int level=0;
	
	public Pythonizer() {
		//
	}
	
	public Pythonizer(int level) {
		this.level=level;
	}
	
	public void indent() {
		level++;
	}
	
	public void outdent() {
		level--;
	}
	
	public String process(String cmd) {
		cmd = removeDollar(cmd);
		StringBuilder sb = new StringBuilder();
		for (int i=0; i<level; i++) {
			sb.append("    ");
		}
		sb.append(cmd);
		return sb.toString();
		
	}
	
	public List<String> unifyIndentions(List<String> code) {
		List<String> res = new ArrayList<>();
		for (String line:code) {
			line=line.replace("\t", "    ");
			res.add(line);
		}
		return res;
	}
	
	public String processGlobal(String cmd) {
		cmd = removeDollar(cmd);
		StringBuilder sb = new StringBuilder();
		if (!cmd.startsWith("def ")) {
			for (int i=0; i<level; i++) {
				sb.append("    ");
			}
		}
		String add = sb.toString();
		sb.setLength(0);
		List<String> usedVars = extractUseVariables(cmd);
		for (String usedVar:usedVars) {
			sb.append(add).append("global "+usedVar).append("\n");
		}
		sb.append(add).append(cmd);
		return sb.toString();
	}
	
	private List<String> extractUseVariables(String cmd) {
		List<String> vars = new ArrayList<>();
		if (!cmd.contains("=")) {
			return vars;
		}
		StringBuilder varName = new StringBuilder();
		boolean inStr = false;
		for (int i=0; i<cmd.length(); i++) {
			char c = cmd.charAt(i);
			if (c=='"') {
				inStr=!inStr;
			}
			if (inStr) {
				continue;
			}
			char cl = Character.toLowerCase(c);
			if ("abcdefghijklmnopqrstuvwxyz1234567890_".contains(Character.toString(cl))) {
				varName.append(c);
			} else {
				addVar(vars, varName);
				varName.setLength(0);
			}
		}
		addVar(vars, varName);
		return vars;
	}

	private void addVar(List<String> vars, StringBuilder varName) {
		if (varName.length()>0 && varName.toString().contains("_")) {
			vars.add(varName.toString());
		}
	}
	
	private String removeDollar(String cmd) {
		StringBuilder ret = new StringBuilder();
		boolean inStr = false;
		for (int i=0; i<cmd.length(); i++) {
			char c=cmd.charAt(i);
			if (c=='"') {
				inStr=!inStr;
			}
			if ((c=='%' || c=='$') && !inStr) {
				ret.append(c=='$'?"_STRVAR":"_INTVAR");
			} else {
				ret.append(c);
			}
		}
		return ret.toString();
	}

}
