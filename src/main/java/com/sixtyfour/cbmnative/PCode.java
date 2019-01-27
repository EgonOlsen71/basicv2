package com.sixtyfour.cbmnative;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sixtyfour.cbmnative.crossoptimizer.PCodeOptimizer;
import com.sixtyfour.parser.Line;

/**
 * A wrapper for mapping line numbers to lines in pseudo/intermediate code.
 * 
 * @author EgonOlsen
 *
 */
public class PCode {
    private Map<Integer, Line> lines = new HashMap<Integer, Line>();

    private List<Integer> lineNumbers = new ArrayList<Integer>();

    /**
     * Creates a new instance.
     * 
     * @param lineNumbers
     *            a list of line numbers
     * @param lines
     *            the line number to line mapping
     */
    public PCode(List<Integer> lineNumbers, Map<Integer, Line> lines) {
	this.lineNumbers.addAll(lineNumbers);
	this.lines.putAll(lines);
    }

    /**
     * Returns the mapping from line numbers to lines.
     * 
     * @return the mapping
     */
    public Map<Integer, Line> getLines() {
	return lines;
    }

    /**
     * Returns the list of line numbers.
     * 
     * @return the line numbers
     */
    public List<Integer> getLineNumbers() {
	return lineNumbers;
    }

    public boolean optimize(){
        return PCodeOptimizer.optimize(this);
    }

}
