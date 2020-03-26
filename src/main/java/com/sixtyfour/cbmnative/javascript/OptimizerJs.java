package com.sixtyfour.cbmnative.javascript;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.Optimizer;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.ProgressListener;
import com.sixtyfour.config.CompilerConfig;

/**
 * An optimizer implementation for the Javascript target platform. The
 * optimizations that it applies are pretty basic (no pun intended).
 * 
 * @author EgonOlsen
 *
 */
public class OptimizerJs implements Optimizer {

	private final static int MAX_AHEAD = 9;

	@Override
	public List<String> optimize(CompilerConfig config, PlatformProvider platform, List<String> code,
			ProgressListener pg) {
		
		if (code.size() > 1) {

			Logger.log("Optimizing javascript code...");
			long s = System.currentTimeMillis();

			List<String> ret = new ArrayList<String>();
			String[] lines = new String[MAX_AHEAD];
			String[][] splittedLines = new String[MAX_AHEAD][];

			for (int i = 0; i < code.size() - 1; i++) {
				int p = 0;
				for (; p < MAX_AHEAD && p + i < code.size(); p++) {
					String line = code.get(p + i);
					lines[p] = line;
					splittedLines[p] = lines[p].split(" |,");
				}
				for (; p < MAX_AHEAD; p++) {
					lines[p] = null;
					splittedLines[p] = null;
				}

				boolean replaced = false;
				if (lines[0].startsWith("this._stack.push(this.Y_REG);") && lines[1].startsWith("//")
						&& lines[2].startsWith("this.X_REG=this._stack.pop();")) {
					ret.add("this.X_REG=this.Y_REG;");
					i += 2;
					replaced = true;
				}
				if (lines[0].startsWith("this._zeroflag=(this.") && lines[1].startsWith("if (this._zeroflag")) {
					int pos = lines[0].indexOf("(");
					int pos2 = lines[0].lastIndexOf(")");
					ret.add(lines[1].replace("this._zeroflag", lines[0].substring(pos, pos2 + 1)));
					i++;
					replaced = true;
				}

				// Remove jumps to "empty" functions.
				if (lines[0].startsWith("return") && lines[0].contains(" ") && (lines[4].startsWith("return")
						&& lines[4].contains(" ")
						|| (lines[5].startsWith("return") && lines[5].contains(" ") && lines[4].startsWith("//")))) {
					if (lines[4].startsWith("//")) {
						for (int pp = 4; pp < MAX_AHEAD - 1; pp++) {
							lines[pp] = lines[pp + 1];
						}
					}
					String label = lines[0].split(" ")[1].replace(";", "").trim();
					String label4 = lines[4].split(" ")[1].replace(";", "").trim();

					if (label.startsWith("\"")) {
						label = label.substring(1, label.length() - 1);
					} else {
						label = "line_" + label;
					}

					if (label4.startsWith("\"")) {
						label4 = label4.substring(1, label4.length() - 1);
					} else {
						label4 = "line_" + label4;
					}
					if (lines[1].startsWith("}") && lines[2].startsWith("//")) {
						if (lines[3].startsWith("this." + label + " = function")) {
							if (lines[5].startsWith("}") && lines[6].startsWith("//")) {
								if (lines[7].startsWith("this." + label4 + " = function")) {
									replaced = true;
									ret.add(lines[4]);
								}
							}
						}
					}
				}

				if (!replaced) {
					ret.add(lines[0]);
				}

			}
			Logger.log("Javascript code optimized in " + (System.currentTimeMillis() - s) + "ms");
			ret.add(code.get(code.size() - 1));
			return ret;
		}

		return code;
	}

}
