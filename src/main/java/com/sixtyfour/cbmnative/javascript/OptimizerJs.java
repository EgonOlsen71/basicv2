package com.sixtyfour.cbmnative.javascript;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.Logger;
import com.sixtyfour.cbmnative.Optimizer;
import com.sixtyfour.cbmnative.PlatformProvider;
import com.sixtyfour.cbmnative.ProgressListener;

public class OptimizerJs implements Optimizer {

    private final static int MAX_AHEAD = 4;

    @Override
    public List<String> optimize(PlatformProvider platform, List<String> code) {
	return optimize(platform, code, null);
    }

    @Override
    public List<String> optimize(PlatformProvider platform, List<String> code, ProgressListener pg) {

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
		    i+=2;
		    replaced = true;
		}
		if (lines[0].startsWith("this._zeroflag=(this.") && lines[1].startsWith("if (this._zeroflag")) {
		    int pos = lines[0].indexOf("(");
		    int pos2 = lines[0].lastIndexOf(")");
		    ret.add(lines[1].replace("this._zeroflag", lines[0].substring(pos, pos2 + 1)));
		    i++;
		    replaced = true;
		}

		if (!replaced) {
		    ret.add(lines[0]);
		}

	    }
	    Logger.log("Javascript code optimized in " + (System.currentTimeMillis() - s) + "ms");

	    return ret;
	}

	return code;
    }

}
