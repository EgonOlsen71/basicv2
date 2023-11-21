package com.sixtyfour.cbmnative.mos6502;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sixtyfour.Logger;

/**
 * Hacky approach to optimize the zero page usage of the generated code
 * by using a post-processor on the actual code to move some variables into
 * the zeropage.
 * 
 * @author EgonOlsen
 *
 */
public class AssemblyOptimizer {

	private static int[] C64_ZEROPAGE_AVAIL= {14, 3, 5, 78 };
	
	/**
	 * Finds the most often used integer variables and moves them into the zeropage.
	 * 
	 * @param code the initial code
	 * @return the optimized code
	 */
	public List<String> moveVariables(List<String> code) {
		return Arrays.asList(moveVariables(code.toArray(new String[code.size()])));
	}
	
	/**
	 * Finds the most often used integer variables and moves them into the zeropage.
	 * 
	 * @param code the initial code
	 * @return the optimized code
	 */
	public String[] moveVariables(String[] code) {
		List<String> res = new ArrayList<>();
		
		Map<String, Integer> varCount = new HashMap<>();
		for (String line:code) {
			String lline = line.toLowerCase();
			// Count usage of integer variables...
			if (lline.startsWith("ld") && lline.contains("var_") && lline.endsWith("%") && !lline.contains("[]")) {
				String varName = lline.substring(lline.indexOf(" ")+1).trim();
				Integer cnt = varCount.get(varName);
				if (cnt==null) {
					cnt=0;
				}
				varCount.put(varName, cnt+1);
			}
		}
		
		List<String> names = new ArrayList<>(varCount.keySet());
		Collections.sort(names, new Comparator<String>() {
			@Override
			public int compare(String o1, String o2) {
				Integer val1 = varCount.get(o1);
				Integer val2 = varCount.get(o2);
				return val2.compareTo(val1);
			}
		});
		
		/*
		for (String key:names) {
			Logger.log(key+" => "+varCount.get(key));
		}
		*/
		// @todo Move...
		int[] avail = C64_ZEROPAGE_AVAIL;
		List<String> toPrepend = new ArrayList<>();
		
		for (int i=0; i<avail.length && i<names.size(); i++) {
			String var = names.get(i);
			removeVar(var, code);
			toPrepend.add(var.toUpperCase()+"="+avail[i]);
			Logger.log("Moved "+var+" to zeropage!");
		}
		res.addAll(toPrepend);
		res.addAll(Arrays.asList(code));
		
		return res.toArray(new String[res.size()]);
	}


	private void removeVar(String var, String[] code) {
		String hVar = var.toUpperCase();
		for (int i=0; i<code.length; i++) {
			
			String line = code[i];
			if (line.startsWith(hVar) && !line.contains("[]")) {
				line = "; "+line;
				code[i] = line;
			}
		}
	}
	
}
