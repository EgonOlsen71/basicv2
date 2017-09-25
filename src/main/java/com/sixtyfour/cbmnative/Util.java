package com.sixtyfour.cbmnative;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.sixtyfour.parser.cbmnative.CodeContainer;

/**
 * @author Foerster-H
 * 
 */
public class Util {
	public static List<CodeContainer> createSingleCommand(String... commands) {
		List<String> after = new ArrayList<String>();
		after.addAll(Arrays.asList(commands));
		CodeContainer cc = new CodeContainer(null, null, after);
		List<CodeContainer> ccs = new ArrayList<CodeContainer>();
		ccs.add(cc);
		return ccs;
	}
}
