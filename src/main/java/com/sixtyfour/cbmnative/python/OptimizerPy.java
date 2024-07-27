package com.sixtyfour.cbmnative.python;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.Optimizer;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.ProgressListener;
import com.sixtyfour.config.CompilerConfig;

/**
 * An optimizer implementation for the Python target platform.
 * Nothing in here for now...
 * 
 * @author EgonOlsen
 *
 */
public class OptimizerPy implements Optimizer {


	@Override
	public List<String> optimize(CompilerConfig config, PlatformProvider platform, List<String> code,
			ProgressListener pg) {
		
		Logger.log("Optimizing python code...");
		long s = System.currentTimeMillis();
		
		List<String> res = new ArrayList<>();
		Set<String> globals = new HashSet<>();
		boolean inDef = false;
		int insertAt = -1;
		
		for (String line:code) {
			if (line.contains("\n")) {
				res.addAll(Arrays.asList(line.split("\n")));
			} else {
				res.add(line);
			}
		}
		
		code = res;
		res = new ArrayList<>();
		
		for (String line:code) {
			if (!line.contains("def") && (line.contains("COMPACT()") || line.contains("COMPACTMAX()"))) {
				continue;
			}
			if (line.startsWith("    #")) {
				continue;
			}
			if (line.startsWith("def ") || line.isEmpty()) {
				if (inDef) {
					if (insertAt!=-1) {
						for (String global:globals) {
							res.add(insertAt+1, global);
						}
					}
					globals.clear();
				} 
				inDef = line.startsWith("def ");
				if (inDef) {
					insertAt = res.size();
				} else {
					insertAt = -1;
				}
			}
			if (inDef) {
				if (line.trim().startsWith("global ")) {
					globals.add(line);
				} else {
					res.add(line);
				}
			} else {
				res.add(line);
			}
		}
		Logger.log("Python code optimized in " + (System.currentTimeMillis() - s) + "ms");
		return res;
	}

}
