package com.sixtyfour.cbmnative;

import java.util.ArrayList;
import java.util.List;

import com.sixtyfour.parser.cbmnative.CodeContainer;

/**
 * @author Foerster-H
 * 
 */
public class Util {
	public static List<CodeContainer> createSingleCommand(String command) {
		List<String> after = new ArrayList<String>();
		after.add(command);
		CodeContainer cc = new CodeContainer(null, null, after);
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();
		ccs.add(cc);
		return ccs;
	}
}
