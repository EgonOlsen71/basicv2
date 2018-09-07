package com.sixtyfour.cbmnative;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.sixtyfour.parser.cbmnative.CodeContainer;

/**
 * Some static helper methods.
 * 
 * @author EgonOlsen
 * 
 */
public class Util {
    /**
     * Creates native code for a single (BASIC) command by wrapping it into a
     * list of code containers.
     * 
     * @param commands
     *            the commands to wrap
     * @return the code containers
     */
    public static List<CodeContainer> createSingleCommand(String... commands) {
	List<String> after = new ArrayList<String>();
	after.addAll(Arrays.asList(commands));
	CodeContainer cc = new CodeContainer(null, null, after);
	List<CodeContainer> ccs = new ArrayList<CodeContainer>();
	ccs.add(cc);
	return ccs;
    }

    /**
     * Creates an empty command. This is used for DATA, which is a BASIC command
     * that has no equivalent in native code.
     * 
     * @return a code container list with nothing in it
     */
    public static List<CodeContainer> createNoCommand() {
	List<String> after = new ArrayList<String>();
	CodeContainer cc = new CodeContainer(null, null, after);
	List<CodeContainer> ccs = new ArrayList<CodeContainer>();
	ccs.add(cc);
	return ccs;
    }
}
