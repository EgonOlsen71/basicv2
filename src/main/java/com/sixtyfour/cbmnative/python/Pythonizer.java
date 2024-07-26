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
		if (!cmd.contains("=") || cmd.contains("==")) {
			sb.append(cmd);
		} else {
			String[] parts = cmd.split("=");
			String add = sb.toString();
			String p1 = extractVarName(parts[1]);
			if (!isNumber(p1) && !p1.startsWith("\"") && !p1.isEmpty()) {
				sb.append("global ").append(p1).append("\n").append(add);
			} 
			sb.append("global ").append(parts[0]).append("\n").append(add).append(cmd);
		}
		return sb.toString();
	}
	
	private String extractVarName(String cmd) {
		int pos = cmd.indexOf(".");
		int pos2 = cmd.indexOf("[");
		if (pos2==-1 && pos==-1) {
			return cmd;
		}
		if (pos2==-1) {
			return cmd.substring(0, pos);
		}
		if (pos!=-1) {
			return cmd.substring(0, Math.min(pos, pos2));
		}
		return cmd.substring(0, pos2); 
	}
	
	private boolean isNumber(String line) {
		try {
			Float.parseFloat(line.trim());
			return true;
		} catch (Exception e) {
			return false;
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
